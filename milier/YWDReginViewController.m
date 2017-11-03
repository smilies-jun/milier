//
//  YWDReginViewController.m
//  YWD
//
//  Created by 007 on 15/10/28.
//  Copyright © 2015年 star. All rights reserved.
//

#import "YWDReginViewController.h"
#import "CustomView.h"
#import "ReginAndLoginViewController.h"
#import "ProtocalViewController.h"
#import "YWDLoginViewController.h"


@interface YWDReginViewController (){
   
    CustomView *phoneView;
    UIButton *ClickBtn;
}


@end

@implementation YWDReginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.TopView.hidden = NO;
    self.view.backgroundColor = colorWithRGB(0.94, 0.94, 0.94);
    self.TopTitleLabel.text = @"注册";
    [self.BackButton addTarget:self action:@selector(ReginBackClick) forControlEvents:UIControlEventTouchUpInside];
    UITapGestureRecognizer *HideTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
    [self.view addGestureRecognizer:HideTap];
    
    phoneView = [[CustomView alloc]init];
    phoneView.NameLabel.text = @"手机号码:";
    phoneView.NameTextField.placeholder = @"请输入手机号码";
    phoneView.NameTextField.keyboardType = UIKeyboardTypeNumberPad;
    phoneView.NameTextField.delegate = self;
    [self.view addSubview:phoneView];
    [phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self.TopView.mas_bottom).offset(20);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(40);
    }];
    
    ClickBtn = [[UIButton alloc]init];
    [ClickBtn setBackgroundImage:[UIImage imageNamed:@"uncheck"] forState:UIControlStateNormal];
    ClickBtn.selected = YES;
    [ClickBtn setBackgroundImage:[UIImage imageNamed:@"check"] forState:UIControlStateSelected];
    [ClickBtn addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ClickBtn];
    [ClickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.top.mas_equalTo(phoneView.mas_bottom).offset(20);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    
    UILabel *nameLabel =[[UILabel alloc]init];
    NSMutableAttributedString *ConnectStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"我同意《服务协议》"]];
    NSRange conectRange = {4,4};
    [ConnectStr addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:conectRange];
    nameLabel.attributedText = ConnectStr;
    nameLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *gesTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gesClick)];
    [nameLabel addGestureRecognizer:gesTap];
    [self.view addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ClickBtn.mas_right).offset(10);
        make.top.mas_equalTo(phoneView.mas_bottom).offset(20);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(30);
    }];
    
    UIButton *reginBtn = [[UIButton alloc]init];
    [reginBtn setTitle:@"注册" forState:UIControlStateNormal];
    reginBtn.layer.masksToBounds = YES;
    reginBtn.layer.cornerRadius = 5.0f;
    [reginBtn addTarget:self action:@selector(ReginClicked) forControlEvents:UIControlEventTouchUpInside];
    [reginBtn setBackgroundColor:colorWithRGB(0.96, 0.21, 0.29)];
    reginBtn.titleLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:reginBtn];
    [reginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.top.mas_equalTo(nameLabel.mas_bottom).offset(20);
        make.width.mas_equalTo(SCREEN_WIDTH - 40);
        make.height.mas_equalTo(40);
    }];

}
- (void)gesClick{
    ProtocalViewController *proVC = [[ProtocalViewController alloc]init];
    [self.navigationController pushViewController:proVC animated:NO];
}
- (void)clicked:(UIButton *)btn{
    if (btn.selected) {
        btn.selected = NO;
    }else{
        btn.selected = YES;
    }
}
#pragma mark - - 
- (void)ReginClicked{
    
    if (ClickBtn.selected) {
        if (phoneView.NameTextField.text.length) {
            ReginAndLoginViewController *RALVC = [[ReginAndLoginViewController alloc] init];
            RALVC.codeStr = phoneView.NameTextField.text;
            [self.navigationController pushViewController:RALVC animated:NO];
        }else{
            normal_alert(@"提示", @"手机号码不可为空", @"确定");
        }
    }else{
        normal_alert(@"提示", @"请遵守隐私协议", @"确定");

    }
    
   
    
    
}
- (void)ReginBackClick{
    //  返回指定页面
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[YWDLoginViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
}

- (void)tapClick{
    [self HideKeyBoardClick];
}

//- (void)textFieldDidBeginEditing:(UITextField *)textField{
//    textField.placeholder = @"";
//    textField.textAlignment = NSTextAlignmentLeft;
//}
#pragma mark - 隐藏当前页面所有键盘-
- (void)HideKeyBoardClick{
    for (UIView *KeyView in self.view.subviews) {
        [self dismissAllKeyBoard:KeyView];
    }
    
}

- (BOOL)dismissAllKeyBoard:(UIView *)view{
    
    if([view isFirstResponder])
    {
        [view resignFirstResponder];
        return YES;
    }
    for(UIView *subView in view.subviews)
    {
        if([self dismissAllKeyBoard:subView])
        {
            return YES;
        }
    }
    return NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
    [super viewWillDisappear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
