//
//  KNTbelViewCell.h
//  GroupBuying
//
//  Created by ElCapitan on 16/1/22.
//  Copyright © 2016年 Strom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KNRegion.h"
#import "KNCategoryModle.h"
@interface KNTbelViewCell : UITableViewCell
@property (nonatomic, strong)KNRegion *region;


+ (KNTbelViewCell *)cellWithTableView:(UITableView *) tableView
                            withImage:(NSString *)    imageName
                     withHightLighted:(NSString *)    hlImageName;

/* ========================已经不用的方法==========================
+ (KNTbelViewCell *)cellWithTableView:(UITableView *)tableView
                                  withCategory:(KNCategoryModle *)category
                                 withImageName:(NSString *)imageName
                    withHilghtLightedImageName:(NSString *)hlImageName;

 */
- (void)setCategory: (KNCategoryModle *)category;
@end
