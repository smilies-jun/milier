//
//  CustomMoreView.m
//  milier
//
//  Created by amin on 17/5/2.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "CustomMoreView.h"

@implementation CustomMoreView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame{
    if (self) {
        self = [super initWithFrame:frame];
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    
    return self;
}

- (void)initView{
    
    _StaticImageView = [[UIImageView alloc]init];
    _StaticImageView.image = [UIImage imageNamed:@"icon_required"];
    [self addSubview:_StaticImageView];
    [_StaticImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(5);
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    
    _NameLabel = [[UILabel alloc]init];
    _NameLabel.text = @"短信验证码:";
    _NameLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:_NameLabel];
    [_NameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_StaticImageView.mas_right);
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.width.mas_equalTo(85);
        make.height.mas_equalTo(20);
    }];
    
    _ArrowImageView = [[UIImageView alloc]init];
    _ArrowImageView.image = [UIImage imageNamed:@"icon_required"];
    [self addSubview:_ArrowImageView];
    [_ArrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_right).offset(-20);
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    
    
    
}

@end
