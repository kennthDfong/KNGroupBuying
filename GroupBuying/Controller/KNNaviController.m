//
//  KNNaviController.m
//  GroupBuying
//
//  Created by ElCapitan on 16/1/21.
//  Copyright © 2016年 Strom. All rights reserved.
//

#import "KNNaviController.h"

@interface KNNaviController ()

@end

@implementation KNNaviController

- (void)viewDidLoad {
    [super viewDidLoad];
    //后去navigationBar,
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBackgroundImage:[UIImage imageNamed:@"bg_navigationBar_normal"] forBarMetrics:UIBarMetricsDefault];
    //设置图片
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
