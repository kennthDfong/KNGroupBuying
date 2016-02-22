//
//  KNDataManager.m
//  GroupBuying
//
//  Created by ElCapitan on 16/1/20.
//  Copyright © 2016年 Strom. All rights reserved.
//

#import "KNDataManager.h"
#import "KNsubcategoryModel.h"
#import "KNCategoryModle.h"
#import "KNCity.h"
#import "KNCityGroup.h"
#import "KNSort.h"
#import "KNBusiness.h"
@implementation KNDataManager
+ (NSArray *)getDealArrayWithJsonDic:(id)json {
    NSArray *dealArray = json[@"deals"];
    
    /*======================================================================
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (NSDictionary *dealDci in dealArray) {
        //因为是用自动解析，也许在这里加上一句，也许比在model中写一大段会更好
        KNDealModel *deal = [KNDealModel parseDealByDic:dealDci];
        [mutableArray addObject:deal];
    }
    return [mutableArray copy];
     ================================================================================*/
    return [[KNDataManager alloc] convertDictionaryToModel:[KNDealModel class] withArray:dealArray];
}

+ (NSArray *)getBusinessArrayWithDeals:(KNDealModel *)deal {
    return [[KNDataManager alloc] convertDictionaryToModel:[KNBusiness class] withArray:deal.businesses];
}

static NSArray *_categoryArray = nil;

+ (NSArray *)getAllCategory {
    if (_categoryArray == nil) {
        _categoryArray = [[self alloc] getAllPlistData:@"categories.plist" withClass:[KNCategoryModle class]];
    }
    return _categoryArray;
}

static NSArray *_cityArray = nil;

+ (NSArray *)getAllCity {
    if (_cityArray == nil) {
        _cityArray = [[KNDataManager alloc]getAllPlistData:@"cities.plist" withClass:[KNCity class]];
    }
    return _cityArray;
}


+ (NSArray *)getAllRegionWithCityName:(NSString *)cityName {
    NSArray *cityArray = [self getAllCity];
    NSArray *regionArray = nil;
    
    for (KNCity *city in cityArray) {
        if ([city.name isEqualToString:cityName]) {
         //找到城市模型对象
            regionArray = [[self alloc]convertDictionaryToModel:[KNRegion class] withArray:city.regions];
            
            break;
        }
    }
    return regionArray;
    
}

static NSArray *_cityGroup;
+ (NSArray *)getAllCityGroup {
    if (_cityGroup == nil) {
        _cityGroup = [[self alloc]getAllPlistData:@"cityGroups.plist" withClass:[KNCityGroup class]];
    }
    return _cityGroup;
}

static NSArray *_sortArray = nil;
+ (NSArray *)getAllSorts {
    if (_sortArray == nil) {
        _sortArray = [[self alloc]getAllPlistData:@"sorts.plist" withClass:[KNSort class]];
    }
    return _sortArray;
}


- (NSArray *)getAllPlistData:(NSString *)fileName withClass:(Class)modelClass {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
    NSArray *plistArray = [NSArray arrayWithContentsOfFile:plistPath];
    
    return [self convertDictionaryToModel:modelClass withArray:plistArray];
}


- (NSArray *)convertDictionaryToModel:(Class)modelClass withArray:(NSArray *)array{
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (NSDictionary *EverItemDic in array) {
        id newInstance = [modelClass new];
        [newInstance setValuesForKeysWithDictionary:EverItemDic];
        [mutableArray addObject:newInstance];
    }
    return [mutableArray copy];
    
}

+ (KNCategoryModle *)getAllCategory:(KNDealModel *)deal {
   //获取所有分类数据
    NSArray *categoryArray = [self getAllCategory];
    
  //  static KNCategoryModle *targetCategory = nil;
    for (NSString *categoryStr  in deal.categories) {
        for (KNCategoryModle *compareCategory in categoryArray) {
            if (categoryStr == compareCategory.name) {
                
                return compareCategory;
            } else {
                if ([compareCategory.subcategories containsObject:categoryStr]) {
                    return compareCategory;
                }
            
            }
            
        }
    }
    
    //找不到任何人类
    return nil;
}

/*======================================================================================

+ (NSArray *)getSubcategoriesByArray:(NSArray *)subCateArray {
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (NSDictionary *subCateDic in subCateArray) {
        //同上
        KNsubcategoryModel *subCate = [KNsubcategoryModel parseubcategoryByDic:subCateDic];
        [mutableArray addObject:subCate];
    }
    return [mutableArray copy];
}

+ (NSArray *)getAllCateGoriesByArray:(NSDictionary *)jsonDic {
    NSMutableArray *mutableArray = [NSMutableArray array];
    NSArray *cateArray = jsonDic[@"categories"];
    for (NSDictionary *dic in cateArray) {
        //同上
        KNCategoryModle *cateModle = [KNCategoryModle parseCategoryByDic:dic];
        [mutableArray addObject:cateModle];
    }
    return [mutableArray copy];
}
 ====================================================================================*/
@end
