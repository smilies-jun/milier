//
//  DinQiJiXiTableViewCell.m
//  milier
//
//  Created by amin on 2017/7/31.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "DinQiJiXiTableViewCell.h"

@implementation DinQiJiXiTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setFrame:(CGRect)frame{
    frame.size.height -= 1;
    
    [super setFrame:frame];
}
- (void)configUI:(NSIndexPath *)indexPath{
    _SaleLabel = [[UILabel alloc]init];
    _SaleLabel.text = @"";
    _SaleLabel.font = [UIFont systemFontOfSize:14];
    _SaleLabel.frame = CGRectMake(20, 10, SCREEN_WIDTH - 20, 25);
    [self addSubview:_SaleLabel];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
