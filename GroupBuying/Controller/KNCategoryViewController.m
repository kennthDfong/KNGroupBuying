//
//  KNCategoryViewController.m
//  GroupBuying
//
//  Created by ElCapitan on 16/1/22.
//  Copyright © 2016年 Strom. All rights reserved.
//

#import "KNCategoryViewController.h"
#import "KNDataManager.h"
#import "KNCategoryModle.h"
#import "KNTbelViewCell.h"
@interface KNCategoryViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (weak, nonatomic) IBOutlet UITableView *subTableView;
@property (nonatomic, strong) NSArray *categoryArray;
@property (nonatomic, strong) NSArray *subCategoryArray;

@end

@implementation KNCategoryViewController
- (NSArray *)categoryArray {
    if (_categoryArray == nil) {
        _categoryArray = [KNDataManager getAllCategory];
    }
    return  _categoryArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.preferredContentSize = CGSizeMake(340, 480);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.mainTableView) {
        return self.categoryArray.count;
    } else {
        return self.subCategoryArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.mainTableView) {
        KNCategoryModle *category = self.categoryArray[indexPath.row];
        KNTbelViewCell *cell = [KNTbelViewCell cellWithTableView:tableView
                                                       withImage:@"bg_dropdown_leftpart"
                                                withHightLighted:@"bg_dropdown_left_selected"];
        [cell setCategory:category];
        return cell;

    } else {
        KNTbelViewCell *cell = [KNTbelViewCell cellWithTableView:tableView
                                                       withImage:@"bg_dropdown_rightpart"
                                                withHightLighted:@"bg_dropdown_right_selected"];
        cell.textLabel.text = self.subCategoryArray[indexPath.row];
        return cell;
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.mainTableView) {
        KNCategoryModle *catagory = self.categoryArray[indexPath.row];
        self.subCategoryArray = catagory.subcategories;
        //这里需要reload 那么，会不会影响dataReload
        [self.subTableView reloadData];
        if (catagory.subcategories.count == 0) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"DidCategoryChange" object:self userInfo:@{@"category":catagory}];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    } else {
        NSInteger selectedLeftRow = [self.mainTableView indexPathForSelectedRow].row;
        KNCategoryModle *category = self.categoryArray[selectedLeftRow];
        NSString *subcategoryName = category.subcategories[indexPath.row];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"DidCategoryChange" object:self userInfo:@{@"category":category, @"subCategoryName":subcategoryName}];
            [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}
@end
