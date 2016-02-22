//
//  KNDealsModel.h
//  GroupBuying
//
//  Created by ElCapitan on 16/1/20.
//  Copyright © 2016年 Strom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KNDealModel : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSNumber *list_price;
@property (nonatomic, strong) NSNumber *current_price;
@property (nonatomic, strong) NSString *image_url;
@property (nonatomic, strong) NSNumber *purchase_count;
@property (nonatomic, strong) NSArray *businesses;
//所有分类数组
@property (nonatomic, strong) NSArray *categories;
+ (instancetype)parseDealByDic:(id)dic;
@end
