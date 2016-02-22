//
//  KNBusiness.h
//  GroupBuying
//
//  Created by ElCapitan on 16/1/25.
//  Copyright © 2016年 Strom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KNBusiness : NSObject

@property (nonatomic, strong) NSString *name;
//为了不用转类型
@property (nonatomic, assign) double latitude;
@property (nonatomic, assign) double longitude;
//id可以直接写
@property (nonatomic, strong) NSNumber *id;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *h5_url;

@end
