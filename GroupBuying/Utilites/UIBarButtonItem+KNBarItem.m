//
//  UIBarButtonItem+KNBarItem.m
//  GroupBuying
//
//  Created by ElCapitan on 16/1/21.
//  Copyright © 2016年 Strom. All rights reserved.
//

#import "UIBarButtonItem+KNBarItem.h"

@implementation UIBarButtonItem (KNBarItem)

+ (UIBarButtonItem *)ItemViewImage:(NSString *)imageName withHIghtLightedImage:(NSString *)HLImageName withTargrt:(id)target withAction:(SEL)action {
    UIButton *button = [UIButton new];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:HLImageName] forState:UIControlStateHighlighted];
    button.frame = CGRectMake(0, 0, 80, 40);
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}
@end
