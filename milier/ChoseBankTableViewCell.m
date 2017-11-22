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
        _BankDayLabel.text = [NSString stringWithFormat:@"限额: 单笔:%ld万  单日:%ld万  单月:%ld万",[_ChoseModel.singleLimit integerValue]/10000 ,[_ChoseModel.dailyLimit integerValue]/10000,[_ChoseModel.monthLimit integerValue]/10000];
        
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
