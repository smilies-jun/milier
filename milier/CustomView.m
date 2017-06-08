//
//  CustomView.m
//  YWD
//
//  Created by 007 on 15/10/29.
//  Copyright © 2015年 star. All rights reserved.
//

#import "CustomView.h"

@implementation CustomView

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
    _NameLabel.text = @"手机号码:";
    _NameLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:_NameLabel];
    [_NameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(20);
    }];
    
    
    _NameTextField = [[UITextField alloc]init];
    _NameTextField.backgroundColor = [UIColor whiteColor];
    _NameTextField.font = [UIFont systemFontOfSize:15];
    _NameTextField.textAlignment = NSTextAlignmentRight;
    _NameTextField.placeholder = @"请输入对应信息";
    [self addSubview:_NameTextField];
    [_NameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_NameLabel.mas_right).offset(10);
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.right.mas_equalTo(self.mas_right).offset(-10);
        make.height.mas_equalTo(20);
    }];
}

@end
