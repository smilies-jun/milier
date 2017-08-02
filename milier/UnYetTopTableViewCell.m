//
//  UnYetTopTableViewCell.m
//  milier
//
//  Created by amin on 2017/8/1.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "UnYetTopTableViewCell.h"

@implementation UnYetTopTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setFrame:(CGRect)frame{
    frame.size.height -= 20;
    
    [super setFrame:frame];
}
- (void)configUI:(NSIndexPath *)indexPath{
    _TopMoneyLabel = [[UILabel alloc]init];
    _TopMoneyLabel.text = @"$123124";
    _TopMoneyLabel.textColor = colorWithRGB(0.97, 0.6, 0.11);
    _TopMoneyLabel.textAlignment = NSTextAlignmentCenter;
    _TopMoneyLabel.font = [UIFont systemFontOfSize:28];
    [self addSubview:_TopMoneyLabel];
    [_TopMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(self.mas_top).offset(20);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    _LostMoneyLabel = [[UILabel alloc]init];
    _LostMoneyLabel.text = @"逾期利息";
    _LostMoneyLabel.textColor = colorWithRGB(0.56, 0.56, 0.56);
    _LostMoneyLabel.font =[UIFont systemFontOfSize:15];
    _LostMoneyLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_LostMoneyLabel];
    [_LostMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left);
        make.top.mas_equalTo(_TopMoneyLabel.mas_bottom).offset(40);
        make.width.mas_equalTo(SCREEN_WIDTH/2);
        make.height.mas_equalTo(20);
    }];
    _LostMoneyNumberLabel = [[UILabel alloc]init];
    _LostMoneyNumberLabel.text = @"$123214";
    _LostMoneyNumberLabel.textColor = colorWithRGB(0.97, 0.6, 0.11);

    _LostMoneyNumberLabel.font =[UIFont systemFontOfSize:15];
    _LostMoneyNumberLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_LostMoneyNumberLabel];
    [_LostMoneyNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left);
        make.top.mas_equalTo(_LostMoneyLabel.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH/2);
        make.height.mas_equalTo(20);
    }];

    _BackMoneyLabel = [[UILabel alloc]init];
    _BackMoneyLabel.text = @"坏账待还";
    _BackMoneyLabel.textColor = colorWithRGB(0.56, 0.56, 0.56);

    _BackMoneyLabel.font =[UIFont systemFontOfSize:15];
    _BackMoneyLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_BackMoneyLabel];
    [_BackMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right);
        make.top.mas_equalTo(_TopMoneyLabel.mas_bottom).offset(40);
        make.width.mas_equalTo(SCREEN_WIDTH/2);
        make.height.mas_equalTo(20);
    }];
    _BackMoneyNumberLabel = [[UILabel alloc]init];
    _BackMoneyNumberLabel.text = @"$123214";
    _BackMoneyNumberLabel.textColor = colorWithRGB(0.97, 0.6, 0.11);

    _BackMoneyNumberLabel.font =[UIFont systemFontOfSize:15];
    _BackMoneyNumberLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_BackMoneyNumberLabel];
    [_BackMoneyNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right);
        make.top.mas_equalTo(_BackMoneyLabel.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH/2);
        make.height.mas_equalTo(20);
    }];
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
