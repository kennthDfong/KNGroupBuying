//
//  KNMasterViewController.m
//  GroupBuying
//
//  Created by ElCapitan on 16/1/21.
//  Copyright © 2016年 Strom. All rights reserved.
//

#import "KNMasterViewController.h"
#import "UIBarButtonItem+KNBarItem.h"
#import "KNNaviLeftView.h"
#import "KNDataManager.h"
#import "KNSortViewController.h"
#import "KNCategoryViewController.h"
#import "KNRegionViewController.h"
#import "KNSort.h"
#import "KNCategoryModle.h"
#import "KNRegion.h"
#import "DPAPI.h"
#import "KNCity.h"
#import "KNDealModel.h"
#import "KNCollectionViewCell.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"
#import "KNSeatchViewController.h"
#import "KNNaviController.h"
#import "KNMapViewController.h"
@interface KNMasterViewController ()

@property (nonatomic, strong) KNNaviLeftView *categoryView;
@property (nonatomic, strong) KNNaviLeftView *regionView;
@property (nonatomic, strong) KNNaviLeftView *sortView;
@property (nonatomic, strong) KNSortViewController *sortViewController;
@property (nonatomic, strong) KNRegionViewController *regionViewController;
@property (nonatomic, strong) KNCategoryViewController *categoryViewController;
@property (nonatomic, strong) NSString *selectedRegionName;
@property (nonatomic, strong) NSString *selectedSubRegionName;
@property (nonatomic, strong) NSNumber *selectedSort;
@property (nonatomic, strong) NSString *selectedCategoryName;
@property (nonatomic, strong) NSString *selectedSubCategoryName;
@property (nonatomic, strong) NSString *selectedCity;

@end

@implementation KNMasterViewController

static NSString * const reuseIdentifier = @"Cell";



- (KNSortViewController *)sortViewController {
    if (_sortViewController == nil) {
        _sortViewController = [KNSortViewController new];
    }
    return _sortViewController;
}

- (KNRegionViewController *)regionViewController {
    if (_regionViewController == nil) {
        _regionViewController = [KNRegionViewController new];
    }
    return _regionViewController;
}

- (KNCategoryViewController *)categoryViewController {
    if (_categoryViewController == nil) {
        _categoryViewController = [KNCategoryViewController new];
    }
    return _categoryViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    self.selectedCity = @"广州";
    // Register cell classes
    //这样才是从xib中加载视图
    // Do any additional setup after loading the view.
    [self setUpRightItem];
    [self setUpLeftItem];
    //开始监听
    [self listenNotifications];
    
}


#pragma mark - listNotification 
- (void)listenNotifications {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(didSortChange:) name:@"DisSortChange" object:nil];
    //比较乱不适合用通知，不使用通知的话使用什么会更好呢？？
    [center addObserver:self selector:@selector(didRegionChange:) name:@"DidRegionChange" object:nil];
    [center addObserver:self selector:@selector(didCotegoryChange:) name:@"DidCategoryChange" object:nil];
    [center addObserver:self selector:@selector(didCityChange:) name:@"DidCityChange" object:nil];
}


- (void)didSortChange:(NSNotification *)notification {
    KNSort *sort = notification.userInfo[@"sort"];
    self.sortView.subLabel.text = sort.label;
    //self.sortView.ImageButton.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    self.selectedSort = sort.value;
    [self loadNewDeals];
}

- (void)didRegionChange:(NSNotification *)notification {
    KNRegion *region = notification.userInfo[@"region"];
    
        NSString *subRegionName = notification.userInfo[@"subRegion"];
        self.regionView.subLabel.text = subRegionName;
        self.selectedSubRegionName = subRegionName;
    [self loadNewDeals];

    //本来我加入了判断的设置，其实是不需要的～因为在没有子视图的时候就顺便能将text清空了
    self.regionView.mainLbabel.text = [NSString stringWithFormat:@"%@-%@",self.selectedCity, region.name];
    
    
    self.selectedRegionName = region.name;

    
}


- (void)didCotegoryChange:(NSNotification *)notification {
    KNCategoryModle *category = notification.userInfo[@"category"];
    if (notification.userInfo[@"subCategoryName"]) {
        self.categoryView.subLabel.text = notification.userInfo[@"subCategoryName"];
    self.selectedSubCategoryName = notification.userInfo[@"subCategoryName"];
    }
    self.categoryView.mainLbabel.text = category.name;
    [self.categoryView.ImageButton setImage:[UIImage imageNamed:category.icon] forState:UIControlStateNormal];
    [self.categoryView.ImageButton setImage:[UIImage imageNamed:category.highlighted_icon] forState:UIControlStateHighlighted];
    self.selectedCategoryName = category.name;
    [self loadNewDeals];
}

- (void)didCityChange:(NSNotification *)notification {
    NSString *cityName = notification.userInfo[@"city"];
    self.selectedCity = cityName;
    //选择了之后初始化为全部
    self.regionView.mainLbabel.text = [NSString stringWithFormat:@"%@-全部" ,self.selectedCity];
    [self loadNewDeals];
}



#pragma mark -  navigation item 相关方法
- (void)setUpRightItem {
    UIBarButtonItem *mapItem = [UIBarButtonItem ItemViewImage:@"icon_map"
                                        withHIghtLightedImage:@"icon_map_highLighted"
                                                   withTargrt:self
                                                   withAction:@selector(cilckMapItem)];
    
    UIBarButtonItem *searchItem = [UIBarButtonItem ItemViewImage:@"icon_search"
                                           withHIghtLightedImage:@"icon_search_highLighted"
                                                      withTargrt:self
                                                      withAction:@selector(clickSearchItem)];
    self.navigationItem.rightBarButtonItems = @[mapItem, searchItem];
    
    
}

