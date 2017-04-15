//
//  SelectCollectionViewCell.m
//  shiyi
//
//  Created by 于君 on 15/6/23.
//  Copyright (c) 2015年 于君. All rights reserved.
//

#import "SelectCollectionViewCell.h"

@implementation SelectCollectionViewCell

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}
- (void)initView{
    _label = [[UILabel alloc]init];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.font = [UIFont systemFontOfSize:14];
    _label.textColor = [UIColor grayColor];
    [self addSubview:_label];
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(38);
    }];
    _lineImageView = [[UIImageView alloc]init];
    _lineImageView.backgroundColor = [UIColor redColor];
    _lineImageView.hidden = YES;
    [self addSubview:_lineImageView];
    [_lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_label.mas_centerX);
        make.top.mas_equalTo(_label.mas_bottom);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(2);
    }];
}
@end
