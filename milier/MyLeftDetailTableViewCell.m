//
//  MyLeftDetailTableViewCell.m
//  milier
//
//  Created by amin on 17/4/24.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "MyLeftDetailTableViewCell.h"

@implementation MyLeftDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)configUI:(NSIndexPath *)indexPath{
    
    _NameLabel = [[UILabel alloc]init];
    _NameLabel.text = @"绑定银行卡";
    _NameLabel.font = [UIFont systemFontOfSize:12];
    _NameLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_NameLabel];
    [_NameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.top.mas_equalTo(self.mas_top).offset(5);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    
    }];
    _DetailLabel = [[UILabel alloc]init];
    _DetailLabel.text = @"订单编号：276726372367267327";
    _DetailLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_DetailLabel];
    [_DetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.top.mas_equalTo(_NameLabel.mas_bottom);
        make.width.mas_equalTo(220);
        make.height.mas_equalTo(20);
    }];
    _TimeLabel = [[UILabel alloc]init];
    _TimeLabel.text = @"2014-23-32";
    _TimeLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_TimeLabel];
    [_TimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.top.mas_equalTo(_DetailLabel.mas_bottom);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    }];
    
    _NumberlLabel = [[UILabel alloc]init];
    _NumberlLabel.textColor = [UIColor orangeColor];
    _NumberlLabel.textAlignment = NSTextAlignmentRight;
    _NumberlLabel.text = @"+100000000";
    _NumberlLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_NumberlLabel];
    [_NumberlLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-20);
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    }];
    _StatelLabel = [[UILabel alloc]init];
    _StatelLabel.textAlignment = NSTextAlignmentRight;
    _StatelLabel.text = @"支付成功";
    _StatelLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_StatelLabel];
    [_StatelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-20);
        make.top.mas_equalTo(_NumberlLabel.mas_bottom);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
