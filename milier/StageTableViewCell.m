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
    _TypeImageView = [[UIImageView alloc]init];
    _TypeImageView.image = [UIImage imageNamed:@"qiye_xmq_01"];
    [self addSubview:_TypeImageView];
    [_TypeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.width.mas_equalTo(64);
        make.height.mas_equalTo(123);
    }];
    
    
   

    _TitleStateLable = [[UILabel alloc]init];
    _TitleStateLable.numberOfLines = 0;
    _TitleStateLable.text = @"随机小米卷";
    _TitleStateLable.textAlignment = NSTextAlignmentCenter;
    _TitleStateLable.font = [UIFont systemFontOfSize:16];
    _TitleStateLable.textColor = [UIColor whiteColor];
    [_TypeImageView addSubview:_TitleStateLable];
    [_TitleStateLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_TypeImageView.mas_right).offset(-12);
        make.top.mas_equalTo(_TypeImageView.mas_top);
        make.width.mas_equalTo(20);
        make.bottom.mas_equalTo(_TypeImageView.mas_bottom);
    }];
    

    _RightImageView = [[UIImageView alloc]init];
    _RightImageView.image = [UIImage imageNamed:@"tese_xmq_03"];
    [self addSubview:_RightImageView];
    [_RightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-10);
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.width.mas_equalTo(105);
        make.height.mas_equalTo(123);
    }];
    UIImageView *MiddleImageView = [[UIImageView alloc]init];
    MiddleImageView.image = [UIImage imageNamed:@"quan_content"];
    [self addSubview:MiddleImageView];
    [MiddleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_TypeImageView.mas_right);
        make.right.mas_equalTo(_RightImageView.mas_left);
        make.top.mas_equalTo(_RightImageView.mas_top);
        make.bottom.mas_equalTo(_RightImageView.mas_bottom);
    }];
    _TitleLable = [[UILabel alloc]init];
    _TitleLable.text = @"¥??????元";
    _TitleLable.textColor = [UIColor orangeColor];
    _TitleLable.font = [UIFont systemFontOfSize:15];
    [MiddleImageView addSubview:_TitleLable];
    [_TitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MiddleImageView.mas_left).offset(5);
        make.top.mas_equalTo(MiddleImageView.mas_top).offset(10);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(20);
    }];
    _SaileTimeLable = [[UILabel alloc]init];
    _SaileTimeLable.textColor = colorWithRGB(0.27, 0.27, 0.27);
    _SaileTimeLable.text = @"投资时间：3月以上";
    _SaileTimeLable.textAlignment = NSTextAlignmentLeft;
    _SaileTimeLable.font = [UIFont systemFontOfSize:11];
    [MiddleImageView addSubview:_SaileTimeLable];
    [_SaileTimeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_TitleLable.mas_left);
        make.top.mas_equalTo(_TitleLable.mas_bottom).offset(5);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    }];
    
    _SailMoneyLable = [[UILabel alloc]init];
    _SailMoneyLable.textColor = colorWithRGB(0.27, 0.27, 0.27);
    _SailMoneyLable.textAlignment = NSTextAlignmentLeft;
    _SailMoneyLable.text = @"投资金额：3月以上";
    _SailMoneyLable.font = [UIFont systemFontOfSize:11];
    [MiddleImageView addSubview:_SailMoneyLable];
    [_SailMoneyLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_TitleLable.mas_left);
        make.top.mas_equalTo(_SaileTimeLable.mas_bottom);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
       }];
    _BuyTitleLable = [[UILabel alloc]init];
    _BuyTitleLable.text = @"车贷";
    _BuyTitleLable.textColor = [UIColor whiteColor];
    _BuyTitleLable.textAlignment = NSTextAlignmentCenter;
    _BuyTitleLable.backgroundColor = [UIColor redColor];
    _BuyTitleLable.font = [UIFont systemFontOfSize:11];
    [MiddleImageView addSubview:_BuyTitleLable];
    [_BuyTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_TitleLable.mas_left);
        make.top.mas_equalTo(_SailMoneyLable.mas_bottom).offset(5);
        make.width.mas_equalTo(35);
        make.height.mas_equalTo(18);
    }];
    _InterentTitleLable = [[UILabel alloc]init];
    _InterentTitleLable.text = @"网贷";
    _InterentTitleLable.textAlignment = NSTextAlignmentCenter;
    _InterentTitleLable.backgroundColor = [UIColor orangeColor];
    _InterentTitleLable.textColor = [UIColor whiteColor];
    _InterentTitleLable.font = [UIFont systemFontOfSize:11];
    [MiddleImageView addSubview:_InterentTitleLable];
    [_InterentTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_BuyTitleLable.mas_right).offset(2);
        make.centerY.mas_equalTo(_BuyTitleLable.mas_centerY);
        make.width.mas_equalTo(35);
        make.height.mas_equalTo(18);
    }];
    _QiYeTitleLable = [[UILabel alloc]init];
    _QiYeTitleLable.textColor = [UIColor whiteColor];
    _QiYeTitleLable.text = @"企业贷";
    _QiYeTitleLable.backgroundColor = [UIColor greenColor];
    _QiYeTitleLable.textAlignment = NSTextAlignmentCenter;
    _QiYeTitleLable.font = [UIFont systemFontOfSize:11];
    [MiddleImageView addSubview:_QiYeTitleLable];
    [_QiYeTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_InterentTitleLable.mas_right).offset(2);
        make.centerY.mas_equalTo(_BuyTitleLable.mas_centerY);
        make.width.mas_equalTo(35);
        make.height.mas_equalTo(18);
    }];
    _PersonTitleLable = [[UILabel alloc]init];
    _PersonTitleLable.textColor = [UIColor whiteColor];
    _PersonTitleLable.backgroundColor = [UIColor blueColor];
    _PersonTitleLable.textAlignment = NSTextAlignmentCenter;
    _PersonTitleLable.text = @"个人贷";
    _PersonTitleLable.font = [UIFont systemFontOfSize:11];
    [MiddleImageView addSubview:_PersonTitleLable];
    [_PersonTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_QiYeTitleLable.mas_right).offset(2);
        make.centerY.mas_equalTo(_BuyTitleLable.mas_centerY);
        make.width.mas_equalTo(35);
        make.height.mas_equalTo(18);
    }];

    _UseTitleLable = [[UILabel alloc]init];
    _UseTitleLable.text = @"立即使用";
    _UseTitleLable.font = [UIFont systemFontOfSize:15];
    _UseTitleLable.textAlignment = NSTextAlignmentCenter;
    _UseTitleLable.textColor = [UIColor whiteColor];
    [_RightImageView addSubview:_UseTitleLable];
    [_UseTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_RightImageView.mas_centerX);
        make.centerY.mas_equalTo(_RightImageView.mas_centerY).offset(-10);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(20);
    }];
    
    _UseTimeTitleLable = [[UILabel alloc]init];
    _UseTimeTitleLable.font = [UIFont systemFontOfSize:12];
    _UseTimeTitleLable.text = @"剩余1天过期";
    _UseTimeTitleLable.textAlignment = NSTextAlignmentCenter;
    _UseTimeTitleLable.textColor = [UIColor whiteColor];
    [_RightImageView addSubview:_UseTimeTitleLable];
    [_UseTimeTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_UseTitleLable.mas_centerX);
        make.top.mas_equalTo(_UseTitleLable.mas_bottom);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
