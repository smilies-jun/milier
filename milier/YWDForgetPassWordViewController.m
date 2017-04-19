//
//  YWDForgetPassWordViewController.m
//  YWD
//
//  Created by 007 on 15/10/28.
//  Copyright © 2015年 star. All rights reserved.
//

#import "YWDForgetPassWordViewController.h"
#import "CustomView.h"

@interface YWDForgetPassWordViewController (){
    CustomView *phoneNumView;
    CustomView *CodeNumView;
    CustomView *NewPassWordView;
    CustomView *SurePassWordView;
    int _second;

}

@end

@implementation YWDForgetPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.TopView.hidden = NO;
    self.view.backgroundColor = colorWithRGB(0.94, 0.94, 0.94);
    self.TopTitleLabel.text = @"找回登录密码";
    [self.BackButton addTarget:self action:@selector(CallBackClick) forControlEvents:UIControlEventTouchUpInside];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ForgetPassClickBag)];
    [self.view addGestureRecognizer:tap];
    [self initUI];
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
        make.top.mas_equalTo(self.TopView.mas_bottom).offset(15);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(40);
    }];
    
    CodeNumView = [[CustomView alloc]init];
    CodeNumView.NameLabel.text = @"短信验证码:";
    CodeNumView.NameTextField.placeholder = @"";
    CodeNumView.NameTextField.keyboardType = UIKeyboardTypeNumberPad;

    CodeNumView.NameTextField.delegate = self;
    [CodeNumView.NameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(80);
    }];
    [CodeNumView.NameTextField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(CodeNumView.mas_right).offset(-60);
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
    [_GetCode setBackgroundColor:colorWithRGB(0.19, 0.69, 0.42)];
    [_GetCode setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_GetCode addTarget:self action:@selector(forgetSenderCodeBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [CodeNumView addSubview:_GetCode];
    [_GetCode mas_makeConstraints:^(MASConstraintMaker* make) {
        make.top.mas_equalTo(CodeNumView.mas_top);
        make.right.mas_equalTo(self.view.mas_right);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(40);
    }];
    
    NewPassWordView = [[CustomView alloc]init];
    NewPassWordView.NameLabel.text = @"新登录密码:";
    NewPassWordView.NameTextField.placeholder = @"密码最少6位";
    NewPassWordView.NameTextField.delegate = self;
    NewPassWordView.NameTextField.secureTextEntry = YES;
    [self.view addSubview:NewPassWordView];
    [NewPassWordView.NameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(80);
    }];
    [NewPassWordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(CodeNumView.mas_bottom).offset(15);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(40);
    }];
    
    SurePassWordView = [[CustomView alloc]init];
    SurePassWordView.NameLabel.text = @"确认新密码:";
    SurePassWordView.NameTextField.placeholder = @"请再次输入登录密码";
    SurePassWordView.NameTextField.delegate = self;
    SurePassWordView.NameTextField.secureTextEntry = YES;
    [self.view addSubview:SurePassWordView];
    [SurePassWordView.NameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(80);
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
    PushBtn.layer.cornerRadius = 5.0f;
    PushBtn.backgroundColor = colorWithRGB(0.96, 0.21, 0.29);
    [PushBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    PushBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [PushBtn addTarget:self action:@selector(PostBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:PushBtn];
    [PushBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.top.mas_equalTo(SurePassWordView.mas_bottom).offset(15);
        make.height.mas_equalTo(40);
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
                            [self postCode];
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

- (void)postCode{
    NSMutableDictionary * YWDDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:phoneNumView.NameTextField.text,@"phone",CodeNumView.NameTextField.text,@"newSms",NewPassWordView.NameTextField.text,@"newPwd1",SurePassWordView.NameTextField.text,@"newPwd2", nil];

    [[DateSource sharedInstance]requestHomeWithParameters:YWDDic withUrl:[NSString stringWithFormat:@"%@/phone/backPwd",TestSeverURL] usingBlock:^(NSDictionary *result, NSError *error) {
        NSString *code = [result objectForKey:@"retcode"];
        if ([code intValue] == 1000) {
           //登陆
            NSuserSave([result objectForKey:@"token"], @"token");
            NSuserSave(@"1", @"state");
            [[NSUserDefaults standardUserDefaults]synchronize];
            [self.navigationController dismissViewControllerAnimated:NO completion:^{
                
            }];
        }else{
            NSString *AlertStr = [result objectForKey:@"retdesc"];
            normal_alert(@"提示", AlertStr , @"确定");
        }
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
    _second = 90;
    _securityCodeTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timing) userInfo:nil repeats:YES];
    NSString *phoneRegex = @"^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    BOOL isMatch  = [phoneTest evaluateWithObject:phoneNumView.NameTextField.text];
    if (!isMatch) {
        normal_alert(@"提示", @"请输入正确的手机号", @"确定");
        
    }else{
        NSMutableDictionary * YWDDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:phoneNumView.NameTextField.text,@"phone", nil];
        [[DateSource sharedInstance]requestHomeWithParameters:YWDDic withUrl:[NSString stringWithFormat:@"%@/phone/getSms",TestSeverURL] usingBlock:^(NSDictionary *result, NSError *error) {
            NSString *code = [result objectForKey:@"retcode"];
            if ([code intValue] == 1000) {
                normal_alert(@"提示", @"验证码已发送您的手机注意查收", @"确定");
                
            }else{
                NSString *AlertStr = [result objectForKey:@"retdesc"];
                normal_alert(@"提示", AlertStr , @"确定");
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
    textField.placeholder = @"";
    textField.textAlignment = NSTextAlignmentLeft;
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



- (void)CallBackClick{
    [self.navigationController popToRootViewControllerAnimated:NO];
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
