//
//  KNDealsModel.m
//  GroupBuying
//
//  Created by ElCapitan on 16/1/20.
//  Copyright © 2016年 Strom. All rights reserved.
//

#import "KNDealModel.h"

@implementation KNDealModel

+ (instancetype)parseDealByDic:(id)dic {
    return [[KNDealModel alloc]parseDealByDic:dic];
}

- (instancetype)parseDealByDic:(id)dic {
    [self setValuesForKeysWithDictionary:dic];
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"description"]) {
        self.desc = value;
    }
}

@end
