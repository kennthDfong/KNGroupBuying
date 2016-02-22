//
//  KNChangeCityViewController.m
//  GroupBuying
//
//  Created by ElCapitan on 16/1/23.
//  Copyright © 2016年 Strom. All rights reserved.
//

#import "KNChangeCityViewController.h"
#import "KNDataManager.h"
#import "KNCityGroup.h"
@interface KNChangeCityViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray *cityGroupArray;

@end

@implementation KNChangeCityViewController

- (NSArray *)cityGroupArray {
    if (_cityGroupArray == nil) {
        _cityGroupArray = [KNDataManager getAllCityGroup];
    }
    return _cityGroupArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    KNCityGroup *group = self.cityGroupArray[section];
    return group.cities.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.cityGroupArray.count;
}

- (IBAction)clickCloseButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    KNCityGroup *cityGroup = self.cityGroupArray[indexPath.section];
    cell.textLabel.text = cityGroup.cities[indexPath.row];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
     KNCityGroup *cityGroup = self.cityGroupArray[section];
    return cityGroup.title;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //获取名字
    KNCityGroup *cityGroup = self.cityGroupArray[indexPath.section];
    NSString *cityName = cityGroup.cities[indexPath.row];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DidCityChange" object:self userInfo:@{@"city":cityName}];
    //她使用的是两个地方监听
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return [self.cityGroupArray valueForKeyPath:@"title"];
}



@end
