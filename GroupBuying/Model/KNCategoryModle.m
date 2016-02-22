//
//  KNCategoryModle.m
//  GroupBuying
//
//  Created by ElCapitan on 16/1/20.
//  Copyright © 2016年 Strom. All rights reserved.
//

#import "KNCategoryModle.h"
#import "KNDataManager.h"
@implementation KNCategoryModle


//+ (instancetype)parseCategoryByDic:(NSDictionary *)Dic {
//    return [[KNCategoryModle alloc] parseCategoryByDic:Dic];
//}
//
//- (instancetype)parseCategoryByDic:(NSDictionary *)Dic {
//    [self setValuesForKeysWithDictionary:Dic];
//    ///*=======================================================
//    self.name = Dic[@"category_name"];
//    self.subcategories = [KNDataManager getSubcategoriesByArray:Dic[@"subcategories"]];
//    //==========================================================*/
//    return self;
//}

//其实根本不需要这样子的，我想试试一个方法
//- (void)setValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues {
//    [super setValuesForKeysWithDictionary:keyedValues];
//    //假如成功的话，这里会造成多了一步，已经赋值的属性，会被新的赋值覆盖一遍
//    //在这里其实上面绿色的方法会更好
//    self.subcategories = [KNDataManager getSubcategoriesByArray:keyedValues[@"subcategories"]];
//}
@end
