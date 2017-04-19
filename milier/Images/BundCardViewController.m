//
//  BundCardViewController.m
//  milier
//
//  Created by amin on 17/4/19.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "BundCardViewController.h"
#import "SaleViewController.h"
#import "CustomView.h"

@interface BundCardViewController (){
    UIView *BackView;
    CustomView *CardNameView;
    
    CustomView *CardNumberView;

    CustomView *CardIphoneView;

    CustomView *CardBankView;

    CustomView *CardWhichBankView;

    CustomView *CardBankCodeView;

    
}

@end

@implementation BundCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"绑定银行卡";
    self.view.backgroundColor = [UIColor grayColor];
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(0, 7, 18, 18);
    [leftBtn setImage:[UIImage imageNamed:@"backarrow@2x.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(BundBackClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    [self ConfigUI];
    
    
}
- (void)ConfigUI{
    BackView = [[UIView alloc]init];
    BackView.backgroundColor = [UIColor grayColor];
    BackView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.view addSubview:BackView];
    
    CardNameView = [[CustomView alloc]init];
    CardNameView.NameLabel.text = @"手机号码:";
    CardNameView.NameTextField.placeholder = @"请输入手机号";
    CardNameView.NameTextField.delegate = self;
    CardNameView.NameTextField.keyboardType = UIKeyboardTypeNumberPad;
    [BackView addSubview:CardNameView];
    [CardNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.top.mas_equalTo(self.view.mas_top).offset(30);
        make.width.mas_equalTo(SCREEN_WIDTH - 40);
        make.height.mas_equalTo(40);
    }];
    
    CardNumberView = [[CustomView alloc]init];
    CardNumberView.NameLabel.text = @"手机号码:";
    CardNumberView.NameTextField.placeholder = @"请输入手机号";
    CardNumberView.NameTextField.delegate = self;
    CardNumberView.NameTextField.keyboardType = UIKeyboardTypeNumberPad;
    [BackView addSubview:CardNumberView];
    [CardNumberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.top.mas_equalTo(CardNameView.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH - 40);
        make.height.mas_equalTo(40);
    }];
    
    CardIphoneView = [[CustomView alloc]init];
    CardIphoneView.NameLabel.text = @"手机号码:";
    CardIphoneView.NameTextField.placeholder = @"请输入手机号";
    CardIphoneView.NameTextField.delegate = self;
    CardIphoneView.NameTextField.keyboardType = UIKeyboardTypeNumberPad;
    [BackView addSubview:CardIphoneView];
    [CardIphoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.top.mas_equalTo(CardNumberView.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH - 40);
        make.height.mas_equalTo(40);
    }];
    
    CardBankView = [[CustomView alloc]init];
    CardBankView.NameLabel.text = @"手机号码:";
    CardBankView.NameTextField.placeholder = @"请输入手机号";
    CardBankView.NameTextField.delegate = self;
    CardBankView.NameTextField.keyboardType = UIKeyboardTypeNumberPad;
    [BackView addSubview:CardBankView];
    [CardBankView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.top.mas_equalTo(CardIphoneView.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH - 40);
        make.height.mas_equalTo(40);
    }];
    
    
    CardWhichBankView = [[CustomView alloc]init];
    CardWhichBankView.NameLabel.text = @"手机号码:";
    CardWhichBankView.NameTextField.placeholder = @"请输入手机号";
    CardWhichBankView.NameTextField.delegate = self;
    CardWhichBankView.NameTextField.keyboardType = UIKeyboardTypeNumberPad;
    [BackView addSubview:CardWhichBankView];
    [CardWhichBankView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.top.mas_equalTo(CardBankView.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH - 40);
        make.height.mas_equalTo(40);
    }];
    CardBankCodeView = [[CustomView alloc]init];
    CardBankCodeView.NameLabel.text = @"手机号码:";
    CardBankCodeView.NameTextField.placeholder = @"请输入手机号";
    CardBankCodeView.NameTextField.delegate = self;
    CardBankCodeView.NameTextField.keyboardType = UIKeyboardTypeNumberPad;
    [BackView addSubview:CardBankCodeView];
    [CardBankCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.top.mas_equalTo(CardWhichBankView.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH - 40);
        make.height.mas_equalTo(40);
    }];
    
    
}
- (void)BundBackClick{
    //  返回指定页面
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[SaleViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
