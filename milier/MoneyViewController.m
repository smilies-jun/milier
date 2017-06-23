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

@interface MoneyViewController (){
    CustomView *payView;
    CustomView *passWordView;

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
        make.top.mas_equalTo(passWordView.mas_bottom).offset(20);
        make.width.mas_equalTo(SCREEN_WIDTH - 80);
        make.height.mas_equalTo(40);
    }];
    
    UITapGestureRecognizer *SaleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(PayMoneyClick
                                                                                                          )];
    [TestLabel addGestureRecognizer:SaleTap];
    
}
- (void)PayMoneyClick{
    if (payView.NameTextField.text.length) {
        if (passWordView.NameTextField.text.length) {
            NSString *Statisurl;
            NSString *tokenID = NSuserUse(@"Authorization");
            NSString *userID = NSuserUse(@"userId");
            
            Statisurl = [NSString stringWithFormat:@"%@/users/%@/withdraw",HOST_URL,userID];
            NSMutableDictionary  *Dic =[[NSMutableDictionary alloc]initWithObjectsAndKeys:payView.NameTextField.text,@"amount",passWordView.NameTextField.text,@"dealPassword", nil];
            [[DateSource sharedInstance]requestHomeWithParameters:Dic withUrl:Statisurl withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
                if ([[result objectForKey:@"statusCode"]integerValue] == 201) {
                    NSString *message = [NSString stringWithFormat:@"%@",[result objectForKey:@"message"]];
                    normal_alert(@"提示", message, @"确定");
                    
                    for (UIViewController *controller in self.navigationController.viewControllers) {
                        if ([controller isKindOfClass:[MyLeftViewController class]]) {
                            [self.navigationController popToViewController:controller animated:YES];
                        }
                    }
                }else{
                    NSString *message = [NSString stringWithFormat:@"%@",[result objectForKey:@"message"]];
                    normal_alert(@"提示", message, @"确定");
                    
                }
            }];
        }else{
            normal_alert(@"提示", @"交易密码不能为空", @"确定");
 
        }
        
        
    }else{
        normal_alert(@"提示", @"提现金额不能为0", @"确定");
    
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
