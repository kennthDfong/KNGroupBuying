//
//  KNCity.h
//  GroupBuying
//
//  Created by ElCapitan on 16/1/21.
//  Copyright © 2016年 Strom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KNRegion.h"
@interface KNCity : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *pinYin;
@property (nonatomic, strong) NSString *pinYinHead;
@property (nonatomic, strong) NSArray *regions;
@end
