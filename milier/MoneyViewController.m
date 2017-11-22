//
//  MoneyViewController.m
//  milier
//
//  Created by amin on 2017/5/24.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "MoneyViewController.h"
#import "MyLeftViewController.h"
#import "CustomView.h"
#import "BundCardViewController.h"
#import "YJForgetDealPassWordViewController.h"

@interface MoneyViewController ()<UITextFieldDelegate>{
    CustomView *payView;
    CustomView *passWordView;
    NSString *BankStatus;
    MBProgressHUD *hud;

}

@end

@implementation MoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"提现";
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
    
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(0, 7, 18, 18);
    [leftBtn setImage:[UIImage imageNamed:@"backarrow@2x.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(TouUpTap) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    [self reloadMyMoney];
    [self configUI];
    self.view.backgroundColor = colorWithRGB(0.94, 0.94, 0.94);
}
- (void)TouUpTap{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[MyLeftViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
}


- (void)configUI{
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"预计3个工作日内到账";
    titleLabel.font = [UIFont systemFontOfSize:10];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = colorWithRGB(0.95, 0.6, 0.11);
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view.mas_top).offset(5);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(15);
    }];
    payView = [[CustomView alloc]init];
    payView.NameLabel.text = @"输入金额:";
    payView.NameTextField.delegate = self;
    payView.NameTextField.placeholder = [NSString stringWithFormat:@"最多可提现%@元",_moneyStr];
    [self.view addSubview:payView];
    [payView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.top.mas_equalTo(self.view.mas_top).offset(30);
        make.width.mas_equalTo(SCREEN_WIDTH - 40);
        make.height.mas_equalTo(44);
    }];
    
    passWordView = [[CustomView alloc]init];
    passWordView.NameLabel.text = @"交易密码:";
    passWordView.NameTextField.secureTextEntry = YES;
    passWordView.NameTextField.placeholder = @"请输入交易密码";
    [self.view addSubview:passWordView];
    [passWordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.top.mas_equalTo(payView.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH - 40);
        make.height.mas_equalTo(44);
    }];
    
   UILabel *  ForgetPayLabel = [[UILabel alloc]init];
    ForgetPayLabel.text = @"忘记交易密码？";
    ForgetPayLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *forgetSaleWordTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ForgetClick)];
    [ForgetPayLabel addGestureRecognizer:forgetSaleWordTap];
    
    ForgetPayLabel.textColor = [UIColor orangeColor];
    ForgetPayLabel.textAlignment = NSTextAlignmentLeft;
    ForgetPayLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:ForgetPayLabel];
    [ForgetPayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.top.mas_equalTo(passWordView.mas_bottom).offset(5);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    }];
    
    UILabel *TestLabel =  [[UILabel alloc]init];
    TestLabel.text = @"提现";
    TestLabel.userInteractionEnabled = YES;
    TestLabel.backgroundColor = colorWithRGB(0.95, 0.6, 0.11);
    TestLabel.textAlignment = NSTextAlignmentCenter;
    TestLabel.textColor = [UIColor whiteColor];
    TestLabel.layer.cornerRadius = 20;
    TestLabel.layer.masksToBounds = YES;
    [self.view addSubview:TestLabel];
    [TestLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(40);
        make.top.mas_equalTo(passWordView.mas_bottom).offset(30);
        make.width.mas_equalTo(SCREEN_WIDTH - 80);
        make.height.mas_equalTo(40);
    }];
    
    UITapGestureRecognizer *SaleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(PayMoneyClick
                                                                                                          )];
    [TestLabel addGestureRecognizer:SaleTap];
    
}
- (void)ForgetClick{
    YJForgetDealPassWordViewController  *vc = [[YJForgetDealPassWordViewController alloc]init];
    vc.TypeStr = @"1";
    [self.navigationController pushViewController:vc animated:NO];
}
- (void)reloadMyMoney{
    NSString *Statisurl;
    NSString *userID = NSuserUse(@"userId");
    NSString *tokenID = NSuserUse(@"Authorization");
    Statisurl = [NSString stringWithFormat:@"%@/%@",USER_URL,userID];
    [[DateSource sharedInstance]requestHtml5WithParameters:nil  withUrl:Statisurl withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
        NSString *statusStr = [result objectForKey:@"statusCode"];
        if ([statusStr integerValue] == 200) {
            BankStatus = [NSString stringWithFormat:@"%@",[[result objectForKey:@"data"]objectForKey:@"bankCardExist"]];
            
        }
        
    }];
    
}

