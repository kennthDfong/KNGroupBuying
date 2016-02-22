//
//  KNRegionViewController.m
//  GroupBuying
//
//  Created by ElCapitan on 16/1/22.
//  Copyright © 2016年 Strom. All rights reserved.
//

#import "KNRegionViewController.h"
#import "KNDataManager.h"
#import "KNRegion.h"
#import "KNTbelViewCell.h"
#import "KNChangeCityViewController.h"
#import "KNNaviController.h"
@interface KNRegionViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *mainTableVIew;
@property (weak, nonatomic) IBOutlet UITableView *subTableVIew;
@property (nonatomic, strong) NSArray *regionArray;
@end

@implementation KNRegionViewController

//- (NSArray *)regionArray {
//    if (_regionArray == nil) {
//#warning TODO：修改城市名字
//        _regionArray = [KNDataManager getAllRegionWithCityName:@"广州"];
//     
//    }
//    return _regionArray;
//    
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //监听城市发生的变化
    [self listenCityNotification];
}

- (void)listenCityNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didCityChange:) name:@"DidCityChange" object:nil];
}

- (void)didCityChange:(NSNotification *)notification {
    NSString *cityName =  notification.userInfo[@"city"];
    self.regionArray = [KNDataManager getAllRegionWithCityName:cityName];
    //没想到
    [self.mainTableVIew reloadData];
    [self.subTableVIew reloadData];
}

#pragma mark - tableView delegate And DataSource 

- (NSInteger)tableView:(UITableView *)tableVie numberOfRowsInSection:(NSInteger)section {
    if (tableVie == self.mainTableVIew) {
        return self.regionArray.count;
    } else {
        //右边
        //获取左边的选中行号
        NSInteger selectedRow = [self.mainTableVIew indexPathForSelectedRow].row;
        KNRegion *region = self.regionArray[selectedRow];
        NSLog(@"%ld",region.subregions.count);
        return region.subregions.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {


    if (tableView == self.mainTableVIew) {
        KNTbelViewCell *cell = [KNTbelViewCell  cellWithTableView:self.mainTableVIew
                                                        withImage:@"bg_dropdown_leftpart"
                                                 withHightLighted:@"bg_dropdown_left_selected"];
        KNRegion *region = self.regionArray[indexPath.row];
        cell.region = region;
        return cell;
    } else {
        KNTbelViewCell *cell = [KNTbelViewCell cellWithTableView:self.subTableVIew
                                                       withImage:@"bg_dropdown_rightpart"
                                                withHightLighted:@"bg_dropdown_right_selected"];
        NSInteger selectedRow = [self.mainTableVIew indexPathForSelectedRow].row;
        KNRegion *region =  self.regionArray[selectedRow];
        cell.textLabel.text = region.subregions[indexPath.row];
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.mainTableVIew) {
        [self.subTableVIew reloadData];
        KNRegion *region = self.regionArray[indexPath.row];
        if (region.subregions == 0) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"DidRegionChange" object:self userInfo:@{@"region":region}];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        
    } else {
        NSInteger selectLeftRow = [self.mainTableVIew indexPathForSelectedRow].row;
        NSInteger selectRightRow = [self.subTableVIew indexPathForSelectedRow].row;
        KNRegion *region = self.regionArray[selectLeftRow];
        NSString *subRegionName = region.subregions[selectRightRow];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"DidRegionChange" object:self userInfo:@{@"region":region, @"subRegion":subRegionName}];
        [self dismissViewControllerAnimated:YES completion:nil];

    }
    
}


- (IBAction)clickChangCity:(id)sender {
    
    KNChangeCityViewController *cityViewController = [KNChangeCityViewController new];
    cityViewController.modalPresentationStyle = UIModalPresentationPageSheet;
    //如何是设置size 
    [self presentViewController:cityViewController animated:YES completion:nil];
}



@end