- (void)setUpLeftItem {
    //systemStyleDone是什么来的呢
    UIBarButtonItem *logoItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_meituan_logo"] style:UIBarButtonItemStyleDone target:nil action:nil];
    //返回的是数组，可以通过tag值来取数组中指定的一个～或者是对应的类型～
   
    //创建分类视图
    self.categoryView = [KNNaviLeftView getNaviView];
    UIBarButtonItem *categoryItem = [[UIBarButtonItem alloc] initWithCustomView:self.categoryView];
    [self.categoryView.ImageButton addTarget:self
                                      action:@selector(clickCaregoryButton)
                            forControlEvents:UIControlEventTouchUpInside];
    
    //创建区域
    self.regionView = [KNNaviLeftView getNaviView];
    self.regionView.mainLbabel.text = @"城市-";
    self.regionView.subLabel.text = @"区域";
    [self.regionView.ImageButton setImage:[UIImage
                               imageNamed:@"btn_changeCity"]
                                 forState:UIControlStateNormal];
    
    [self.regionView.ImageButton setImage:[UIImage
                               imageNamed:@"btn_changeCity_selected"]
                                 forState:UIControlStateHighlighted];
    
    UIBarButtonItem *regionView = [[UIBarButtonItem alloc]
                                   initWithCustomView:self.regionView];

    [self.regionView.ImageButton addTarget:self
                                    action:@selector(clickRegionItem)
                          forControlEvents:UIControlEventTouchUpInside];

    //创建排序
    self.sortView = [KNNaviLeftView getNaviView];
    self.sortView.mainLbabel.text = @"排序";
    self.sortView.subLabel.text = @"默认排序";
    [self.sortView.ImageButton setImage:[UIImage imageNamed:@"icon_sort"]
                               forState:UIControlStateNormal];
    
    [self.sortView.ImageButton setImage:[UIImage imageNamed:@"icon_sort_hightlighted"]
                               forState:UIControlStateHighlighted];
    
    UIBarButtonItem *sortItem = [[UIBarButtonItem alloc]
                                 initWithCustomView:self.sortView];
    
    [self.sortView.ImageButton addTarget:self
                                  action:@selector(clickSortItem)
                        forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItems = @[logoItem, categoryItem, regionView, sortItem];
}
#pragma mark - 点中item的触发方法

- (void)clickCaregoryButton {
    [self prsentPopOverViewWithBarItemView:self.categoryView
                            withController:self.categoryViewController];
    
}

- (void)clickRegionItem {

    [self prsentPopOverViewWithBarItemView:self.regionView
                            withController:self.regionViewController];
    
}

- (void)clickSortItem {

    [self prsentPopOverViewWithBarItemView:self.sortView
                            withController:self.sortViewController];
}

- (void)cilckMapItem {
    KNMapViewController *mapController = [KNMapViewController new];
    KNNaviController *naviController = [[KNNaviController alloc] initWithRootViewController:mapController];
    [self presentViewController:naviController animated:YES completion:nil];
}

- (void)clickSearchItem {
    KNSeatchViewController *searchControll = [KNSeatchViewController new];
    //方式一，穿参数
    if (self.selectedCity) {
    searchControll.selectCity = self.selectedCity;
    } else {
    searchControll.selectCity = @"广州";
    }
    //方式二，接收通知
    
    KNNaviController *navi = [[KNNaviController alloc]initWithRootViewController:searchControll];
    [self presentViewController:navi animated:YES completion:nil];

    
}


#pragma mark - popoverView
//static UIViewController *vc = nil;
- (void)prsentPopOverViewWithBarItemView:(KNNaviLeftView *)itemView withController:(UIViewController *)vc {
//    KNPopTableController *vc = [KNPopTableController new];
//    vc.dataClass = class;
    //控制器还有一些属性
    //设置view的样式,带剪头
    
    vc.modalPresentationStyle = UIModalPresentationPopover;
    //设置剪头弹出的控件是哪个
    vc.popoverPresentationController.sourceView = itemView;
    //设置相对与View的位置
    vc.popoverPresentationController.sourceRect = itemView.bounds;
//    if (vc == self.regionViewController) {
//     //每次推出新的vc时候，都将持有的city传过去~以保证和用户选择的是同一个城市
//        self.regionViewController.cityName = self.selectedCity;
//    }
    
    [self presentViewController:vc animated:YES completion:nil];
    
}

- (void)settingParams:(NSMutableDictionary *)params {
    //必须选择发送城市
    //    params[@"city"] = self.selectedCity ? self.selectedCity : @"广州";
    //我本来的写法
    if (self.selectedCity) {
        params[@"city"] = self.selectedCity;
    } else {
        //将上次的选择数据持久化，每次打开自动取上次选择的城市.
        params[@"city"] = @"广州";
    }
    
    
    if (self.selectedSort) {
        params[@"sort"] = self.selectedSort;
    }
    //发送主区域
    if (self.selectedRegionName) {
        if (self.selectedSubRegionName) {
            params[@"region"] = self.selectedSubRegionName;
        }
        else {
            params[@"region"] = self.selectedCategoryName;
        }
    }
    
    if (self.selectedCategoryName) {
        if (self.selectedSubCategoryName) {
            params[@"category"] = self.selectedSubCategoryName;
        } else {
            params[@"category"] = self.selectedCategoryName;
        }
        
    }
    
    NSLog(@"%@", reuseIdentifier);
  
   
}

- (void)dealloc {
    //这句会全部移除掉通知，是因为如果不
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
