//
//  StageTotalTableViewCell.m
//  milier
//
//  Created by amin on 2017/5/5.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "StageTotalTableViewCell.h"

@implementation StageTotalTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)configUI:(NSIndexPath *)indexPath{
    
    
    _TotalImageView = [[UIImageView alloc]init];
    _TotalImageView.image = [UIImage imageNamed:@"tip_orange"];
    [self addSubview:_TotalImageView];
    [_TotalImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(80);
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.width.mas_equalTo(13);
        make.height.mas_equalTo(13);
    }];
    
    _TitleLable = [[UILabel alloc]init];
    _TitleLable.text = @"当次购买只能使用一次道具";
    _TitleLable.font = [UIFont systemFontOfSize:13];
    _TitleLable.textColor = colorWithRGB(0.96, 0.6, 0.11);
    [self addSubview:_TitleLable];
    [_TitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_TotalImageView.mas_right).offset(5);
        make.centerY.mas_equalTo(_TotalImageView.mas_centerY);
        make.width.mas_equalTo(180);
        make.height.mas_equalTo(20);
    }];
 
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
