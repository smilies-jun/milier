//
//  YWDAlertView.m
//  YWD
//
//  Created by 007 on 15/10/30.
//  Copyright © 2015年 star. All rights reserved.
//

#import "YWDAlertView.h"
#import "popupFade.h"

@implementation YWDAlertView

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
        [self initView];
        self.backgroundColor = colorWithRGB(0.94, 0.94, 0.94);
    }
    
    return self;
}

- (void)initView{
    UIView *topView = [[UIView alloc]init];
    topView.backgroundColor = [UIColor whiteColor];
    [self addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left);
        make.top.mas_equalTo(self.mas_top);
        make.width.mas_equalTo(self.mas_width);
        make.height.mas_equalTo(40);
    }];
    
    UILabel *Label = [[UILabel alloc]init];
    Label.text = @"提示";
    Label.font = [UIFont systemFontOfSize:15];
    [topView addSubview:Label];
    [Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(5);
        make.top.mas_equalTo(self.mas_top).offset(5);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(30);
    }];
    
    UIButton *CancelBtn = [[UIButton alloc]init];
    [CancelBtn setBackgroundImage:[UIImage imageNamed:@"pop_close"] forState:UIControlStateNormal];
    [CancelBtn addTarget:self action:@selector(CancelClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:CancelBtn];
    [CancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right);
        make.top.mas_equalTo(self.mas_top);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
    }];
    
    UIImageView *iconImage = [[UIImageView alloc]init];
    iconImage.image = [UIImage imageNamed:@"success_icon"];
    [self addSubview:iconImage];
    [iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(40);
        make.top.mas_equalTo(topView.mas_bottom).offset(30);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    UILabel *labelText = [[UILabel alloc]init];
    labelText.font = [UIFont systemFontOfSize:16];
    labelText.text = @"恭喜您注册成功!";
    [self addSubview:labelText];
    [labelText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(iconImage.mas_right).offset(10);
        make.top.mas_equalTo(topView.mas_bottom).offset(50);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(30);
    }];
    UIButton *sureBtn = [[UIButton alloc]init];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sureClicked) forControlEvents:UIControlEventTouchUpInside];
    [sureBtn setBackgroundColor:colorWithRGB(0.92, 0.26, 0.02)];
    sureBtn.titleLabel.textColor = [UIColor whiteColor];
    [self addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-10);
        make.width.mas_equalTo(SCREEN_WIDTH - 80);
        make.height.mas_equalTo(40);
    }];
    
}
- (void)sureClicked{
    _alertClicked(2);

}
- (void)CancelClicked{
    _alertClicked(1);
}
- (void)clickedSure:(AlertClicked)clickedBlock{
    _alertClicked = [clickedBlock copy];
}
@end
