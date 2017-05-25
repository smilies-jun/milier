//
//  YWDLoginViewController.m
//  YWD
//
//  Created by 007 on 15/10/28.
//  Copyright © 2015年 star. All rights reserved.
//

#import "YWDLoginViewController.h"
#import "ReginAndLoginViewController.h"



@interface YWDLoginViewController ()<UITextFieldDelegate>
@end

@implementation YWDLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    [self initView];
    [self initUIView];
}
- (void)initView{
    _bagView = [[UIImageView alloc]init];
    _bagView.userInteractionEnabled = YES;
    UITapGestureRecognizer *bagTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(HideKeyBoardClick)];
    [_bagView addGestureRecognizer:bagTap];
    _bagView.backgroundColor = [UIColor whiteColor];
    _bagView.image = [UIImage imageNamed:@"loginbg"];
    [self.view addSubview:_bagView];
    [_bagView mas_makeConstraints:^(MASConstraintMaker *make) {
       // make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view.mas_top);
        make.left.mas_equalTo(self.view.mas_left);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(SCREEN_HEIGHT);

    }];
    
}

- (void)initUIView{
//    _TitleLabel = [[UILabel alloc]init];
//    _TitleLabel.text = @"登录";
//    [_TitleLabel setFont:[UIFont systemFontOfSize:18]];
//    _TitleLabel.textAlignment = NSTextAlignmentCenter;
//    [self.view addSubview:_TitleLabel];
//    [_TitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(self.view.mas_centerX);
//        make.top.mas_equalTo(self.view.mas_top).offset(20);
//        make.width.mas_equalTo(40);
//        make.height.mas_equalTo(30);
//    }];
  //    _YWDImageView = [[UIImageView alloc]init];
//    _YWDImageView.image = [UIImage imageNamed:@"login_logo"];
//    [_bagView addSubview:_YWDImageView];
//    
//    [_YWDImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(_bagView.mas_centerX);
//        make.top.mas_equalTo(_bagView.mas_top).offset(40+44);
//        make.width.mas_equalTo(110);
//        make.height.mas_equalTo(125);
//    }];
    
    _userNameBackImageView = [[UIImageView alloc]init];
    _userNameBackImageView.userInteractionEnabled = YES;
    _userNameBackImageView.backgroundColor = [UIColor whiteColor];
    _userNameBackImageView.layer.masksToBounds = YES;
    _userNameBackImageView.layer.cornerRadius = 5.0f;
    [_bagView addSubview:_userNameBackImageView];
    [_userNameBackImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_bagView.mas_left).offset(20);
        make.right.mas_equalTo(_bagView.mas_right).offset(-20);
        make.centerY.mas_equalTo(_bagView.mas_centerY);
        make.height.mas_equalTo(45);
    }];
    _PhoneIconImageView = [[UIImageView alloc]init];
    _PhoneIconImageView.image = [UIImage imageNamed:@"phone"];
    [_userNameBackImageView addSubview:_PhoneIconImageView];
    [_PhoneIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_userNameBackImageView.mas_left).offset(5);
        make.centerY.mas_equalTo(_userNameBackImageView.mas_centerY);
        make.width.mas_equalTo(18);
        make.height.mas_equalTo(18);
    }];
    _PhoneTextField = [[UITextField alloc]init];
    _PhoneTextField.placeholder = @"请输入手机号码";
    _PhoneTextField.delegate = self;
    _PhoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    _PhoneTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入手机号码" attributes:@{NSForegroundColorAttributeName: colorWithRGB(0.71, 0.75, 0.72)}];
    [_userNameBackImageView addSubview:_PhoneTextField];
    [_PhoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_PhoneIconImageView.mas_right).offset(10);
        make.centerY.mas_equalTo(_userNameBackImageView.mas_centerY);
        make.right.mas_equalTo(self.view.mas_right).offset(20);
        make.height.mas_equalTo(25);
    }];

    _PassWordBackImageView = [[UIImageView alloc]init];
    _PassWordBackImageView.backgroundColor = [UIColor whiteColor];
    _PassWordBackImageView.userInteractionEnabled = YES;
    _PassWordBackImageView.layer.masksToBounds = YES;
    _PassWordBackImageView.layer.cornerRadius = 5.0f;
    [_bagView addSubview:_PassWordBackImageView];
    [_PassWordBackImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_bagView.mas_left).offset(20);
        make.right.mas_equalTo(_bagView.mas_right).offset(-20);
        make.top.mas_equalTo(_userNameBackImageView.mas_bottom).offset(10);
        make.height.mas_equalTo(45);
    }];
   
    _PassWordIconImageView= [[UIImageView alloc]init];
    _PassWordIconImageView.image = [UIImage imageNamed:@"key"];
    [_PassWordBackImageView addSubview:_PassWordIconImageView];
    [_PassWordIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_PassWordBackImageView.mas_left).offset(5);
        make.centerY.mas_equalTo(_PassWordBackImageView.mas_centerY);
        make.width.mas_equalTo(18);
        make.height.mas_equalTo(18);
    }];
    _PassWordTextField = [[UITextField alloc]init];
    _PassWordTextField.placeholder = @"请输入登录密码";
    _PassWordTextField.delegate = self;
    _PassWordTextField.secureTextEntry = YES;
    //_PassWordTextField.keyboardType = UIKeyboardTypeNumberPad;
    _PassWordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入登录密码" attributes:@{NSForegroundColorAttributeName: colorWithRGB(0.71, 0.75, 0.72)}];
    [_PassWordBackImageView addSubview:_PassWordTextField];
    [_PassWordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_PassWordIconImageView.mas_right).offset(10);
        make.centerY.mas_equalTo(_PassWordIconImageView.mas_centerY);
        make.right.mas_equalTo(self.view.mas_right).offset(20);
        make.height.mas_equalTo(25);
    }];

    _LoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_LoginBtn setTitle:@"登录" forState:UIControlStateNormal];
    _LoginBtn.layer.masksToBounds = YES;
    _LoginBtn.layer.cornerRadius = 5.0f;
    _LoginBtn.backgroundColor =colorWithRGB(0.99, 0.79, 0.09);
    [_LoginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _LoginBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_LoginBtn addTarget:self action:@selector(LoginNextBtn) forControlEvents:UIControlEventTouchUpInside];
    [_bagView   addSubview:_LoginBtn];
    [_LoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.top.mas_equalTo(_PassWordBackImageView.mas_bottom).offset(10);
        make.height.mas_equalTo(40);
    }];
    
    _ForgetPasswordLabel  = [[UILabel alloc]init];
    _ForgetPasswordLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *ForgetPassLabel = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ForgetPassClick)];
    [_ForgetPasswordLabel addGestureRecognizer:ForgetPassLabel];
    NSMutableAttributedString *ConnectStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"忘记密码?"]];
    NSRange conectRange = {0,[ConnectStr length]};
    [ConnectStr addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:conectRange];
    _ForgetPasswordLabel.attributedText = ConnectStr;
    _ForgetPasswordLabel.textColor= colorWithRGB(0.99, 0.79, 0.09);
    _ForgetPasswordLabel.font = [UIFont systemFontOfSize:13];
    [_bagView addSubview:_ForgetPasswordLabel];
    [_ForgetPasswordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.top.mas_equalTo(_LoginBtn.mas_bottom).offset(5);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    }];
    
    _ReginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_ReginButton setTitle:@"注册" forState:UIControlStateNormal];
    _ReginButton.titleLabel.textAlignment = NSTextAlignmentRight;
    [_ReginButton addTarget:self action:@selector(ReginClick) forControlEvents:UIControlEventTouchUpInside];
    [_ReginButton setTitleColor:colorWithRGB(0.99, 0.79, 0.09) forState:UIControlStateNormal];
    _ReginButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:_ReginButton];
    [_ReginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.top.mas_equalTo(_LoginBtn.mas_bottom).offset(5);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(20);
    }];

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
#pragma Mark - UitextField -

