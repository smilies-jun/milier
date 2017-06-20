//
//  PayViewController.m
//  milier
//
//  Created by amin on 17/4/19.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "PayViewController.h"
#import "SaleViewController.h"
#import "CustomView.h"

@interface PayViewController (){
    UIView *TopView;
    
    UILabel *TitleLabel;
    UILabel *MoneyLabel;
    UILabel *StageLabel;
    UILabel *MyLeftMoney;
    UILabel *MoneyNumber;
    UILabel *SaleLabel;
    UILabel *ForgetPayLabel;
    CustomView *PayMoneyView;
    
}

@end

@implementation PayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"支付";
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
    self.view.backgroundColor = [UIColor grayColor];
    
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(0, 7, 18, 18);
    [leftBtn setImage:[UIImage imageNamed:@"backarrow@2x.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(PayTap) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    [self ConfigUI];
}
- (void)ConfigUI{
    TopView  = [[UIView alloc]init];
    TopView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:TopView];
    [TopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self.view.mas_top);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(160);
    }];
    TitleLabel = [[UILabel alloc]init];
    TitleLabel.text = @"米粒儿活期投资第一期";
    TitleLabel.textColor = [UIColor blackColor];
    TitleLabel.font = [UIFont systemFontOfSize:13];
    TitleLabel.textAlignment = NSTextAlignmentCenter;
    [TopView addSubview:TitleLabel];
    [TitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(TopView.mas_centerX);
        make.top.mas_equalTo(TopView.mas_top).offset(10);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(20);
    }];
    
    MoneyLabel = [[UILabel alloc]init];
    MoneyLabel.text = @"6000元";
    MoneyLabel.textColor = [UIColor orangeColor];
    MoneyLabel.font = [UIFont systemFontOfSize:40];
    MoneyLabel.textAlignment = NSTextAlignmentCenter;
    [TopView addSubview:MoneyLabel];
    [MoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(TopView.mas_centerX);
        make.top.mas_equalTo(TitleLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(40);
    }];
    StageLabel = [[UILabel alloc]init];
    StageLabel.text = @"(包含128小米卷)";
    StageLabel.textAlignment = NSTextAlignmentCenter;
    StageLabel.font = [UIFont systemFontOfSize:12];
    StageLabel.textColor = [UIColor blackColor];
    [TopView addSubview:StageLabel];
    [StageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(TopView.mas_centerX);
        make.top.mas_equalTo(MoneyLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(20);

    }];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor blackColor];
    [TopView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(TopView.mas_left);
        make.top.mas_equalTo(StageLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(1);
    }];
    
    MyLeftMoney = [[UILabel alloc]init];
    MyLeftMoney.text = @"我的余额";
    MyLeftMoney.font = [UIFont systemFontOfSize:13];
    MyLeftMoney.textAlignment = NSTextAlignmentLeft;
    [TopView addSubview:MyLeftMoney];
    [MyLeftMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(TopView.mas_left).offset(20);
        make.top.mas_equalTo(lineView.mas_bottom).offset(10);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(20);
    }];
    
    MoneyNumber = [[UILabel alloc]init];
    MoneyNumber.text = @"50000元";
    MoneyNumber.textAlignment = NSTextAlignmentRight;
    MoneyNumber.textColor = [UIColor orangeColor];
    MoneyNumber.font = [UIFont systemFontOfSize:13];
    [TopView addSubview:MoneyNumber];
    [MoneyNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(TopView.mas_right).offset(-20);
        make.top.mas_equalTo(lineView.mas_bottom).offset(10);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(20);
    }];
    PayMoneyView = [[CustomView alloc]init];
    PayMoneyView.NameLabel.text = @"交易密码:";
    PayMoneyView.NameTextField.secureTextEntry = YES;
    PayMoneyView.NameTextField.keyboardType = UIKeyboardTypeNumberPad;
    PayMoneyView.NameTextField.delegate = self;
    [self.view addSubview:PayMoneyView];
    [PayMoneyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.top.mas_equalTo(TopView.mas_bottom).offset(20);
        make.height.mas_equalTo(40);
    }];
    
    SaleLabel = [[UILabel alloc]init];
    SaleLabel.text = @"购买";
    SaleLabel.userInteractionEnabled = YES;
    SaleLabel.backgroundColor = colorWithRGB(0.95, 0.6, 0.11);
    SaleLabel.textAlignment = NSTextAlignmentCenter;
    SaleLabel.textColor = [UIColor whiteColor];
    SaleLabel.layer.cornerRadius = 10;
    SaleLabel.layer.masksToBounds = YES;
    [self.view addSubview:SaleLabel];
    [SaleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(40);
        make.top.mas_equalTo(PayMoneyView.mas_bottom).offset(20);
        make.width.mas_equalTo(SCREEN_WIDTH - 80);
        make.height.mas_equalTo(30);
    }];
    
    UITapGestureRecognizer *SaleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(PayBtn
                                                                                                          )];
    [SaleLabel addGestureRecognizer:SaleTap];
    
    
    ForgetPayLabel = [[UILabel alloc]init];
    ForgetPayLabel.text = @"忘记交易密码？";
    ForgetPayLabel.textColor = [UIColor orangeColor];
    ForgetPayLabel.textAlignment = NSTextAlignmentLeft;
    ForgetPayLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:ForgetPayLabel];
    [ForgetPayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.top.mas_equalTo(SaleLabel.mas_bottom).offset(5);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    }];
}

- (void)PayBtn{
    
}
- (void)PayTap{
    //  返回指定页面
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[SaleViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
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
