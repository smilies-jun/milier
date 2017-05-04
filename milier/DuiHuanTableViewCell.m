//
//  DuiHuanTableViewCell.m
//  milier
//
//  Created by amin on 17/5/3.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "DuiHuanTableViewCell.h"

@implementation DuiHuanTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)configUI:(NSIndexPath *)indexPath{

    _NameLabel = [[UILabel alloc]init];
    _NameLabel.text =@"苏泊尔双层电动锅";
    _NameLabel.textAlignment = NSTextAlignmentLeft;
    _NameLabel.textColor = [UIColor blackColor];
    _NameLabel.font = [UIFont systemFontOfSize:10];
    [self addSubview:_NameLabel];
    [_NameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(15);
    }];
    
    _NameDetailLabel = [[UILabel alloc]init];
    _NameDetailLabel.text = @"2016:23:30";
    _NameDetailLabel.font = [UIFont systemFontOfSize:10];
    [self addSubview:_NameDetailLabel];
    [_NameDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.top.mas_equalTo(_NameLabel.mas_bottom);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(25);
    }];
    
    _MyJiFenLabel = [[UILabel alloc]init];
    _MyJiFenLabel.text= @"232232";
    _MyJiFenLabel.font = [UIFont systemFontOfSize:10];
    [self addSubview:_MyJiFenLabel];
    [_MyJiFenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(10);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(15);
    }];
    
    
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
