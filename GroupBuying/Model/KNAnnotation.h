//
//  KNAnnotation.h
//  GroupBuying
//
//  Created by ElCapitan on 16/1/25.
//  Copyright © 2016年 Strom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <UIKit/UIKit.h>
@interface KNAnnotation : NSObject<MKAnnotation>
//必须声明位置

@property (nonatomic) CLLocationCoordinate2D coordinate;

//两个可选title/subtitle

@property (nonatomic, copy, nullable) NSString *title;
@property (nonatomic, copy, nullable) NSString *subtitle;
//图片属性  自定义属性
@property (nonatomic, strong) UIImage *image;
@end