- (void)HideProgress{
    [hud hideAnimated:YES];
}
- (void)showProgress{
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
    
    // Set the label text.
    
    hud.label.text = NSLocalizedString(@"正在请求中", @"HUD loading title");
}
- (void)PayMoneyClick{
    [self showProgress];
    if ([BankStatus integerValue] ==1) {
        if (payView.NameTextField.text.length) {
            if (passWordView.NameTextField.text.length) {
                NSString *Statisurl;
                NSString *tokenID = NSuserUse(@"Authorization");
                NSString *userID = NSuserUse(@"userId");
                
                Statisurl = [NSString stringWithFormat:@"%@/users/%@/withdraw",HOST_URL,userID];
                NSMutableDictionary  *Dic =[[NSMutableDictionary alloc]initWithObjectsAndKeys:payView.NameTextField.text,@"amount",passWordView.NameTextField.text,@"dealPassword", nil];
                [[DateSource sharedInstance]requestHomeWithParameters:Dic withUrl:Statisurl withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
                    if ([[result objectForKey:@"statusCode"]integerValue] == 201) {
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [self HideProgress];
                            
                        });
                        NSString *message = [NSString stringWithFormat:@"%@",[result objectForKey:@"message"]];
                        normal_alert(@"提示", message, @"确定");
                        
                        for (UIViewController *controller in self.navigationController.viewControllers) {
                            if ([controller isKindOfClass:[MyLeftViewController class]]) {
                                [self.navigationController popToViewController:controller animated:YES];
                            }
                        }
                    }else{
                            [self HideProgress];
                            
        
                        NSString *message = [NSString stringWithFormat:@"%@",[result objectForKey:@"message"]];
                        normal_alert(@"提示", message, @"确定");
                        
                    }
                }];
            }else{
                  [self HideProgress];
                normal_alert(@"提示", @"交易密码不能为空", @"确定");
                
            }
            
            
        }else{
              [self HideProgress];
            normal_alert(@"提示", @"提现金额不能为0", @"确定");
            
        }

    }else{
        BundCardViewController *LoginVC = [[BundCardViewController alloc]init];
        [self.navigationController pushViewController:LoginVC animated:NO];
    }
    
    




}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    //    限制只能输入数字
    BOOL isHaveDian = YES;
    if ([string isEqualToString:@" "]) {
        return NO;
    }
    
    if ([textField.text rangeOfString:@"."].location == NSNotFound) {
        isHaveDian = NO;
    }
    if ([string length] > 0) {
        
        unichar single = [string characterAtIndex:0];//当前输入的字符
        if ((single >= '0' && single <= '9') || single == '.') {//数据格式正确
            
            if([textField.text length] == 0){
                if(single == '.') {
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }
            
            //输入的字符是否是小数点
            if (single == '.') {
                if(!isHaveDian)//text中还没有小数点
                {
                    isHaveDian = YES;
                    return YES;
                    
                }else{
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }else{
                if (isHaveDian) {//存在小数点
                    
                    //判断小数点的位数
                    NSRange ran = [textField.text rangeOfString:@"."];
                    if (range.location - ran.location <= 2) {
                        return YES;
                    }else{
                        return NO;
                    }
                }else{
                    return YES;
                }
            }
        }else{//输入的数据格式不正确
            [textField.text stringByReplacingCharactersInRange:range withString:@""];
            return NO;
        }
    }
    else
    {
        return YES;
    }
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
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
    [super viewWillDisappear:animated];
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
