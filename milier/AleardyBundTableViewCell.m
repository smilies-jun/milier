//
//  AleardyBundTableViewCell.m
//  milier
////  Created by amin on 2017/5/18.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "AleardyBundTableViewCell.h"

@implementation AleardyBundTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)configUI:(NSIndexPath *)indexPath{
    _userImageView = [[UIImageView alloc]init];
    _userImageView.backgroundColor = [UIColor grayColor];
    [self addSubview:_userImageView];
    [_userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
    }];
    _NameLabel = [[UILabel alloc]init];
    _NameLabel.text = @"15110499204";
    _NameLabel.font = [UIFont systemFontOfSize:10];
    [self addSubview:_NameLabel];
    [_NameLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_userImageView.mas_right).offset(5);
        make.top.mas_equalTo(self.mas_top).offset(5);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(15);
    }];
    
    _DetailLabel = [[UILabel alloc]init];
    _DetailLabel.text = @"好友绑定后可领取现金红包";
    _DetailLabel.font = [UIFont systemFontOfSize:10];
    [self addSubview:_DetailLabel];
    [_DetailLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_userImageView.mas_right).offset(5);
        make.top.mas_equalTo(_NameLabel.mas_bottom);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(15);
    }];
    
    _TypeLabel = [[UILabel alloc]init];
    _TypeLabel.text = @"6666现金红包";
    _TypeLabel.font = [UIFont systemFontOfSize:10];
    [self addSubview:_TypeLabel];
    [_TypeLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_userImageView.mas_right).offset(5);
        make.top.mas_equalTo(_DetailLabel.mas_bottom);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(15);
    }];
    
    
    
}

- (void)setShareModel:(ShareModel *)ShareModel{
    if (ShareModel != _ShareModel) {
        _ShareModel = ShareModel;
        [_userImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_ShareModel.avatar]]];
        _NameLabel.text =[NSString stringWithFormat:@"%@",_ShareModel.phoneNumber];
        
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
