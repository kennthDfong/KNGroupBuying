//
//  KNCategoryModle.h
//  GroupBuying
//
//  Created by ElCapitan on 16/1/20.
//  Copyright © 2016年 Strom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KNsubcategoryModel.h"
@interface KNCategoryModle : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray *subcategories;
@property (nonatomic, strong) NSString *map_icon;
@property (nonatomic, strong) NSString *highlighted_icon;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *small_highlighted_icon;
@property (nonatomic, strong) NSString *small_icon;
//+ (instancetype)parseCategoryByDic:(NSDictionary *)Dic;
@end
