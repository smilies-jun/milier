//
//  ChoseBankTableViewCell.m
//  milier
//
//  Created by amin on 2017/11/21.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "ChoseBankTableViewCell.h"

@implementation ChoseBankTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)configUI:(NSIndexPath *)indexPath{
    _BankImageView = [[UIImageView alloc]init];
    _BankImageView.image = [UIImage imageNamed:@""];
    [self addSubview:_BankImageView];
    [_BankImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    
    _BankLabel = [[UILabel alloc]init];
    _BankLabel.text = @"yinhang ";
    _BankLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_BankLabel];
    [_BankLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_BankImageView.mas_right).offset(10);
        make.top.mas_equalTo(self.mas_top).offset(5);
        make.width.mas_equalTo(SCREEN_WIDTH - 60);
        make.height.mas_equalTo(20);
    }];
    
    _BankDayLabel = [[UILabel alloc]init];
    _BankDayLabel.font = [UIFont systemFontOfSize:13];
    _BankDayLabel.text = @"+++++++++++++++++";
    [self addSubview:_BankDayLabel];
    [_BankDayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_BankImageView.mas_right).offset(10);
        make.top.mas_equalTo(_BankLabel.mas_bottom).offset(5);
        make.width.mas_equalTo(SCREEN_WIDTH - 60);
        make.height.mas_equalTo(20);
    }];
    
    
    
}

- (void)setChoseModel:(ChoseModel *)ChoseModel{
    if (ChoseModel != _ChoseModel) {
        _ChoseModel = ChoseModel;
        [_BankImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_ChoseModel.icon]] placeholderImage:[UIImage imageNamed:@"headpic"]];
        _BankLabel.text= [NSString stringWithFormat:@"%@",_ChoseModel.name];
        NSString *str1; NSString *str2; NSString *str3;
        NSString *singleStr1 = [NSString stringWithFormat:@"%ld",(long)[_ChoseModel.singleLimit integerValue]];
        NSString *singleStt2 = [NSString stringWithFormat:@"%ld",(long)[_ChoseModel.dailyLimit integerValue]];
        NSString *singleStr3 = [NSString stringWithFormat:@"%ld",(long)[_ChoseModel.monthLimit integerValue]];
        if ([singleStr1 integerValue] >= 10000) {
            str1 = [NSString stringWithFormat:@"%ld万",[_ChoseModel.singleLimit integerValue]/10000];
        }else{
            str1 = [NSString stringWithFormat:@"%ld",[_ChoseModel.singleLimit integerValue]];
        }
        if ([singleStt2 integerValue] >= 10000) {
            str2 = [NSString stringWithFormat:@"%ld万",[_ChoseModel.dailyLimit integerValue]/10000];
        }else{
            str2 = [NSString stringWithFormat:@"%ld",[_ChoseModel.dailyLimit integerValue]];
        }
        if ([singleStr3 integerValue] >= 10000) {
            str3 = [NSString stringWithFormat:@"%ld万",[_ChoseModel.monthLimit integerValue]/10000];
        }else{
            str3 = [NSString stringWithFormat:@"%ld",[_ChoseModel.monthLimit integerValue]];
        }
        _BankDayLabel.text = [NSString stringWithFormat:@"限额: 单笔:%@  单日:%@  单月:%@",str1 ,str2,str3];
        
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