//在UITextField 编辑之前调用方法
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField: textField up: YES];
}
//在UITextField 编辑完成调用方法
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField: textField up: NO];
}
//视图上移的方法
- (void) animateTextField: (UITextField *) textField up: (BOOL) up
{
    const int movementDistance = 60;
    int move = (up ? -movementDistance : 0);
    [UIView beginAnimations: @"Animation" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: 2.20];
    
    [_bagView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(move);
    }];
    [UIView commitAnimations];
}
#pragma Mark - menthod-
- (void)ReginClick{
    [self HideKeyBoardClick];
    ReginAndLoginViewController *reVC= [[ReginAndLoginViewController alloc]init];
    [self.navigationController pushViewController:reVC animated:NO];
}
- (void)ForgetPassClick{
    YWDForgetPassWordViewController *ForgetVC = [[YWDForgetPassWordViewController alloc]init];
    [self.navigationController pushViewController:ForgetVC animated:NO];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
    [super viewWillDisappear:animated];
}
#pragma 正则匹配手机号
-(BOOL)checkTelNumber:(NSString *) telNumber
{
    NSString *MOBILE = @"^1[34578]\\d{9}$";
    
    NSPredicate *regexTestMobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",MOBILE];
    /*
     if ([regexTestMobile evaluateWithObject:self]) {
     
     return YES;
     
     }else {
     
     return NO;
     
     }*/
    return [regexTestMobile evaluateWithObject:telNumber];
}
- (void)LoginNextBtn{
    if ([self checkTelNumber:_PhoneTextField.text]) {
        if (_PassWordTextField.text.length) {
            if (_PassWordTextField.text.length >= 6) {
                NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:_PhoneTextField.text,@"username",_PassWordTextField.text,@"password",nil];
                [[DateSource sharedInstance]requestHomeWithParameters:dic withUrl:LOGIN_URL withTokenStr:nil usingBlock:^(NSDictionary *result, NSError *error) {
                    if ([[result objectForKey:@"statusCode"]integerValue] == 201) {
                        NSDictionary *dic = [result objectForKey:@"data"];
                        NSuserSave([dic objectForKey:@"accessToken"], @"Authorization");
                        NSuserSave([dic objectForKey:@"userId"], @"userId");
                        [self dismissViewControllerAnimated:NO completion:nil];
                    }else{
                        NSString *message = [result objectForKey:@"message"];
                        normal_alert(@"提示",message, @"确定");
                    }
                    NSLog(@"re = %@",result);

                }];
            }else{
                normal_alert(@"提示", @"密码至少6位", @"确定");

            }
        }else{
            normal_alert(@"提示", @"密码不能为空", @"确定");
  
        }
        
        
    }else{
        normal_alert(@"提示", @"手机号不能为空", @"确定");
    }
   
    
