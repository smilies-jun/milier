//
//  SaleViewController.m
//  milier
//
//  Created by amin on 17/4/19.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "SaleViewController.h"
#import "ProuctDetailViewController.h"
#import "YWDLoginViewController.h"
#import "SalePassWordViewController.h"
#import "PayViewController.h"
#import "TouUpViewController.h"


@interface SaleViewController (){
    
    UIView *TopView;
    UIView *BootmView;
    
    UILabel *TitleLabel;
    UILabel *MoneyPercentLabel;
    UILabel *AddMoneyLabel;
    
    UILabel *LeftLabel;
    UILabel *MoneyLeftLbel;
    
    UILabel *ExplainLabel;
    UIView *ChoceStageView;
    UIView *SaleView;
    
    UILabel *TotalMoneyLabel;
    UILabel *AgreementLabel;
    
    UILabel *SaleLabel;
    
    
}

@end

@implementation SaleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"购买";
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
    
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(0, 7, 18, 18);
    [leftBtn setImage:[UIImage imageNamed:@"backarrow@2x.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(SaleOnTap) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    [self ConfigUI];
    
}

- (void)ConfigUI{
    TopView = [[UIView alloc]init];
    TopView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:TopView];
    [TopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top);
        make.left.mas_equalTo(self.view.mas_left);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(200);
    }];
    TitleLabel = [[UILabel alloc]init];
    TitleLabel.text = @"米3－新密计划第一期";
    TitleLabel.font = [UIFont systemFontOfSize:12];
    TitleLabel.textColor = [UIColor whiteColor];
    TitleLabel.textAlignment = NSTextAlignmentCenter;
    [TopView addSubview:TitleLabel];
    [TitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(TopView.mas_centerX);
        make.top.mas_equalTo(TopView.mas_top).offset(20);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(20);
    }];
    
    MoneyPercentLabel = [[UILabel alloc]init];
    MoneyPercentLabel.text = @"23.34%";
    MoneyPercentLabel.textColor = [UIColor whiteColor];

    NSMutableAttributedString *newAttrStr = [[NSMutableAttributedString alloc] initWithString:@"12.34%"];
    [newAttrStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:50] range:NSMakeRange(0,MoneyPercentLabel.text.length
                                                                                                          )];
    [newAttrStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:20] range:NSMakeRange(MoneyPercentLabel.text.length - 1
                                                                                                          ,1)];
    MoneyPercentLabel.attributedText = newAttrStr;
    MoneyPercentLabel.textAlignment = NSTextAlignmentCenter;
    [TopView addSubview:MoneyPercentLabel];
    [MoneyPercentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(TopView.mas_centerX);
        make.top.mas_equalTo(TitleLabel.mas_bottom).offset(20);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(40);
    }];
    
    AddMoneyLabel = [[UILabel alloc]init];
    AddMoneyLabel.backgroundColor = [UIColor orangeColor];
    AddMoneyLabel.textColor = [UIColor whiteColor];
    AddMoneyLabel.font = [UIFont systemFontOfSize:12];
    AddMoneyLabel.text = @"+1000000元";
    AddMoneyLabel.textAlignment = NSTextAlignmentLeft;
    [TopView addSubview:AddMoneyLabel];
    [AddMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MoneyPercentLabel.mas_right);
        make.top.mas_equalTo(TitleLabel.mas_bottom);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(20);
    }];
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor whiteColor];
    [TopView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(TopView.mas_left).offset(10);
        make.top.mas_equalTo(MoneyPercentLabel.mas_bottom).offset(40);
        make.width.mas_equalTo(SCREEN_WIDTH - 20);
        make.height.mas_equalTo(1);
    }];
    
    LeftLabel = [[UILabel alloc]init];
    LeftLabel.text = @"剩余额度";
    LeftLabel.textColor = [UIColor whiteColor];
    LeftLabel.font = [UIFont systemFontOfSize:12];
    [TopView addSubview:LeftLabel];
    [LeftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(TopView.mas_left).offset(20);
        make.top.mas_equalTo(lineView.mas_bottom).offset(20);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(20);
    }];
    
    MoneyLeftLbel = [[UILabel alloc]init];
    MoneyLeftLbel.text = @"23123213元";
    MoneyLeftLbel.textColor = [UIColor whiteColor];
    MoneyLeftLbel.textAlignment = NSTextAlignmentRight;
    MoneyLeftLbel.font = [UIFont systemFontOfSize:12];
    [TopView addSubview:MoneyLeftLbel];
    [MoneyLeftLbel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(TopView.mas_right).offset(-20);
        make.top.mas_equalTo(lineView.mas_bottom).offset(20);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(20);
    }];
    
    BootmView = [[UIView alloc]init];
    BootmView.backgroundColor = colorWithRGB(0.92, 0.92, 0.92);
    [self.view addSubview:BootmView];
    [BootmView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(TopView.mas_bottom);
        make.left.mas_equalTo(self.view.mas_left);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(SCREEN_HEIGHT-240);
    }];
    
    ExplainLabel = [[UILabel alloc]init];
    ExplainLabel.text = @"注：若支付失败道具将在15分钟内返还";
    ExplainLabel.textColor = [UIColor blueColor];
    ExplainLabel.textAlignment = NSTextAlignmentCenter;
    ExplainLabel.font = [UIFont systemFontOfSize:11];
    [BootmView addSubview:ExplainLabel];
    [ExplainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(BootmView.mas_centerX);
        make.top.mas_equalTo(BootmView.mas_top).offset(10);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(20);
    }];
    
    ChoceStageView = [[UIView alloc]init];
    ChoceStageView.backgroundColor = [UIColor grayColor];
    [BootmView addSubview:ChoceStageView];
    [ChoceStageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(BootmView.mas_left).offset(20);
        make.top.mas_equalTo(ExplainLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH - 40);
        make.height.mas_equalTo(40);
    }];
    
    SaleView = [[UIView alloc]init];
    SaleView.backgroundColor = [UIColor grayColor];
    [BootmView addSubview:SaleView];
    [SaleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(BootmView.mas_left).offset(20);
        make.top.mas_equalTo(ChoceStageView.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH - 40);
        make.height.mas_equalTo(40);
    }];
    
    TotalMoneyLabel = [[UILabel alloc]init];
    TotalMoneyLabel.textColor = [UIColor whiteColor];
    TotalMoneyLabel.text= @"预计本息：9999999999999";
    TotalMoneyLabel.textAlignment = NSTextAlignmentCenter;
    TotalMoneyLabel.backgroundColor = [UIColor yellowColor];
    [BootmView addSubview:TotalMoneyLabel];
    [TotalMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(BootmView.mas_left).offset(20);
        make.top.mas_equalTo(SaleView.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH - 40);
        make.height.mas_equalTo(40);
    }];
    
    AgreementLabel = [[UILabel alloc]init];
    AgreementLabel.text = @"我同意《服务协议》";
    AgreementLabel.textColor = [UIColor blackColor];
    AgreementLabel.font = [UIFont systemFontOfSize:12];
    AgreementLabel.textAlignment = NSTextAlignmentLeft;
    [BootmView addSubview:AgreementLabel];
    [AgreementLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(BootmView.mas_left).offset(40);
        make.top.mas_equalTo(TotalMoneyLabel.mas_bottom).offset(20);
        make.width.mas_equalTo(140);
        make.height.mas_equalTo(20);
    }];
    
    SaleLabel = [[UILabel alloc]init];
    SaleLabel.text = @"购买";
    SaleLabel.userInteractionEnabled = YES;
    SaleLabel.backgroundColor = [UIColor greenColor];
    SaleLabel.textAlignment = NSTextAlignmentCenter;
    SaleLabel.textColor = [UIColor whiteColor];
    SaleLabel.layer.cornerRadius = 10;
    SaleLabel.layer.masksToBounds = YES;
    [BootmView addSubview:SaleLabel];
    [SaleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(BootmView.mas_left).offset(40);
        make.top.mas_equalTo(AgreementLabel.mas_bottom).offset(20);
        make.width.mas_equalTo(SCREEN_WIDTH - 80);
        make.height.mas_equalTo(30);
    }];
    
    UITapGestureRecognizer *SaleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SaleBtn
                                                                                                          )];
    [SaleLabel addGestureRecognizer:SaleTap];
}

- (void)SaleBtn{
    
//未登录
    //YWDLoginViewController *LoginVC = [[YWDLoginViewController alloc]init];
    //[self.navigationController pushViewController:LoginVC animated:NO];
    //未设置交易密码
    SalePassWordViewController *SaleVC = [[SalePassWordViewController alloc]init];
    [self.navigationController   pushViewController:SaleVC animated:NO];
//余额充足
//    PayViewController *PayVC = [[PayViewController alloc]init];
//    [self.navigationController   pushViewController:PayVC animated:NO];

    //余额不足
    
}
- (void)SaleOnTap{
    //  返回指定页面
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[ProuctDetailViewController class]]) {
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
