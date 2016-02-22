//
//  KNDataManager.h
//  GroupBuying
//
//  Created by ElCapitan on 16/1/20.
//  Copyright © 2016年 Strom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KNDealModel.h"
#import "KNCategoryModle.h"
@interface KNDataManager : NSObject

+ (NSArray *)getDealArrayWithJsonDic:(NSDictionary *)json;

+ (NSArray *)getBusinessArrayWithDeals:(KNDealModel *)deal;

+ (NSArray *)getAllCategory;

+ (NSArray *)getAllCity;

+ (NSArray *)getAllRegionWithCityName:(NSString *)cityName;

+ (NSArray *)getAllCityGroup;

+ (NSArray *)getAllSorts;

//制动某一个订单对性爱那个，返回这个订单所属的分类对象（给到头真添加自定义图片）

+ (KNCategoryModle *)getAllCategory:(KNDealModel *)deal;



/*=====================================================================
+ (NSArray *)getSubcategoriesByArray:(NSArray *)subCateArray;

+ (NSArray *)getAllCateGoriesByArray:(NSDictionary *)jsonDic;
=====================================================================*/
 @end
