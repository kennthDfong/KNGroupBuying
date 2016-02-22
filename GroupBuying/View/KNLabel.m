//
//  KNLabel.m
//  GroupBuying
//
//  Created by ElCapitan on 16/1/23.
//  Copyright © 2016年 Strom. All rights reserved.
//

#import "KNLabel.h"

@implementation KNLabel

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    //rect
    CGContextRef context = UIGraphicsGetCurrentContext();
    //移动到起点
    CGContextMoveToPoint(context, 0, rect.size.height * 0.5);
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height * 0.5);

    CGContextStrokePath(context);
}

@end
