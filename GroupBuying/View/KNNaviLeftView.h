//
//  KNNaviLeftView.h
//  GroupBuying
//
//  Created by ElCapitan on 16/1/21.
//  Copyright © 2016年 Strom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KNNaviLeftView : UIView

@property (weak, nonatomic) IBOutlet UILabel *mainLbabel;

@property (weak, nonatomic) IBOutlet UILabel *subLabel;
@property (weak, nonatomic) IBOutlet UIButton *ImageButton;

+ (KNNaviLeftView *)getNaviView;
@end
