//
//  KNNaviLeftView.m
//  GroupBuying
//
//  Created by ElCapitan on 16/1/21.
//  Copyright © 2016年 Strom. All rights reserved.
//

#import "KNNaviLeftView.h"

@implementation KNNaviLeftView

+ (KNNaviLeftView *)getNaviView {
    return  [[NSBundle mainBundle] loadNibNamed:@"KNNaviLeftView" owner:self options:nil].firstObject;
    
}
//防止拉伸
//XIB本质就是在解档～
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.autoresizingMask = UIViewAutoresizingNone;
    }
    return self;
}

@end
