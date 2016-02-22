//
//  KNSeatchViewController.m
//  GroupBuying
//
//  Created by ElCapitan on 16/1/23.
//  Copyright © 2016年 Strom. All rights reserved.
//

#import "KNSeatchViewController.h"
#import "UIBarButtonItem+KNBarItem.h"

@interface KNBasicController ()<UISearchBarDelegate>

@end

@implementation KNSeatchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *backItem = [UIBarButtonItem ItemViewImage:@"icon_back" withHIghtLightedImage:@"icon_back_highlight" withTargrt:self withAction:@selector(clickBackItem)];
    self.navigationItem.leftBarButtonItem = backItem;
    //UISearchBar
    UISearchBar *serchBar = [UISearchBar new];
    serchBar.placeholder = @"请输入搜索关键词";//????
    serchBar.delegate = self;
    //???????????????
    self.navigationItem.titleView = serchBar;

    self.collectionView.backgroundColor = [UIColor whiteColor];
}


- (void)clickBackItem {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self loadNewDeals];
    [searchBar resignFirstResponder];
}
//实现父类的设置参数的方法
- (void)settingParams:(NSMutableDictionary *)params {
    //获取用户输入的文本
    //设置给params

    //需要转类型，才能获取search的属性
    UISearchBar *searchBar = (UISearchBar *)self.navigationItem.titleView;
    params[@"keyword"] = searchBar.text;
    params[@"city"] = self.selectCity;
    
}
@end
