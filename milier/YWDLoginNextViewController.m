//
//  YWDLoginNextViewController.m
//  YWD
//
//  Created by 007 on 15/10/30.
//  Copyright © 2015年 star. All rights reserved.
//

#import "YWDLoginNextViewController.h"
#import "CustomView.h"
#import "YWDLoginViewController.h"


@interface YWDLoginNextViewController (){
    CustomView  *PassView;
}

@end

@implementation YWDLoginNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.TopView.hidden = NO;
    self.view.backgroundColor = colorWithRGB(0.94, 0.94, 0.94);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(nextHideKey)];
    [self.view addGestureRecognizer:tap];
    
    self.TopTitleLabel.text = @"登录";
    [self.BackButton addTarget:self action:@selector(LoginNextBackClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self initUI];
}
- (void)initUI{
    PassView = [[CustomView alloc]init];
    PassView.NameLabel.text = @"密码:";
    PassView.NameTextField.secureTextEntry = YES;
    PassView.NameTextField.placeholder = @"请输入登录密码";
    PassView.NameTextField.delegate = self;
    [self.view addSubview:PassView];
    [PassView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self.TopView.mas_bottom).offset(20);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(40);
    }];
    UIButton *reginBtn = [[UIButton alloc]init];
    reginBtn.layer.masksToBounds = YES;
    reginBtn.layer.cornerRadius = 5.0f;
    [reginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [reginBtn addTarget:self action:@selector(LoginClicked) forControlEvents:UIControlEventTouchUpInside];
    [reginBtn setBackgroundColor:colorWithRGB(0.96, 0.21, 0.29)];
    reginBtn.titleLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:reginBtn];
    [reginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.top.mas_equalTo(PassView.mas_bottom).offset(20);
        make.width.mas_equalTo(SCREEN_WIDTH - 40);
        make.height.mas_equalTo(40);
    }];
    UILabel * ForgetPasswordLabel  = [[UILabel alloc]init];
    ForgetPasswordLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *ForgetPassLabel = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ForgetLoginPassClick)];
    [ForgetPasswordLabel addGestureRecognizer:ForgetPassLabel];
    NSMutableAttributedString *ConnectStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"忘记登录密码?"]];
    NSRange conectRange = {0,[ConnectStr length]};
    [ConnectStr addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:conectRange];
    ForgetPasswordLabel.attributedText = ConnectStr;
    ForgetPasswordLabel.textColor= [UIColor redColor];
    ForgetPasswordLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:ForgetPasswordLabel];
    [ForgetPasswordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.top.mas_equalTo(reginBtn.mas_bottom).offset(20);
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.height.mas_equalTo(20);
    }];

}
- (void)ForgetLoginPassClick{
    YWDForgetPassWordViewController *ForgetVC = [[YWDForgetPassWordViewController alloc]init];
    [self.navigationController pushViewController:ForgetVC animated:NO];
}
- (void)LoginClicked{
    if (PassView.NameTextField.text.length) {
//        NSMutableDictionary * YWDDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@",PassView.NameTextField.text] ,@"userPwd", [NSString stringWithFormat:@"%@",_phoneStr],@"phone",@"2",@"userFlag",nil];
//        [[DateSource sharedInstance]requestHtml5WithParameters:nil withUrl:@"https://192.168.1.34:8443/products/1" usingBlock:^(NSDictionary *result, NSError *error) {
//            NSLog(@"result = %@",result);
//        }];
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"2323",@"user_id",@"2323",@"accessToken", nil];
        [[DateSource sharedInstance]requestHomeWithParameters:dic withUrl:@"https://192.168.1.34:8443/tokens" usingBlock:^(NSDictionary *result, NSError *error) {
            
        }];
        
//        [[DateSource sharedInstance]requestHomeWithParameters:YWDDic withUrl:[NSString stringWithFormat:@"%@/phone/login",TestSeverURL] usingBlock:^(NSDictionary *result, NSError *error) {
//            NSString *code = [result objectForKey:@"retcode"];
//            if ([code intValue] == 1000) {
//                NSuserSave([result objectForKey:@"token"], @"token");
//                NSuserSave(_phoneStr, @"phone");
//                NSuserSave(PassView.NameTextField.text, @"password");
//                NSuserSave(@"1", @"state");
//                [[NSUserDefaults standardUserDefaults]synchronize];
//                [self.navigationController dismissViewControllerAnimated:YES completion:^{
//                }];
//            }else{
//                NSString *AlertStr = [result objectForKey:@"retdesc"];
//                normal_alert(@"提示", AlertStr , @"确定");
//            }
//        }];
//    }else{
//        normal_alert(@"提示", @"密码不可为空  ", @"确定");
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"密码不可为空" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        [alert show];
//    }
}
}
- (void)LoginNextBackClick{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[YWDLoginViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
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
- (void)nextHideKey{
    [self HideKeyBoardClick];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
    [super viewWillDisappear:animated];
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
