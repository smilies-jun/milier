//
//  ChoiceStageTableViewCell.m
//  milier
//
//  Created by amin on 2017/5/12.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "ChoiceStageTableViewCell.h"

@implementation ChoiceStageTableViewCell
- (void)configUI:(NSIndexPath *)indexPath{
    _TotalImageView = [[UIImageView alloc]init];
    _TotalImageView.image = [UIImage imageNamed:@"icon_xm"];
    [self addSubview:_TotalImageView];
    [_TotalImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.width.mas_equalTo(25);
        make.height.mas_equalTo(25);
    }];
    
    _TitleLable = [[UILabel alloc]init];
    _TitleLable.text = @"10元小米卷";
    _TitleLable.font = [UIFont systemFontOfSize:13];
    _TitleLable.textColor = colorWithRGB(0.96, 0.6, 0.11);
    [self addSubview:_TitleLable];
    [_TitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_TotalImageView.mas_right).offset(5);
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.width.mas_equalTo(180);
        make.height.mas_equalTo(15);
    }];
    
    _DetailLable  = [[UILabel alloc]init];
    _DetailLable.text = @"投资50元以上可以使用，适用于短期理财";
    _DetailLable.font = [UIFont systemFontOfSize:13];
    _DetailLable.textColor = colorWithRGB(0.63, 0.63, 0.63);
    [self addSubview:_DetailLable];
    [_DetailLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_TotalImageView.mas_right).offset(5);
        make.top.mas_equalTo(_TitleLable.mas_bottom);
        make.width.mas_equalTo(280);
        make.height.mas_equalTo(15);
    }];

    

}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
