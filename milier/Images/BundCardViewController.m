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
#import "CustomChooseView.h"
#import "ZHPickView.h"

@interface BundCardViewController (){
    UIView *BackView;
    
    UILabel *MoneyLabel;
    
    CustomView *CardNameView;
    
    CustomView *CardNumberView;

    CustomView *CardIphoneView;

    CustomChooseView *CardBankView;

    CustomView *CardWhichBankView;

    CustomView *CardBankCodeView;

    UILabel *ExlainLabel;
    NSArray *proTimeList;
}

@end

@implementation BundCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"绑定银行卡";
    self.view.backgroundColor = colorWithRGB(0.97, 0.97, 0.97);
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(0, 7, 18, 18);
    [leftBtn setImage:[UIImage imageNamed:@"backarrow@2x.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(BundBackClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *BagTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(BagClcik)];
    [self.view addGestureRecognizer:BagTap];
    [self ConfigUI];
    
   
}
- (void)BagClcik{
    [self HideKeyBoardClick];
}
- (void)ConfigUI{
    BackView = [[UIView alloc]init];
    BackView.backgroundColor = colorWithRGB(0.97, 0.97, 0.97);
    BackView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.view addSubview:BackView];
    
    MoneyLabel = [[UILabel alloc]init];
    MoneyLabel.text = @"持卡金额：0.02元（绑卡后自动进入余额）";
    MoneyLabel.textColor = [UIColor blackColor];
    MoneyLabel.font = [UIFont systemFontOfSize:12];
    [BackView addSubview:MoneyLabel];
    [MoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(BackView.mas_left).offset(20);
        make.top.mas_equalTo(BackView.mas_top).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH - 40);
        make.height.mas_equalTo(15);
    }];
    
    
    CardNameView = [[CustomView alloc]init];
    CardNameView.NameLabel.text = @"持卡人姓名:";
    CardNameView.NameTextField.placeholder = @"请输入持卡人姓名";
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
    CardNumberView.NameLabel.text = @"身份证号:";
    CardNumberView.NameTextField.placeholder = @"身份证号";
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
    
    CardBankView = [[CustomChooseView alloc]init];
    CardBankView.NameLabel.text = @"选择银行:";
    CardBankView.ChooseLabel.text = @"中国银行";
    CardBankView.ChooseLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *ChooseTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseTapClick)];
    [CardBankView.ChooseLabel addGestureRecognizer:ChooseTap];
    
    
    [BackView addSubview:CardBankView];
    [CardBankView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.top.mas_equalTo(CardIphoneView.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH - 40);
        make.height.mas_equalTo(40);
    }];
    
    
    CardWhichBankView = [[CustomView alloc]init];
    CardWhichBankView.NameLabel.text = @"开户银行:";
    CardWhichBankView.NameTextField.placeholder = @"请输入银行支行名称";
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
    CardBankCodeView.NameLabel.text = @"银行卡号:";
    CardBankCodeView.NameTextField.placeholder = @"请输入银行卡号";
    CardBankCodeView.NameTextField.delegate = self;
    CardBankCodeView.NameTextField.keyboardType = UIKeyboardTypeNumberPad;
    [BackView addSubview:CardBankCodeView];
    [CardBankCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.top.mas_equalTo(CardWhichBankView.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH - 40);
        make.height.mas_equalTo(40);
    }];
    ExlainLabel = [[UILabel alloc]init];
    ExlainLabel.text = @"绑定银行卡用于体现以及。绑定后不可更改";
    ExlainLabel.textAlignment = NSTextAlignmentLeft;
    ExlainLabel.textColor = [UIColor orangeColor];
    ExlainLabel.font = [UIFont systemFontOfSize:12];
    [BackView addSubview:ExlainLabel];
    [ExlainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(BackView.mas_left).offset(30);
        make.top.mas_equalTo(CardBankCodeView.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH - 60);
        make.height.mas_equalTo(20);
    }];
    UILabel *nameLabel =[[UILabel alloc]init];
    nameLabel.font = [UIFont systemFontOfSize:14];
    NSMutableAttributedString *ConnectStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"我同意《服务协议》"]];
    NSRange conectRange = {4,4};
    [ConnectStr addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:conectRange];
    nameLabel.attributedText = ConnectStr;
    nameLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *gesTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(AgreeClick)];
    [nameLabel addGestureRecognizer:gesTap];
    [BackView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(BackView.mas_left).offset(20);
        make.top.mas_equalTo(ExlainLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(20);
    }];

    
    UILabel *SaleLbel =  [[UILabel alloc]init];
    SaleLbel.text = @"确定";
    SaleLbel.userInteractionEnabled = YES;
    SaleLbel.backgroundColor = colorWithRGB(0.95, 0.60, 0.11);
    SaleLbel.textAlignment = NSTextAlignmentCenter;
    SaleLbel.textColor = [UIColor whiteColor];
    SaleLbel.layer.cornerRadius = 10;
    SaleLbel.layer.masksToBounds = YES;
    [BackView addSubview:SaleLbel];
    [SaleLbel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(BackView.mas_left).offset(20);
        make.top.mas_equalTo(nameLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH - 40);
        make.height.mas_equalTo(30);
    }];
    
    UITapGestureRecognizer *SaleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(BundBtnClick
                                                                                                          )];
    [SaleLbel addGestureRecognizer:SaleTap];
    
}

- (void)chooseTapClick{
    ZHPickView *pickView = [[ZHPickView alloc] init];
    [pickView setDataViewWithItem:@[@"中国工商银行",@"中国银行",@"杭州银行"] title:@"选择银行"];
    [pickView showPickView:self];
    pickView.block = ^(NSString *selectedStr)
    {
        CardBankView.ChooseLabel.text = selectedStr;

    };
}
- (void)AgreeClick{
    
}
- (void)BundBtnClick{
    
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
