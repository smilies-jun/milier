//
//  customWithStatic.m
//  YWD
//
//  Created by 007 on 15/10/29.
//  Copyright © 2015年 star. All rights reserved.
//

#import "customWithStatic.h"

@implementation customWithStatic

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
    _NameLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_NameLabel];
    [_NameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_StaticImageView.mas_right);
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.width.mas_equalTo(85);
        make.height.mas_equalTo(20);
    }];
    
    
    _NameTextField = [[UITextField alloc]init];
    _NameTextField.backgroundColor = [UIColor whiteColor];
    _NameTextField.font = [UIFont systemFontOfSize:14];
    _NameTextField.textAlignment = NSTextAlignmentLeft;
    _NameTextField.placeholder = @"请输入验证码";
    [self addSubview:_NameTextField];
    [_NameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_NameLabel.mas_right).offset(10);
        make.top.mas_equalTo(self.mas_top);
        make.right.mas_equalTo(self.mas_right).offset(-70);
        make.height.mas_equalTo(40);
    }];
}
@end
