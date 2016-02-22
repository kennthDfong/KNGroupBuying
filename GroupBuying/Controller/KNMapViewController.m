//
//  KNMapViewController.m
//  GroupBuying
//
//  Created by ElCapitan on 16/1/25.
//  Copyright © 2016年 Strom. All rights reserved.
//

#import "KNMapViewController.h"
#import <MapKit/MapKit.h>
#import "DPAPI.h"
#import "UIBarButtonItem+KNBarItem.h"
#import "KNDataManager.h"
#import "KNDealModel.h"
#import "MBProgressHUD.h"
#import "KNBusiness.h"
#import "KNAnnotation.h"
#import "KNCity.h"
@interface KNMapViewController ()<MKMapViewDelegate, DPRequestDelegate>
@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, strong) CLLocationManager *manager;
@property (nonatomic, strong) NSString *cityName;
@property (nonatomic, strong) CLGeocoder *geoCoder;
@property (nonatomic, strong) DPRequest *latestRequest;

@end

@implementation KNMapViewController

- (CLGeocoder *)geoCoder {
    if (_geoCoder == nil) {
        _geoCoder = [CLGeocoder new];
    }
    return _geoCoder;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"地图";
    
    self.mapView = [[MKMapView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //设置delegate
    self.mapView.delegate = self;
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
    
    self.manager = [CLLocationManager new];
    [self.manager requestWhenInUseAuthorization];
    
    UIBarButtonItem *backItem = [UIBarButtonItem ItemViewImage:@"icon_back" withHIghtLightedImage:@"icon_back_highlighted" withTargrt:self withAction:@selector(clickBackButton)];
    
    self.navigationItem.leftBarButtonItem = backItem;
    
    
    [self.view addSubview:self.mapView];
}

- (void)clickBackButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - MKMapViewDelegate 

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    //发送
    [self.geoCoder reverseGeocodeLocation:userLocation.location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        //一般情况下，之后反悔一个地标对象
        CLPlacemark *placeMark = [placemarks firstObject];
        NSLog(@"%@", placeMark.addressDictionary);
        NSString *cityName = placeMark.addressDictionary[@"City"];
        NSLog(@"city:%@",cityName);
            //北京市 -> 北京
        self.cityName = [cityName substringToIndex:cityName.length - 1];//==========不是count是length==============
       

    }];
    
    [self mapView:mapView regionDidChangeAnimated:YES];
}


- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    DPAPI *api = [DPAPI new];
    
    //先调用这里的方法,为了避免向服务器发送必须参数为空的请求，所以需要在这里进行一次判断

    if (!self.cityName) {
        return;
    }
    
    //设置参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    params[@"city"] = self.cityName;
    params[@"latitude"] = @(mapView.region.center.latitude);
    params[@"longitude"] = @(mapView.region.center.longitude);
    params[@"radius"] = @1000;
    self.latestRequest = [api requestWithURL:@"v1/deal/find_deals" params:params delegate:self];
    
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    //把默认位置排除
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }

    //大头针视图的重用机制
    static NSString *identifier = @"annotation";
    MKAnnotationView *annoView = [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (!annoView) {
        annoView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        //??
        annoView.canShowCallout = YES;
        KNAnnotation *anno = (KNAnnotation *)annotation;
       //
        annoView.image  = anno.image;
    } else {
        //将属性更换一下
        annoView.annotation = annotation;
    }
    //返回大头针视图
    
    return annoView;
}

#pragma mark - 请求相关的方法
- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result {
    if (request != self.latestRequest) {
        return;
    }
    
    
    //解决每次移动都会累加新的大头针～
    //需要清空原来地图视图上的大头针
    //获取地图上的所有大头针对象
    NSArray *array = [NSArray arrayWithArray:self.mapView.annotations];
    //清空
    [self.mapView removeAnnotations:array];
    
    
    NSArray *dealArray = [KNDataManager getDealArrayWithJsonDic:result];
    
    for (KNDealModel *deal in dealArray) {
        KNCategoryModle *category = [KNDataManager getAllCategory:deal];
        
        
     NSArray *businessArray = [KNDataManager getBusinessArrayWithDeals:deal];
        for (KNBusiness *business in businessArray) {
            KNAnnotation *annotation = [KNAnnotation new];
            annotation.coordinate = CLLocationCoordinate2DMake(business.latitude, business.longitude);
            annotation.title =  business.name;
            annotation.subtitle = deal.desc;
            //自定义图片
            if (category) {
            annotation.image = [UIImage imageNamed:category.map_icon];
            } else {
                NSLog(@"无法取到对应的分类");
            }
                //添加
            [self.mapView addAnnotation:annotation];
            
        }
    }
}

- (void)request:(DPRequest *)request didFailWithError:(NSError *)error {
    
    NSLog(@"mapViewRequestError:%@", error.userInfo);
    
}
@end
