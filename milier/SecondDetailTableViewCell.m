//
//  SecondDetailTableViewCell.m
//  milier
//
//  Created by amin on 2017/5/5.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "SecondDetailTableViewCell.h"

@implementation SecondDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)configUI:(NSIndexPath *)indexPath{
    _TitleLabel = [[UILabel alloc]init];
    _TitleLabel.text = @"产品介绍";
    _TitleLabel.font = [UIFont systemFontOfSize:15];
    _TitleLabel.textColor = colorWithRGB(0.27, 0.27, 0.27);
    [self.contentView addSubview:_TitleLabel];
    [_TitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(10);
        make.top.mas_equalTo(self.contentView.mas_top).offset(5);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(20);
    }];
    
    _ArrowImageView = [[UIImageView alloc]init];
    _ArrowImageView.image = [UIImage imageNamed:@"goarrow"];
    [self.contentView addSubview:_ArrowImageView];
    [_ArrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
        make.top.mas_equalTo(self.contentView.mas_top).offset(5);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    UIView *BottomLineView = [[UIView alloc]init];
    BottomLineView.backgroundColor = colorWithRGB(0.87, 0.87, 0.87);
    [self.contentView addSubview:BottomLineView];
    [BottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left);
        make.top.mas_equalTo(_TitleLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(0.5);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
