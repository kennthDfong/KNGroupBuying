//
//  KNTbelViewCell.m
//  GroupBuying
//
//  Created by ElCapitan on 16/1/22.
//  Copyright © 2016年 Strom. All rights reserved.
//

#import "KNTbelViewCell.h"



@implementation KNTbelViewCell


- (void)setRegion:(KNRegion *)region {
    self.textLabel.text = region.name;
    if (region.subregions.count > 0) {
        
        self.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_cell_rightArrow"]];
    } else {
        //没有子区域~重用时，需要致空
        self.accessoryView = nil;
    }
}

+ (KNTbelViewCell *)cellWithTableView:(UITableView *)tableView withImage:(NSString *)imageName withHightLighted:(NSString *)hlImageName {
    static NSString *identifier = @"cell";
    KNTbelViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    //可以这样用～cell的作用域不同
    if (cell == nil) {
        cell = [[KNTbelViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:hlImageName]];
    
    
    return cell;
}
/*====================================================================
+ (KNTbelViewCell *)cellWithTableView:(UITableView *)tableView withCategory:(KNCategoryModle *)category  withImageName:(NSString *)imageName withHilghtLightedImageName:(NSString *)hlImageName{
    
    static NSString *identifier = @"cell";
    KNTbelViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[KNTbelViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if (category.subcategories.count > 0) {
        cell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_cell_rightArrow"]];
    } else {
        cell.accessoryView = nil;
    }
    cell.imageView.image = [UIImage imageNamed:category.icon];
    
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:hlImageName]];
    cell.textLabel.text = category.name;
    return cell;
}
===================================================================*/
- (void)setCategory:(KNCategoryModle *)category {
    if (category.subcategories.count > 0) {
        self.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_cell_rightArrow"]];
    } else {
        self.accessoryView = nil;
    }
    self.textLabel.text = category.name;
    self.imageView.image = [UIImage imageNamed:category.icon];
    self.imageView.highlightedImage = [UIImage imageNamed:category.highlighted_icon];
}
@end
