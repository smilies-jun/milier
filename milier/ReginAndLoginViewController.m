
//
//  ReginAndLoginViewController.m
//  YWD
//
//  Created by 007 on 15/10/29.
//  Copyright © 2015年 star. All rights reserved.
//

#import "ReginAndLoginViewController.h"
#import "customWithStatic.h"
#import "CustomView.h"
#import "YWDAlertView.h"
#import "YWDAlertView.h"
#import "popupFade.h"


@interface ReginAndLoginViewController (){
    customWithStatic  *UsertPhoneView;
    customWithStatic  *PhoneView;
    customWithStatic  *PassView;
    CustomView *callView;
     int _second;
    
    UIView *alphaBagView;//遮罩
    YWDAlertView *alertView;
    popupFade *fadeSort;

}

@end

@implementation ReginAndLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.TopView.hidden = NO;
    self.view.backgroundColor = colorWithRGB(0.94, 0.94, 0.94);
    self.TopTitleLabel.text = @"注册";
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKey)];
    [self.view addGestureRecognizer:tap];
    
    [self.BackButton addTarget:self action:@selector(ReginAndLoginBackClick) forControlEvents:UIControlEventTouchUpInside];
    
    if (_codeStr.length) {
        [self senderInputSecurityCodeBtnClicked];
    }
    [self initUI];
    [self initAlertView];
}
- (void)initUI{
    
    UsertPhoneView = [[customWithStatic alloc]init];
    UsertPhoneView.NameLabel.text = @"手机号码:";
//    [UsertPhoneView.NameTextField mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(UsertPhoneView.mas_right).offset(-10);
//    }];
    UsertPhoneView.NameTextField.delegate = self;
    UsertPhoneView.NameTextField.secureTextEntry = YES;
    UsertPhoneView.NameTextField.placeholder = @"请输入手机号码";
    [self.view addSubview:UsertPhoneView];
    [UsertPhoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.top.mas_equalTo(self.TopView.mas_bottom).offset(20);
        make.height.mas_equalTo(40);
    }];

    
    
    PhoneView = [[customWithStatic alloc]init];
    PhoneView.NameLabel.text = @"短信验证码:";
    PhoneView.NameTextField.keyboardType = UIKeyboardTypeNumberPad;
    PhoneView.NameTextField.delegate = self;
    [self.view addSubview:PhoneView];
    [PhoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.top.mas_equalTo(UsertPhoneView.mas_bottom).offset(10);
        make.height.mas_equalTo(40);
    }];
    
    
    _GetCode = [[UIButton alloc] init];
    [_GetCode setTitle:@"获取" forState:UIControlStateNormal];
    _GetCode.titleLabel.font = [UIFont systemFontOfSize:16];
    [_GetCode setBackgroundColor:colorWithRGB(0.19, 0.69, 0.42)];
    [_GetCode setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_GetCode addTarget:self action:@selector(senderInputSecurityCodeBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [PhoneView addSubview:_GetCode];
    
    [_GetCode mas_makeConstraints:^(MASConstraintMaker* make) {
        make.top.mas_equalTo(PhoneView.mas_top);
        make.right.mas_equalTo(self.view.mas_right);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(40);
    }];
    
    PassView = [[customWithStatic alloc]init];
    PassView.NameLabel.text = @"登录密码:";
    [PassView.NameTextField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(PassView.mas_right).offset(-10);
    }];
    PassView.NameTextField.delegate = self;
    PassView.NameTextField.secureTextEntry = YES;
    PassView.NameTextField.placeholder = @"登录密码最少6位";
    [self.view addSubview:PassView];
    [PassView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.top.mas_equalTo(PhoneView.mas_bottom).offset(10);
        make.height.mas_equalTo(40);
    }];
    callView = [[CustomView alloc]init];
    callView.NameLabel.text= @"邀请码:";
    callView.NameTextField.placeholder = @"";
    callView.NameTextField.delegate = self;
    [self.view addSubview:callView];
    [callView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(PassView.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(40);
    }];
    
    UIButton *reginBtn = [[UIButton alloc]init];
    [reginBtn setBackgroundColor:colorWithRGB(0.96, 0.21, 0.29)];
    reginBtn.layer.masksToBounds = YES;
    reginBtn.layer.cornerRadius = 5.0f;
    [reginBtn setTitle:@"注册并登录" forState:UIControlStateNormal];
    [reginBtn addTarget:self action:@selector(ReginAndLoginClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:reginBtn];
    [reginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.top.mas_equalTo(callView.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH - 40);
        make.height.mas_equalTo(40);
    }];
}
- (void)initAlertView{
    alphaBagView = [[UIView alloc]init];
    alphaBagView.alpha = 0.5;
    alphaBagView.hidden = YES;
    alphaBagView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    alphaBagView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:alphaBagView];
    
    alertView = [[YWDAlertView alloc]init];
    alertView.frame = CGRectMake(20, SCREEN_HEIGHT/2 - 100, SCREEN_WIDTH - 40, 200);
    alertView.alpha = 0.0f;
    [self.view addSubview:alertView];
    [alertView clickedSure:^(int type) {
        if (type == 1) {
            alphaBagView.hidden = YES;
            fadeSort = [[popupFade alloc]init];
            [fadeSort dismissView:alertView completion:^{
                
            }];
        }else{
            [self.navigationController dismissViewControllerAnimated:NO completion:^{
                
            }];
        }
    }];
    
    
}

