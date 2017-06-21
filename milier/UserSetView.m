//
//  UserSetView.m
//  milier
//
//  Created by amin on 17/4/21.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "UserSetView.h"

@implementation UserSetView

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
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(25);
        make.height.mas_equalTo(25);
    }];
    
    _NameLabel = [[UILabel alloc]init];
    _NameLabel.text = @"短信验证码:";
    _NameLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:_NameLabel];
    [_NameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_StaticImageView.mas_right).offset(10);
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(15);
    }];

    _DetailLabel = [[UILabel alloc]init];
    _DetailLabel.text = @"登录米粒儿账户时需要密码";
    _DetailLabel.font = [UIFont systemFontOfSize:14];
    _DetailLabel.textColor = [UIColor orangeColor];
    [self addSubview:_DetailLabel];
    [_DetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_StaticImageView.mas_right).offset(10);
        make.top.mas_equalTo(_NameLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(15);
    }];
    
    _GorrowView = [[UIImageView alloc]init];
    _GorrowView.image = [UIImage imageNamed:@"goarrow"];
    [self addSubview:_GorrowView];
    [_GorrowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-20);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(18);
        make.height.mas_equalTo(18);
    }];

}
@end
