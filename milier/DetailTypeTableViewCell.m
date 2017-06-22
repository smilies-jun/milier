//
//  DetailTypeTableViewCell.m
//  milier
//
//  Created by amin on 2017/6/22.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "DetailTypeTableViewCell.h"

@implementation DetailTypeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)configUI:(NSIndexPath *)indexPath{
    _TitleLabel  = [[UILabel alloc]init];
    _TitleLabel.text= @"时间";
    _TitleLabel.textColor = colorWithRGB(0.27, 0.27, 0.27);
    _TitleLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_TitleLabel];
    [_TitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(10);
        make.left.mas_equalTo(self.contentView.mas_left).offset(10);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(20);
    }];
    
    _TypeLabel = [[UILabel alloc]init];
    _TypeLabel.text = @"下家存量总金额";
    _TypeLabel.textAlignment = NSTextAlignmentCenter;
    _TypeLabel.font = [UIFont systemFontOfSize:13];
    _TypeLabel.textColor = colorWithRGB(0.95, 0.6, 0.11);
    [self addSubview:_TypeLabel];
    [_TypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(20);
    }];
    
    _TimeLabel = [[UILabel alloc]init];
    _TimeLabel.text  =@"我的分成";
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
    //    if (indexPath.row == 0) {
    //        _TitleLabel.text= @"时间";
    //        _TypeLabel.text = @"下家存量总金额";
    //        _TimeLabel.text  =@"我的分成";
    //
    //
    //    }
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
