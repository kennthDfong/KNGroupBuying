//
//  KNSortViewController.m
//  GroupBuying
//
//  Created by ElCapitan on 16/1/22.
//  Copyright © 2016年 Strom. All rights reserved.
//

#import "KNSortViewController.h"
#import "KNSort.h"
#import "KNDataManager.h"
@interface KNSortViewController ()
@property (nonatomic, strong) NSArray *sortArray;
@end

@implementation KNSortViewController
- (NSArray *)sortArray {
    if (_sortArray == nil) {
        _sortArray = [KNDataManager getAllSorts];
    }
    return  _sortArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //边界
    CGFloat inset = 15;
    //button宽和高
    CGFloat buttonWideh = 100;
    CGFloat buttonHeight = 30;
    self.preferredContentSize = CGSizeMake(buttonWideh + 2 *inset, inset + self.sortArray.count * (inset + buttonHeight) + inset);
    for (int i = 0; i < self.sortArray.count; i++) {
        //获取第i个button的数据源
        KNSort *sort = self.sortArray[i];
        //创建button
        UIButton *button = [UIButton new];
        //设置button
        button.frame = CGRectMake(inset, i * (buttonHeight+inset) + inset, buttonWideh, buttonHeight);
        [button setTitle:sort.label forState:UIControlStateNormal];
        //button背景图片
        [button setBackgroundImage:[UIImage imageNamed:@"btn_filter_normal"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"btn_filter_selected"] forState:UIControlStateHighlighted];
        //button颜色
        button.tag = i;
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        //添加
        [self.view addSubview:button];
    }

}

- (void)clickButton:(UIButton *)sender {
    KNSort *sort =  self.sortArray[sender.tag];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    //发送通知～
    [center postNotificationName:@"DisSortChange" object:self userInfo:@{@"sort":sort}];
    //收回当前控制器
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
