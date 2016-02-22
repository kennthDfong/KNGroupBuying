//
//  KNsubcategoryModel.m
//  GroupBuying
//
//  Created by ElCapitan on 16/1/20.
//  Copyright © 2016年 Strom. All rights reserved.
//

#import "KNsubcategoryModel.h"

@implementation KNsubcategoryModel
+ (instancetype)parseubcategoryByDic:(NSDictionary *)dic {
    return [[KNsubcategoryModel alloc]parseubcategoryByDic:dic];
}

- (instancetype)parseubcategoryByDic:(NSDictionary *)dic {
    [self setValuesForKeysWithDictionary:dic];
    return self;
}
@end
