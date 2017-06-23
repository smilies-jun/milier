//
//  NoDateTableViewCell.m
//  milier
//
//  Created by amin on 2017/6/22.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "NoDateTableViewCell.h"

@implementation NoDateTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)configUI:(NSIndexPath *)indexPath{
    self.backgroundColor = colorWithRGB(0.93, 0.93, 0.93);
    _ImageView = [[UIImageView alloc]init];
    _ImageView.image = [UIImage imageNamed:@"nodatas"];
    [self addSubview:_ImageView];
    [_ImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(self.mas_top).offset(50);
        make.width.mas_equalTo(72);
        make.height.mas_equalTo(51);
    }];
    _NameLabel = [[UILabel alloc]init];
    _NameLabel.text = @"暂无数据";
    _NameLabel.font = [UIFont systemFontOfSize:14];
    _NameLabel.textAlignment = NSTextAlignmentCenter;
    _NameLabel.textColor = colorWithRGB(0.27, 0.27, 0.27);
    [self addSubview:_NameLabel];
    [_NameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_ImageView.mas_bottom).offset(10);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(20);
    }];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
