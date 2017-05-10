//
//  ChangeTableViewCell.m
//  milier
//
//  Created by amin on 17/4/24.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "ChangeTableViewCell.h"

@implementation ChangeTableViewCell

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
    _ChangeValueLabel = [[UILabel alloc]init];
    _ChangeValueLabel.text = @"债券包价值";
    _ChangeValueLabel.textAlignment = NSTextAlignmentCenter;
    _ChangeValueLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_ChangeValueLabel];
    [_ChangeValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.top.mas_equalTo(_NameLabel.mas_bottom);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(30);
    }];
    _ChangeValueNumberLabel = [[UILabel alloc]init];
    _ChangeValueNumberLabel.text = @"121212121";
    _ChangeValueNumberLabel.textAlignment = NSTextAlignmentCenter;
    _ChangeValueNumberLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_ChangeValueNumberLabel];
    [_ChangeValueNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_ChangeValueLabel.mas_centerX);
        make.top.mas_equalTo(_ChangeValueLabel.mas_bottom);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(10);
    }];
    
    _OneDayChangeLabel = [[UILabel alloc]init];
    _OneDayChangeLabel.text = @"当日转让率";
    _OneDayChangeLabel.textAlignment = NSTextAlignmentCenter;
    _OneDayChangeLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_OneDayChangeLabel];
    [_OneDayChangeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_ChangeValueLabel.mas_right).offset(20);
        make.top.mas_equalTo(_NameLabel.mas_bottom);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(30);
    }];
    _OneDayChangeNumberLabel = [[UILabel alloc]init];
    _OneDayChangeNumberLabel.text = @"121212121";
    _OneDayChangeNumberLabel.textAlignment = NSTextAlignmentCenter;
    _OneDayChangeNumberLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_OneDayChangeNumberLabel];
    [_OneDayChangeNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_OneDayChangeLabel.mas_centerX);
        make.top.mas_equalTo(_OneDayChangeLabel.mas_bottom);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(10);
    }];

    _ReguarLabel = [[UILabel alloc]init];
    _ReguarLabel.text = @"汇款金额（元）";
    _ReguarLabel.textAlignment = NSTextAlignmentCenter;
    _ReguarLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_ReguarLabel];
    [_ReguarLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_OneDayChangeLabel.mas_right).offset(20);
        make.top.mas_equalTo(_NameLabel.mas_bottom);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    _RegularNumberLabel = [[UILabel alloc]init];
    _RegularNumberLabel.text = @"121212121";
    _RegularNumberLabel.textAlignment = NSTextAlignmentCenter;
    _RegularNumberLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_RegularNumberLabel];
    [_RegularNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_ReguarLabel.mas_centerX);
        make.top.mas_equalTo(_ReguarLabel.mas_bottom);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(10);
    }];
    UIView *LineView = [[UIView alloc]init];
    LineView.backgroundColor = [UIColor blackColor];
    [self addSubview:LineView];
    [LineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left);
        make.top.mas_equalTo(_RegularNumberLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(0.5);
    }];
    _OutLabel = [[UILabel alloc]init];
    _OutLabel.text = @"下架时间:2015-23-12";
    _OutLabel.font = [UIFont systemFontOfSize:10];
    _OutLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_OutLabel];
    [_OutLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.top.mas_equalTo(_ChangeValueNumberLabel.mas_bottom).offset(20);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(30);
    }];
    _OutSailLabel = [[UILabel alloc]init];
    _OutSailLabel.text = @"手续费:10";
    _OutSailLabel.font = [UIFont systemFontOfSize:10];
    _OutSailLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_OutSailLabel];
    [_OutSailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_OutLabel.mas_right).offset(20);
        make.top.mas_equalTo(_ChangeValueNumberLabel.mas_bottom).offset(20);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(30);
    }];
    _IsOrNoLabel = [[UILabel alloc]init];
    _IsOrNoLabel.text = @"取消转让";
    _IsOrNoLabel.font = [UIFont systemFontOfSize:10];
    _IsOrNoLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:_IsOrNoLabel];
    [_IsOrNoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-20);
        make.top.mas_equalTo(_ChangeValueNumberLabel.mas_bottom).offset(20);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(30);
    }];
    
    _StateImageView = [[UIImageView alloc]init];
    _StateImageView.image = [UIImage imageNamed:@"assignment"];
    [self addSubview:_StateImageView];
    [_StateImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right);
        make.top.mas_equalTo(self.mas_top);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end