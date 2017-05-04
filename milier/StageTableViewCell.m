//
//  StageTableViewCell.m
//  milier
//
//  Created by amin on 17/4/25.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "StageTableViewCell.h"

@implementation StageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configUI:(NSIndexPath *)indexPath{
    _LeftImageView = [[UIImageView alloc]init];
    _LeftImageView.backgroundColor = [UIColor grayColor];
    [self addSubview:_LeftImageView];
    [_LeftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(30);
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.width.mas_equalTo(220);
        make.height.mas_equalTo(100);
    }];
    
    _TitleLable = [[UILabel alloc]init];
    _TitleLable.text = @"??????元";
    _TitleLable.font = [UIFont systemFontOfSize:13];
    [self addSubview:_TitleLable];
    [_TitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_LeftImageView.mas_left).offset(10);
        make.top.mas_equalTo(_LeftImageView.mas_top).offset(5);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(20);
    }];
    
    _TitleStateLable = [[UILabel alloc]init];
    _TitleStateLable.text = @"随机小米卷";
    _TitleStateLable.font = [UIFont systemFontOfSize:12];
    _TitleStateLable.backgroundColor = [UIColor redColor];
    _TitleStateLable.textColor = [UIColor whiteColor];
    [self addSubview:_TitleStateLable];
    [_TitleStateLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_LeftImageView.mas_right).offset(-5);
        make.centerY.mas_equalTo(_TitleLable.mas_centerY);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(20);
    }];
    
    _SaileTimeLable = [[UILabel alloc]init];
    _SaileTimeLable.text = @"投资实践：3月以上";
    _SaileTimeLable.textAlignment = NSTextAlignmentLeft;
    _SaileTimeLable.font = [UIFont systemFontOfSize:11];
    [self addSubview:_SaileTimeLable];
    [_SaileTimeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_TitleLable.mas_left);
        make.top.mas_equalTo(_TitleLable.mas_bottom);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    }];

    _SailMoneyLable = [[UILabel alloc]init];
    _SailMoneyLable.textAlignment = NSTextAlignmentLeft;
    _SailMoneyLable.text = @"投资实践：3月以上";
    _SailMoneyLable.font = [UIFont systemFontOfSize:11];
    [self addSubview:_SailMoneyLable];
    [_SailMoneyLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_TitleLable.mas_left);
        make.top.mas_equalTo(_SaileTimeLable.mas_bottom);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    }];
    
    _BuyTitleLable = [[UILabel alloc]init];
    _BuyTitleLable.text = @"车贷";
    _BuyTitleLable.font = [UIFont systemFontOfSize:11];
    [self addSubview:_BuyTitleLable];
    [_BuyTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_TitleLable.mas_left);
        make.top.mas_equalTo(_SailMoneyLable.mas_bottom);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(20);
    }];
    _InterentTitleLable = [[UILabel alloc]init];
    _InterentTitleLable.text = @"网贷";
    _InterentTitleLable.font = [UIFont systemFontOfSize:11];
    [self addSubview:_InterentTitleLable];
    [_InterentTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_BuyTitleLable.mas_right).offset(5);
        make.centerY.mas_equalTo(_BuyTitleLable.mas_centerY);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(20);
    }];
    _QiYeTitleLable = [[UILabel alloc]init];
    _QiYeTitleLable.text = @"企业贷";
    _QiYeTitleLable.font = [UIFont systemFontOfSize:11];
    [self addSubview:_QiYeTitleLable];
    [_QiYeTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_InterentTitleLable.mas_right).offset(5);
        make.centerY.mas_equalTo(_BuyTitleLable.mas_centerY);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(20);
    }];
    _PersonTitleLable = [[UILabel alloc]init];
    _PersonTitleLable.text = @"个人贷";
    _PersonTitleLable.font = [UIFont systemFontOfSize:11];
    [self addSubview:_PersonTitleLable];
    [_PersonTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_QiYeTitleLable.mas_right).offset(5);
        make.centerY.mas_equalTo(_BuyTitleLable.mas_centerY);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(20);
    }];
    _RightImageView = [[UIImageView alloc]init];
    _RightImageView.backgroundColor = [UIColor redColor];
    [self addSubview:_RightImageView];
    [_RightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_LeftImageView.mas_right);
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(100);
    }];
    
    _UseTitleLable = [[UILabel alloc]init];
    _UseTitleLable.text = @"使用";
    _UseTitleLable.textAlignment = NSTextAlignmentCenter;
    _UseTitleLable.textColor = [UIColor whiteColor];
    [self addSubview:_UseTitleLable];
    [_UseTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_RightImageView.mas_centerX);
        make.centerY.mas_equalTo(_RightImageView.mas_centerY);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(20);
    }];
    
    _UseTimeTitleLable = [[UILabel alloc]init];
    _UseTimeTitleLable.font = [UIFont systemFontOfSize:8];
    _UseTimeTitleLable.text = @"剩余1天过期";
    _UseTimeTitleLable.textAlignment = NSTextAlignmentCenter;
    _UseTimeTitleLable.textColor = [UIColor whiteColor];
    [self addSubview:_UseTimeTitleLable];
    [_UseTimeTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_UseTitleLable.mas_centerX);
        make.top.mas_equalTo(_UseTitleLable.mas_bottom);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(20);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
