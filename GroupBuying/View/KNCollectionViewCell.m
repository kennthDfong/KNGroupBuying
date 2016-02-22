//
//  KNCollectionViewCell.m
//  GroupBuying
//
//  Created by ElCapitan on 16/1/22.
//  Copyright © 2016年 Strom. All rights reserved.
//

#import "KNCollectionViewCell.h"
#import "UIImageView+WebCache.h"
@interface KNCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *dealName;

@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *curretnPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *listPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *purchaseCountLabel;

@end

@implementation KNCollectionViewCell

- (void)setDeal:(KNDealModel *)deal {
    _deal = deal;
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_dealcell"]];
    //
    
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:deal.image_url] placeholderImage:[UIImage imageNamed:@"placeholder_deal"]];
    self.dealName.text = deal.title;
    self.detailLabel.text = deal.desc;
    self.curretnPriceLabel.text = [NSString stringWithFormat:@"¥%@", deal.current_price];
    self.listPriceLabel.text = [NSString stringWithFormat:@"¥%@", deal.list_price];
    self.purchaseCountLabel.text = [NSString stringWithFormat:@"出售%@", deal.purchase_count];
    
}


- (void)awakeFromNib {
    // Initialization code
}



@end
