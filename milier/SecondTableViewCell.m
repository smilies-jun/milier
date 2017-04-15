//
//  SecondTableViewCell.m
//  milier
//
//  Created by amin on 17/4/11.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "SecondTableViewCell.h"

@implementation SecondTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)configUI:(NSIndexPath *)indexPath{
    _TitleLabel  = [[UILabel alloc]init];
    _TitleLabel.text= @"投米宝－优选中期";
    _TitleLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_TitleLabel];
    [_TitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(6);
        make.left.mas_equalTo(self.contentView.mas_left).offset(20);
        make.width.mas_equalTo(160);
        make.height.mas_equalTo(25);
    }];
    
    _TypeLabel = [[UILabel alloc]init];
    _TypeLabel.font = [UIFont systemFontOfSize:10];
    _TypeLabel.backgroundColor = [UIColor orangeColor];
    _TypeLabel.textColor = [UIColor whiteColor];
    _TypeLabel.text = @"保守型";
    [self.contentView addSubview:_TypeLabel];
    [_TypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_TitleLabel.mas_bottom).offset(1);
        make.left.mas_equalTo(self.contentView.mas_left).offset(20);
        make.width.mas_equalTo(33);
        make.height.mas_equalTo(13);
    }];
    
    _TimeLabel = [[UILabel alloc]init];
    _TimeLabel.font = [UIFont systemFontOfSize:10];
    _TimeLabel.backgroundColor = [UIColor greenColor];
    _TimeLabel.textColor = [UIColor whiteColor];
    _TimeLabel.text = @"买入起即起息";
    [self.contentView addSubview:_TimeLabel];
    [_TimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_TitleLabel.mas_bottom).offset(1);
        make.left.mas_equalTo(_TypeLabel.mas_right).offset(10);
        make.width.mas_equalTo(63);
        make.height.mas_equalTo(13);
    }];

    _ProfitLabel = [[UILabel alloc]init];
    _ProfitLabel.font = [UIFont systemFontOfSize:14];
    _ProfitLabel.textColor = [UIColor blackColor];
    _ProfitLabel.text = @"预计年化收益";
    [self.contentView addSubview:_ProfitLabel];
    [_ProfitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_TypeLabel.mas_bottom).offset(1);
        make.left.mas_equalTo(self.contentView.mas_left).offset(20);
        make.width.mas_equalTo(93);
        make.height.mas_equalTo(20);
    }];

}

- (void)setProductMoel:(ProuctModel *)productMoel{
    if (productMoel != _productMoel) {
        _productMoel = productMoel;
        
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
