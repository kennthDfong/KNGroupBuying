//
//  ViewController.m
//  GroupBuying
//
//  Created by ElCapitan on 16/1/20.
//  Copyright © 2016年 Strom. All rights reserved.
//

#import "ViewController.h"
#import "DPAPI.h"
#import "KNDataManager.h"
@interface ViewController ()<DPRequestDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
   // NSArray *array = [KNDataManager getAllCategory];
    
    DPAPI *api = [DPAPI new];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    //hrad code
    params[@"city"] = @"广州";
    params[@"limit"] = @40;
    params[@"sort"] = @3;
    [api requestWithURL:@"v1/deal/find_deals" params:params delegate:self];
  
    
    
    
}

- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result {
    
    //如果两个回调回来的事件是同时的话，会有怎么样的后果呢？
    NSArray *testArray = [KNDataManager getDealArrayWithJsonDic:result];
    NSLog(@"线程：%@，%@",[NSThread currentThread],testArray);
}

- (void)request:(DPRequest *)request didFailWithError:(NSError *)error {
    NSLog(@"error:%@", error.userInfo);
}

@end
