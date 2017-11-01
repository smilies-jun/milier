//
//  YJForgetDealPassWordViewController.m
//  milier
//
//  Created by amin on 2017/6/2.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "YJForgetDealPassWordViewController.h"
#import "CustomView.h"
#import "TouUpViewController.h"
#import "ModifySailViewController.h"
#import "UserSetViewController.h"


@interface YJForgetDealPassWordViewController (){
    CustomView *phoneNumView;
    CustomView *CodeNumView;
    CustomView *NewPassWordView;
    CustomView *SurePassWordView;
    int _second;
    
}


@end

@implementation YJForgetDealPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"找回交易密码";
    self.view.backgroundColor = colorWithRGB(0.97, 0.97, 0.97);
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(0, 7, 18, 18);
    [leftBtn setImage:[UIImage imageNamed:@"backarrow@2x.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(ForgetBackClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;

    [self initUI];

    
}
- (void)ForgetBackClick{
    if ([_TypeStr integerValue] == 1) {
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[TouUpViewController class]]) {
                [self.navigationController popToViewController:controller animated:YES];
            }
        }
    }else if ([_TypeStr integerValue] == 2){
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[ModifySailViewController   class]]) {
                [self.navigationController popToViewController:controller animated:YES];
            }
        }
    }
}
- (void)initUI{
    phoneNumView = [[CustomView alloc]init];
    phoneNumView.NameLabel.text = @"手机号码:";
    phoneNumView.NameTextField.placeholder = @"请输入手机号";
    phoneNumView.NameTextField.delegate = self;
    phoneNumView.NameTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:phoneNumView];
    [phoneNumView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self.view.mas_top).offset(15);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(40);
    }];
    
    CodeNumView = [[CustomView alloc]init];
    CodeNumView.NameLabel.text = @"短信验证码:";
    CodeNumView.NameTextField.placeholder = @"请输入短信验证码";
    CodeNumView.NameTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    CodeNumView.NameTextField.delegate = self;
    [CodeNumView.NameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(90);
    }];
    [CodeNumView.NameTextField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(CodeNumView.mas_right).offset(-80);
    }];
    [self.view addSubview:CodeNumView];
    [CodeNumView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(phoneNumView.mas_bottom).offset(15);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(40);
    }];
    
    _GetCode = [[UIButton alloc] init];
    [_GetCode setTitle:@"获取" forState:UIControlStateNormal];
    _GetCode.titleLabel.font = [UIFont systemFontOfSize:16];
    [_GetCode setBackgroundColor:colorWithRGB(0.95, 0.6, 0.11)];
    [_GetCode setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_GetCode addTarget:self action:@selector(forgetSenderCodeBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [CodeNumView addSubview:_GetCode];
    [_GetCode mas_makeConstraints:^(MASConstraintMaker* make) {
        make.top.mas_equalTo(CodeNumView.mas_top);
        make.right.mas_equalTo(self.view.mas_right);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(40);
    }];
    
    NewPassWordView = [[CustomView alloc]init];
    NewPassWordView.NameLabel.text = @"新交易密码:";
    NewPassWordView.NameTextField.placeholder = @"密码最少6位";
    NewPassWordView.NameTextField.delegate = self;
    NewPassWordView.NameTextField.secureTextEntry = YES;
    [self.view addSubview:NewPassWordView];
//    [NewPassWordView.NameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(110);
//    }];
    [NewPassWordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(CodeNumView.mas_bottom).offset(15);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(40);
    }];
    
    SurePassWordView = [[CustomView alloc]init];
    SurePassWordView.NameLabel.text = @"确认交易密码:";
    SurePassWordView.NameTextField.placeholder = @"请再次输入交易密码";
    SurePassWordView.NameTextField.delegate = self;
    SurePassWordView.NameTextField.secureTextEntry = YES;
    [self.view addSubview:SurePassWordView];
    [SurePassWordView.NameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100);
    }];
    [SurePassWordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(NewPassWordView.mas_bottom).offset(15);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(40);
    }];
    
    UIButton * PushBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [PushBtn setTitle:@"提交" forState:UIControlStateNormal];
    PushBtn.layer.masksToBounds = YES;
    PushBtn.layer.cornerRadius = 22;
    PushBtn.backgroundColor = colorWithRGB(0.95, 0.6, 0.11);
    [PushBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    PushBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [PushBtn addTarget:self action:@selector(PostBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:PushBtn];
    [PushBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.top.mas_equalTo(SurePassWordView.mas_bottom).offset(15);
        make.height.mas_equalTo(44);
    }];
}
#pragma mark - 提交 -
- (void)PostBtnClick{
    
    if (phoneNumView.NameTextField.text.length) {
        if (CodeNumView.NameTextField.text.length) {
            if (NewPassWordView.NameTextField.text.length) {
                if (SurePassWordView.NameTextField.text.length) {
                    if (NewPassWordView.NameTextField.text.length < 6) {
                        normal_alert(@"提示", @"密码不得小于6位", @"确定");
                        
                    }else{
                        if (SurePassWordView.NameTextField.text == NewPassWordView.NameTextField.text) {
                            [self postForgetCode];
                        }else{
                            normal_alert(@"提示", @"二次密码不一致请重新输入", @"确定");
                            
                        }
                    }
                }else{
                    normal_alert(@"提示", @"确认新密码不可为空", @"确定");
                    
                }
            }else{
                normal_alert(@"提示", @"新登录密码不可为空", @"确定");
                
            }
        }else{
            normal_alert(@"提示", @"短信验证码不可为空", @"确定");
            
        }
    }else{
        normal_alert(@"提示", @"手机号码不可为空", @"确定");
    }
}

