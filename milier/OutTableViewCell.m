//
//  OutTableViewCell.m
//  milier
//
//  Created by amin on 2017/5/19.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "OutTableViewCell.h"

@implementation OutTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)configUI:(NSIndexPath *)indexPath{
    _TitleLabel  = [[UILabel alloc]init];
    _TitleLabel.text= @"2017-05-15";
    _TitleLabel.textColor = colorWithRGB(0.27, 0.27, 0.27);
    _TitleLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_TitleLabel];
    [_TitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(10);
        make.left.mas_equalTo(self.contentView.mas_left).offset(10);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(20);
    }];
    
    _TimeLabel = [[UILabel alloc]init];
    _TimeLabel.text  =@"+2323";
    _TimeLabel.textAlignment = NSTextAlignmentRight;
    _TimeLabel.font = [UIFont systemFontOfSize:13];
    _TimeLabel.textColor = colorWithRGB(0.95, 0.6, 0.11);
    [self addSubview:_TimeLabel];
    [_TimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.right.mas_equalTo(self.mas_right).offset(-10);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(20);
    }];
 
}
@end
