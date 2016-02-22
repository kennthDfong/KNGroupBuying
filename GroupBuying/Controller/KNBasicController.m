//
//  KNBasicController.m
//  GroupBuying
//
//  Created by ElCapitan on 16/1/23.
//  Copyright © 2016年 Strom. All rights reserved.
//

#import "KNBasicController.h"
#import "UIBarButtonItem+KNBarItem.h"
#import "KNNaviLeftView.h"
#import "KNDataManager.h"
#import "KNSortViewController.h"
#import "KNCategoryViewController.h"
#import "KNRegionViewController.h"
#import "KNSort.h"
#import "KNCategoryModle.h"
#import "KNRegion.h"
#import "DPAPI.h"
#import "KNCity.h"
#import "KNDealModel.h"
#import "KNCollectionViewCell.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"


@interface KNBasicController()<DPRequestDelegate>
@property (nonatomic, strong) NSMutableArray *dealArray;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) DPRequest *userLatestRequest;


@end


@implementation KNBasicController

static NSString * const reuseIdentifier = @"Cell";

- (NSMutableArray *)dealArray {
    if (_dealArray == nil) {
        _dealArray = [NSMutableArray array];
    }
    return  _dealArray;
}
//collectionView 是必须要有layout ～在初始化的时候给collection layout
- (instancetype)init {
      UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    if (self =  [super init]) {
        layout.itemSize = CGSizeMake(305, 305);
        layout.sectionInset= UIEdgeInsetsMake(0, 20, 0, 20);
    }
    return [self initWithCollectionViewLayout:layout];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView registerNib:[UINib
                      nibWithNibName:@"KNCollectionViewCell"
                              bundle:[NSBundle mainBundle]]
          forCellWithReuseIdentifier:reuseIdentifier];
    

    
    //加载默认请求
    [self loadNewDeals];
    //为什么不可以传参数呢，是因为参数不够么
    //常见上啦加载的空间
    [self setUpRefreshControl];

}

#pragma mark -  发送请求相关方法
- (void)setUpRefreshControl {
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreDeals)];
}

//上拉的时候加载更多的订单
- (void)loadMoreDeals {
    self.page++;
    [self sendRequestToSever];
}



- (void)loadNewDeals {
    self.page = 1;
    //在更换了选择之后，发送新请求之前，需要清空数组
    
    // [self.dealArray removeAllObjects];
    // 转换参数，但是返回失败之后，再下拉会因为数组清空而发生奔溃  ***
    [self sendRequestToSever];
}


//第一次加载
- (void)sendRequestToSever {
    DPAPI *api = [DPAPI new];

    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    params[@"page"] = [NSNumber numberWithInteger:self.page];

    
    params[@"city"] = @"广州";
    
    //如果子类没有这个方法的话，那么该怎么办呢??
    [self settingParams:params];
    NSLog(@"params : %@" ,params);
    self.userLatestRequest = [api requestWithURL:@"v1/deal/find_deals" params:params delegate:self];
    
}

- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result {
    if (request != self.userLatestRequest) {
        return;
    }
    //判断是用户请求的是某一个分类的第一页～成功返回才将数组清空～ ***
    if (self.page == 1) {
    [self.dealArray removeAllObjects];
    }
    NSArray *array = [KNDataManager getDealArrayWithJsonDic:result];
    [self.dealArray addObjectsFromArray:array];
    [self.collectionView reloadData];
    [self.collectionView.mj_footer endRefreshing];
}

- (void)request:(DPRequest *)request didFailWithError:(NSError *)error {
    [self.collectionView.mj_footer endRefreshing];
    NSLog(@"error:%@" , error.userInfo);
    //创建空间                                      //这里不是应该collectionView吗
    MBProgressHUD *HUB = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUB.mode =  MBProgressHUDModeText;
    //
    HUB.labelText = @"网络繁忙，请稍后再试";
    HUB.margin = 10;
    //延迟时间
    [HUB hide:YES afterDelay:3];
}


#pragma mark <UICollectionViewDataSource>


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    //重新请求之后，刷新界面时，不会进入这里
    return self.dealArray.count;

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    KNCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];

    
    
    KNDealModel *deal = self.dealArray[indexPath.item];
    cell.deal = deal;
    return cell;
}

@end
