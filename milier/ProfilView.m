//
//  ProfilView.m
//  milier
//
//  Created by amin on 17/4/21.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "ProfilView.h"

@implementation ProfilView

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
    _NameLabel = [[UILabel alloc]init];
    _NameLabel.text = @"短信验证码:";
    _NameLabel.textAlignment = NSTextAlignmentLeft;
    _NameLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:_NameLabel];
    [_NameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(20);
    }];
    
    _DetailLabel = [[UILabel alloc]init];
    _DetailLabel.text = @"0";
    _DetailLabel.font = [UIFont systemFontOfSize:13];
    _DetailLabel.textAlignment = NSTextAlignmentRight;
    _DetailLabel.textColor = colorWithRGB(0.99, 0.79, 0.09);
    [self addSubview:_DetailLabel];
    [_DetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-40);
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(20);
    }];
    
    _GorrowView = [[UIImageView alloc]init];
    _GorrowView.image = [UIImage imageNamed:@"goarrow"];
    [self addSubview:_GorrowView];
    [_GorrowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-20);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(10);
        make.height.mas_equalTo(10);
    }];

}
@end
