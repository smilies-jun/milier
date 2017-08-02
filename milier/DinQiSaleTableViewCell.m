//
//  DinQiSaleTableViewCell.m
//  milier
//
//  Created by amin on 2017/7/31.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "DinQiSaleTableViewCell.h"

@implementation DinQiSaleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setFrame:(CGRect)frame{
    frame.size.height -= 20;
    
    [super setFrame:frame];
}
- (void)configUI:(NSIndexPath *)indexPath{
    _SaleLabel = [[UILabel alloc]init];
    _SaleLabel.text = @"购买时间: 2017-08-23 12:20";
    _SaleLabel.font = [UIFont systemFontOfSize:14];
    _SaleLabel.frame = CGRectMake(20, 10, SCREEN_WIDTH - 20, 25);
    [self addSubview:_SaleLabel];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
