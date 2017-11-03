//
//  ActivityRefinViewController.m
//  milier
//
//  Created by amin on 2017/6/23.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "ActivityRefinViewController.h"
#import "customWithStatic.h"
#import "CustomView.h"
#import "YWDAlertView.h"
#import "YWDAlertView.h"
#import "popupFade.h"
#import "ProtocalViewController.h"
#import "ActivityDetailViewController.h"
#import "YWDLoginViewController.h"
#import "FirstViewController.h"

@interface ActivityRefinViewController ()<UITextFieldDelegate>{
    customWithStatic  *UsertPhoneView;
    customWithStatic  *PhoneView;
    customWithStatic  *PassView;
    CustomView *callView;
    int _second;
    UIButton *ClickBtn;
    UIView *alphaBagView;//遮罩
    YWDAlertView *alertView;
    popupFade *fadeSort;
    
}


@end

@implementation ActivityRefinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"注册";
    self.view.backgroundColor = colorWithRGB(0.97, 0.97, 0.97);
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(0, 7, 18, 18);
    [leftBtn setImage:[UIImage imageNamed:@"backarrow@2x.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(ReginAndLoginBackClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;

    
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
    UsertPhoneView.NameTextField.placeholder = @"请输入手机号码";
    [self.view addSubview:UsertPhoneView];
    [UsertPhoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.top.mas_equalTo(self.view.mas_top).offset(20);
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
    [_GetCode setBackgroundColor:colorWithRGB(0.95, 0.6, 0.11)];
    [_GetCode setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_GetCode addTarget:self action:@selector(senderInputSecurityCodeBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [PhoneView addSubview:_GetCode];
    
    [_GetCode mas_makeConstraints:^(MASConstraintMaker* make) {
        make.top.mas_equalTo(PhoneView.mas_top);
        make.right.mas_equalTo(self.view.mas_right);
        make.width.mas_equalTo(90);
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
    ClickBtn = [[UIButton alloc]init];
    [ClickBtn setBackgroundImage:[UIImage imageNamed:@"uncheck"] forState:UIControlStateNormal];
    ClickBtn.selected = YES;
    [ClickBtn setBackgroundImage:[UIImage imageNamed:@"check"] forState:UIControlStateSelected];
    [ClickBtn addTarget:self action:@selector(Agreeclicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ClickBtn];
    [ClickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.top.mas_equalTo(callView.mas_bottom).offset(10);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    UILabel *nameLabel =[[UILabel alloc]init];
    nameLabel.font = [UIFont systemFontOfSize:15];
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
        make.top.mas_equalTo(callView.mas_bottom).offset(10);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(15);
    }];
    
    UIButton *reginBtn = [[UIButton alloc]init];
    [reginBtn setBackgroundColor:colorWithRGB(0.95, 0.6, 0.11)];
    reginBtn.layer.masksToBounds = YES;
    reginBtn.layer.cornerRadius = 20.0f;
    [reginBtn setTitle:@"注册" forState:UIControlStateNormal];
    [reginBtn addTarget:self action:@selector(ReginAndLoginClickedActivity) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:reginBtn];
    [reginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.top.mas_equalTo(callView.mas_bottom).offset(40);
        make.width.mas_equalTo(SCREEN_WIDTH - 40);
        make.height.mas_equalTo(40);
    }];
}

- (void)ReginAndLoginClickedActivity{
    if (PhoneView.NameTextField.text.length) {
        if (PassView.NameTextField.text.length) {
            if (ClickBtn.selected) {
                [self ReginClicked];
                
            }else{
                normal_alert(@"提示", @"请同意协议" , @"确定");
                
            }
            
            
        }else{
            normal_alert(@"提示", @"登录密码不可为空" , @"确定");
            
        }
    }else{
        normal_alert(@"提示", @"验证码不可为空" , @"确定");
        
    }
    
    
}


-(void)Agreeclicked:(UIButton *)btn{
    if (btn.selected) {
        btn.selected = NO;
    }else{
        btn.selected = YES;
    }
    
}

- (void)gesClick{
    // 协议跳转
    ProtocalViewController *vc= [[ProtocalViewController alloc]init];
    [self.navigationController pushViewController:vc animated:NO];
    
    
    
    
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
            [self.navigationController popToRootViewControllerAnimated:NO ];

        }
    }];
    
    
}

- (void)ReginlTap{
    if (PhoneView.NameTextField.text.length) {
        if (PassView.NameTextField.text.length) {
            if (ClickBtn.selected) {
                [self ReginClicked];
                
            }else{
                normal_alert(@"提示", @"请同意协议" , @"确定");
                
            }
            
            
        }else{
            normal_alert(@"提示", @"登录密码不可为空" , @"确定");
            
        }
    }else{
        normal_alert(@"提示", @"验证码不可为空" , @"确定");
        
    }
    
    
}



- (void)ReginClicked{
    NSMutableDictionary * YWDDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:UsertPhoneView.NameTextField.text ,@"phoneNumber",PassView.NameTextField.text,@"password",PhoneView.NameTextField.text,@"captcha", nil];
    if (callView.NameTextField.text) {
        [YWDDic   setObject:callView.NameTextField.text forKey:@"parentId"];
    }
    
    [[DateSource sharedInstance]requestHomeWithParameters:YWDDic withUrl:USER_URL withTokenStr:nil usingBlock:^(NSDictionary *result, NSError *error) {
        if ([[result objectForKey:@"statusCode"]integerValue] == 201) {
            NSDictionary *dic = [result objectForKey:@"data"];
            NSuserSave([dic objectForKey:@"accessToken"], @"Authorization");
            NSuserSave([dic objectForKey:@"userId"], @"userId");
            [self.navigationController popToRootViewControllerAnimated:NO ];
        }else{
            NSString *message = [result objectForKey:@"message"];
            normal_alert(@"提示",message, @"确定");
        }
        
        
        
    }];
    
}
- (void)showAlert{
    alphaBagView.hidden = NO;
    fadeSort = [[popupFade alloc]init];
    [fadeSort showView:alertView];
}
#pragma mark 获取验证码
- (void)senderInputSecurityCodeBtnClicked

{
  
    NSString *phoneRegex = @"^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    BOOL isMatch  = [phoneTest evaluateWithObject:UsertPhoneView.NameTextField.text];
    if (!isMatch) {
        normal_alert(@"提示", @"请输入正确的手机号", @"确定");
        
    }else{
        _second = 90;
        _securityCodeTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timing) userInfo:nil repeats:YES];
        NSMutableDictionary * YWDDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:UsertPhoneView.NameTextField.text ,@"phoneNumber",@"1",@"type",nil];
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
//#pragma mark -UITextFieldDelegate -
//- (void)textFieldDidBeginEditing:(UITextField *)textField{
//    textField.placeholder = @"";
//    textField.textAlignment = NSTextAlignmentLeft;
//}
- (void)ReginAndLoginBackClick{
 
//    for (UIViewController *controller in self.navigationController.viewControllers) {
//        if ([controller isKindOfClass:[FirstViewController  class]]) {
//            [self.navigationController popToViewController:controller animated:YES];
//        }
//    }
    [self.navigationController   popToRootViewControllerAnimated:NO];
    
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

@end
