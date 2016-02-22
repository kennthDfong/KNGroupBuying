//
//  UIBarButtonItem+KNBarItem.h
//  GroupBuying
//
//  Created by ElCapitan on 16/1/21.
//  Copyright © 2016年 Strom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (KNBarItem)

+ (UIBarButtonItem *)ItemViewImage:(NSString *)imageName
             withHIghtLightedImage:(NSString *)HLImageName
                        withTargrt:(id)target
                        withAction:(SEL)action;
@end
