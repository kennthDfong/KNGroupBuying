//
//  KNChangeCityController.m
//  GroupBuying
//
//  Created by ElCapitan on 16/1/22.
//  Copyright © 2016年 Strom. All rights reserved.
//

#import "KNChangeCityController.h"
#import "KNDataManager.h"
#import "KNCityGroup.h"
#import "KNCity.h"
@interface KNChangeCityController ()
@property (nonatomic, strong) NSArray *cityGroupArray;
@end

@implementation KNChangeCityController

- (NSArray *)cityGroupArray {
    if (_cityGroupArray == nil) {
        _cityGroupArray = [KNDataManager getAllCityGroup];
    }
    return _cityGroupArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"切换城市";
    
    
    
    
    UIButton *backButton = [UIButton new];
    backButton.frame = CGRectMake(0, 0, 40, 40);
    //忘记了设置frame!!!!!!frame!!!!!!frame!!!!!!frame!!!!!!frame!!!
    [backButton setImage:[UIImage imageNamed:@"btn_navigation_close"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"btn_navigation_close_hl"] forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(clickBackButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];

    self.navigationItem.leftBarButtonItem = backItem;
}

- (void)clickBackButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc {
    NSLog(@"ChangCity被销毁了");
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.cityGroupArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    KNCityGroup *cityGroup = self.cityGroupArray[section];
    return cityGroup.cities.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    KNCityGroup *cityGroup = self.cityGroupArray[indexPath.section];
    NSString *cityName = cityGroup.cities[indexPath.row];
    cell.textLabel.text = cityName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    KNCityGroup *group = self.cityGroupArray[indexPath.section];
    KNCity *city = group.cities[indexPath.row];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DidCityChange" object:self userInfo:@{@"city":city}];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    KNCityGroup *group = self.cityGroupArray[section];
    
    return group.title;
}

@end