//    [[DateSource sharedInstance]requestPutWithParameters:dic withUrl:@"https://192.168.1.34:8443/tokens" usingBlock:^(NSDictionary *result, NSError *error) {
//        NSLog(@"put = %@",result);
//    }];
//    NSMutableDictionary * YWDDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"2222" ,@"userPwd", @"23232",@"phone",@"2",@"userFlag",nil];
//    [[DateSource sharedInstance]requestHtml5WithParameters:nil withUrl:@"https://192.168.1.34:8443/products/1" usingBlock:^(NSDictionary *result, NSError *error) {
//        NSLog(@"result = %@",result);
//    }];
//    if (_PhoneTextField.text.length) {
//        
//        NSMutableDictionary * YWDDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@",_PhoneTextField.text] ,@"phone", [NSString stringWithFormat:@"%@",_PassWordTextField.text],@"userPwd",@"2",@"userFlag",nil];
//        [[DateSource sharedInstance]requestHomeWithParameters:YWDDic withUrl:[NSString stringWithFormat:@"%@/phone/login",TestSeverURL] usingBlock:^(NSDictionary *result, NSError *error) {
//            NSString *code = [result objectForKey:@"retcode"];
//            if ([code intValue] == 1000) {
//                NSuserSave([result objectForKey:@"token"], @"token");
//                NSuserSave(_PhoneTextField.text, @"phone");
//                NSuserSave(_PassWordTextField.text, @"password");
//                NSuserSave(@"1", @"state");
//                [[NSUserDefaults standardUserDefaults]synchronize];
//                [self.navigationController dismissViewControllerAnimated:NO completion:^{
//                    
//                }];
////                YWDLoginNextViewController *LoginNextVC = [[YWDLoginNextViewController alloc]init];
////                LoginNextVC.phoneStr = _PhoneTextField.text;
////                [self.navigationController pushViewController:LoginNextVC animated:NO];
//            }else{
//                NSString *AlertStr = [result objectForKey:@"retdesc"];
//                normal_alert(@"提示", AlertStr , @"确定");
//            }
//        }];
//        
//        
//    }else{
//        normal_alert(@"提示", @"手机号不可为空", @"确定");
//
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"手机号码不可为空" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        [alert show];
//    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@" = = %ld",(long)buttonIndex);
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
