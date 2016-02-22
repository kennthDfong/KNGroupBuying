//
//  KNsubcategoryModel.h
//  GroupBuying
//
//  Created by ElCapitan on 16/1/20.
//  Copyright © 2016年 Strom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KNsubcategoryModel : NSObject
@property (nonatomic, strong) NSString *category_name;
@property (nonatomic, strong) NSArray *subcategories;
+ (instancetype)parseubcategoryByDic:(NSDictionary *)dic;
@end