- (void)postForgetCode{
    NSString *passStr = [NewPassWordView.NameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

    NSMutableDictionary * YWDDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:phoneNumView.NameTextField.text,@"phoneNumber",CodeNumView.NameTextField.text,@"captcha",passStr,@"newDealPassword", nil];
    NSString *url = [NSString stringWithFormat:@"%@/retrieveDealPassword",USER_URL];
    [[DateSource sharedInstance]requestHomeWithParameters:YWDDic withUrl:url withTokenStr:nil usingBlock:^(NSDictionary *result, NSError *error) {
        if ([[result objectForKey:@"statusCode"]integerValue] == 201) {

                normal_alert(@"提示", @"密码修改成功", @"确定");
            for (UIViewController *controller in self.navigationController.viewControllers) {
                if ([controller isKindOfClass:[UserSetViewController class]]) {
                    [self.navigationController popToViewController:controller animated:YES];
                }
            }
            for (UIViewController *controller in self.navigationController.viewControllers) {
                if ([controller isKindOfClass:[TouUpViewController class]]) {
                    [self.navigationController popToViewController:controller animated:YES];
                }
            }
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    for (UIViewController *controller in self.navigationController.viewControllers) {
//                        if ([controller isKindOfClass:[TouUpViewController class]]) {
//                            [self.navigationController popToViewController:controller animated:YES];
//                        }
//                    }
//
//                });

        }else{
            NSString *message = [result objectForKey:@"message"];
            normal_alert(@"提示", message, @"确定　");
        }
//        //注册成功or失败
//        [self dismissViewControllerAnimated:NO completion:nil];
        
    }];
    
    
    
}


- (void)forgetSenderCodeBtnClicked{
    if (phoneNumView.NameTextField.text.length) {
        [self codeGet];
    }else{
        normal_alert(@"提示", @"手机号码不可为空", @"确定");
    }
}



- (void)codeGet{
   
    NSString *phoneRegex = @"^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    BOOL isMatch  = [phoneTest evaluateWithObject:phoneNumView.NameTextField.text];
    if (!isMatch) {
        normal_alert(@"提示", @"请输入正确的手机号", @"确定");
        
    }else{
        _second = 90;
        _securityCodeTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timing) userInfo:nil repeats:YES];
        NSMutableDictionary * YWDDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:phoneNumView.NameTextField.text ,@"phoneNumber",@"6",@"type",nil];
        //验证码获取陈功or失败
        [[DateSource sharedInstance]requestHomeWithParameters:YWDDic withUrl:SMS_URL withTokenStr:nil usingBlock:^(NSDictionary *result, NSError *error) {
            if ([[result objectForKey:@"success"]integerValue]==1 ) {
                normal_alert(@"提示", @"验证码已发送", @"确定");
            }else{
                NSString *ErrorMessage = [result objectForKey:@"message"];
                normal_alert(@"提示", ErrorMessage, @"确定");
                
            }
            
        }];
        
        
        
        
    }
    
}
#pragma mark  - - 验证码倒计时 - -
- (void)timing
{
    if (_second > 0) {
        _second--; // 时间递减
        NSString* title = [NSString stringWithFormat:@"%dS", _second];
        _GetCode.enabled = NO;
        [_GetCode setTitle:title forState:UIControlStateDisabled];
    }
    else if (_second == 0) {
        [_securityCodeTimer invalidate];
        _GetCode.enabled = YES;
        [_GetCode setTitle:@"重新发送" forState:UIControlStateNormal];
    }
}
#pragma mark -UITextFieldDelegate -
- (void)textFieldDidBeginEditing:(UITextField *)textField{
//    textField.placeholder = @"";
//    textField.textAlignment = NSTextAlignmentLeft;
}
- (void)ReginAndLoginBackClick{
    [self.navigationController popToRootViewControllerAnimated:NO];
}


- (void)ForgetPassClickBag{
    [self HideKeyBoardClick];
}

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

- (void)CallBackClick{
    
    if ([_TypeStr integerValue]== 1) {
            //  返回指定页面
            for (UIViewController *controller in self.navigationController.viewControllers) {
                if ([controller isKindOfClass:[TouUpViewController class]]) {
                    [self.navigationController popToViewController:controller animated:YES];
                }
            }
    }

    
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