- (void)ReginAndLoginClicked{
    [self dismissViewControllerAnimated:NO completion:nil];
    if (PhoneView.NameTextField.text.length) {
        if (PassView.NameTextField.text.length) {
            [self ReginClicked];
  
        }else{
            normal_alert(@"提示", @"登录密码不可为空" , @"确定");
  
        }
    }else{
        normal_alert(@"提示", @"验证码不可为空" , @"确定");
 
    }
    
    
}



- (void)ReginClicked{
//    NSMutableDictionary * YWDDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:_codeStr ,@"phone",PassView.NameTextField.text,@"newPwd",PhoneView.NameTextField.text,@"newSms", nil];
//    if (callView.NameTextField.text) {
//        [YWDDic   setObject:callView.NameTextField.text forKey:@"parentId"];
//    }
//    [[DateSource sharedInstance]requestHomeWithParameters:YWDDic withUrl:[NSString stringWithFormat:@"%@/phone/register",TestSeverURL] usingBlock:^(NSDictionary *result, NSError *error) {
//        NSLog(@"result= %@",result);
//        NSString *code = [result objectForKey:@"retcode"];
//        NSLog(@"code = %@",code );
//        if ([code intValue] == 1000) {
//            NSuserSave([result objectForKey:@"token"], @"token");
//            NSuserSave(_codeStr, @"phone");
//            NSuserSave(PassView.NameTextField.text, @"password");
//            NSuserSave(@"1", @"state");
//            [[NSUserDefaults standardUserDefaults]synchronize];
//            [self showAlert];
//            
//        }else{
//            NSString *AlertStr = [result objectForKey:@"retdesc"];
//            normal_alert(@"提示", AlertStr , @"确定");
//        }
//    }];
}
- (void)showAlert{
    alphaBagView.hidden = NO;
    fadeSort = [[popupFade alloc]init];
    [fadeSort showView:alertView];
}
#pragma mark 获取验证码
- (void)senderInputSecurityCodeBtnClicked

{
//    _second = 90;
//    _securityCodeTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timing) userInfo:nil repeats:YES];
//    NSString *phoneRegex = @"^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$";
//    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
//    BOOL isMatch  = [phoneTest evaluateWithObject:_codeStr];
//    if (!isMatch) {
//        normal_alert(@"提示", @"请输入正确的手机号", @"确定");
//        
//    }else{
//        NSMutableDictionary * YWDDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:_codeStr ,@"phone", nil];
//        [[DateSource sharedInstance]requestHomeWithParameters:YWDDic withUrl:[NSString stringWithFormat:@"%@/phone/getSms",TestSeverURL] usingBlock:^(NSDictionary *result, NSError *error) {
//            NSString *code = [result objectForKey:@"retcode"];
//            if ([code intValue] == 1000) {
//                normal_alert(@"提示", @"验证码已发送您的手机注意查收", @"确定");
//
//            }else{
//                NSString *AlertStr = [result objectForKey:@"retdesc"];
//                normal_alert(@"提示", AlertStr , @"确定");
//            }
//        }];
//    }
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
- (void)hideKey{
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
