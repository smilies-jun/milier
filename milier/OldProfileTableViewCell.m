//
//  OldProfileTableViewCell.m
//  milier
//
//  Created by amin on 17/4/24.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "OldProfileTableViewCell.h"

@implementation OldProfileTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)configUI:(NSIndexPath *)indexPath{
    _NameLabel = [[UILabel alloc]init];
    _NameLabel.text =@"昨日收益29999";
    _NameLabel.textAlignment = NSTextAlignmentLeft;
    _NameLabel.textColor = [UIColor blackColor];
    _NameLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_NameLabel];
    [_NameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(30);
    }];
    _DetailLabel = [[UILabel alloc]init];
    _DetailLabel.text =@"昨日收益29999";
    _DetailLabel.textAlignment = NSTextAlignmentRight;
    _DetailLabel.textColor = [UIColor orangeColor];
    _DetailLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_DetailLabel];
    [_DetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-20);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(30);
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
