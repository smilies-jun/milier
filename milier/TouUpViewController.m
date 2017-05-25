//
//  TouUpViewController.m
//  milier
//
//  Created by amin on 17/4/19.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "TouUpViewController.h"
#import "SaleViewController.h"
#import "MyLeftViewController.h"
#import "CustomView.h"


@interface TouUpViewController (){
    CustomView *payView;
}

@end

@implementation TouUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"充值";
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
    
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(0, 7, 18, 18);
    [leftBtn setImage:[UIImage imageNamed:@"backarrow@2x.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(TouUpTap) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    [self reloadData];
    [self configUI];
    self.view.backgroundColor = colorWithRGB(0.94, 0.94, 0.94);
}
- (void)reloadData{
    
}
- (void)configUI{
    payView = [[CustomView alloc]init];
    payView.NameLabel.text = @"充值金额";
    payView.NameTextField.placeholder = @"请输入充值金额";
    [self.view addSubview:payView];
    [payView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.top.mas_equalTo(self.view.mas_top).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH - 40);
        make.height.mas_equalTo(44);
    }];
    
    UIImageView *bankImageView = [[UIImageView alloc]init];
    bankImageView.backgroundColor = [UIColor redColor];
    [self.view addSubview:bankImageView];
    [bankImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.top.mas_equalTo(payView.mas_bottom).offset(10);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
    }];
    
    UILabel *bankLabel = [[UILabel alloc]init];
    bankLabel.text = @"工商银行（7686)";
    bankLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:bankLabel];
    [bankLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bankImageView.mas_right).offset(5);
        make.top.mas_equalTo(payView.mas_bottom).offset(10);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(15);
    }];
    
    UILabel *bankDetailLabel = [[UILabel alloc]init];
    bankDetailLabel.text = @"工商银行（7686)123213213213";
    bankDetailLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:bankDetailLabel];
    [bankDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bankImageView.mas_right).offset(5);
        make.top.mas_equalTo(bankLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(15);
    }];
    
    UILabel *TestLabel =  [[UILabel alloc]init];
    TestLabel.text = @"充值";
    TestLabel.userInteractionEnabled = YES;
    TestLabel.backgroundColor = colorWithRGB(0.95, 0.6, 0.11);
    TestLabel.textAlignment = NSTextAlignmentCenter;
    TestLabel.textColor = [UIColor whiteColor];
    TestLabel.layer.cornerRadius = 10;
    TestLabel.layer.masksToBounds = YES;
    [self.view addSubview:TestLabel];
    [TestLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(40);
        make.top.mas_equalTo(bankImageView.mas_bottom).offset(20);
        make.width.mas_equalTo(SCREEN_WIDTH - 80);
        make.height.mas_equalTo(40);
    }];
    
    UITapGestureRecognizer *SaleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(PaySureBtnClick
                                                                                                          )];
    [TestLabel addGestureRecognizer:SaleTap];
    
}
- (void)PaySureBtnClick{
    
}
- (void)TouUpTap{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[MyLeftViewController class]]) {
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
