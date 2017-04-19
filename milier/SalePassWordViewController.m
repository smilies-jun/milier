//
//  SalePassWordViewController.m
//  milier
//
//  Created by amin on 17/4/19.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "SalePassWordViewController.h"
#import "customWithStatic.h"
#import "SaleViewController.h"
#import "BundCardViewController.h"

@interface SalePassWordViewController (){
    customWithStatic *SaleNewPassWordView;
    customWithStatic *SaleSurePassWordView;

}

@end

@implementation SalePassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.TopView.hidden = NO;
//    self.view.backgroundColor = colorWithRGB(0.94, 0.94, 0.94);
//    self.TopTitleLabel.text = @"找回登录密码";
//    [self.BackButton addTarget:self action:@selector(SaleBackClick) forControlEvents:UIControlEventTouchUpInside];
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SalePassClickBack)];
//    [self.view addGestureRecognizer:tap]
    self.navigationItem.title = @"找回登录密码";
    self.view.backgroundColor = [UIColor grayColor];
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(0, 7, 18, 18);
    [leftBtn setImage:[UIImage imageNamed:@"backarrow@2x.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(SaleBackClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;

    [self ConFigUI];
}
- (void)ConFigUI{
    SaleNewPassWordView = [[customWithStatic alloc]init];
    SaleNewPassWordView.NameLabel.text = @"交易密码:";
    SaleNewPassWordView.NameTextField.keyboardType = UIKeyboardTypeNumberPad;
    SaleNewPassWordView.NameTextField.delegate = self;
    [self.view addSubview:SaleNewPassWordView];
    [SaleNewPassWordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.top.mas_equalTo(self.view.mas_top).offset(20);
        make.width.mas_offset(SCREEN_WIDTH - 40);
        make.height.mas_equalTo(40);
    }];
    
    SaleSurePassWordView = [[customWithStatic alloc]init];
    SaleSurePassWordView.NameLabel.text = @"确认交易密码:";
    SaleSurePassWordView.NameTextField.keyboardType = UIKeyboardTypeNumberPad;
    SaleSurePassWordView.NameTextField.delegate = self;
    [self.view addSubview:SaleSurePassWordView];
    [SaleSurePassWordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.top.mas_equalTo(SaleNewPassWordView.mas_bottom).offset(20);
        make.width.mas_offset(SCREEN_WIDTH - 40);
        make.height.mas_equalTo(40);
    }];
    UILabel *SaleLbel =  [[UILabel alloc]init];
    SaleLbel.text = @"购买";
    SaleLbel.userInteractionEnabled = YES;
    SaleLbel.backgroundColor = [UIColor greenColor];
    SaleLbel.textAlignment = NSTextAlignmentCenter;
    SaleLbel.textColor = [UIColor whiteColor];
    SaleLbel.layer.cornerRadius = 10;
    SaleLbel.layer.masksToBounds = YES;
    [self.view addSubview:SaleLbel];
    [SaleLbel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(40);
        make.top.mas_equalTo(SaleSurePassWordView.mas_bottom).offset(20);
        make.width.mas_equalTo(SCREEN_WIDTH - 80);
        make.height.mas_equalTo(30);
    }];
    
    UITapGestureRecognizer *SaleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SaleSureBtnClick
                                                                                                          )];
    [SaleLbel addGestureRecognizer:SaleTap];

}
- (void)SaleSureBtnClick{
    //  已经绑卡返回指定页面
//    for (UIViewController *controller in self.navigationController.viewControllers) {
//        if ([controller isKindOfClass:[SaleViewController class]]) {
//            [self.navigationController popToViewController:controller animated:YES];
//        }
//    }
    
    //未绑卡
    BundCardViewController *bundVC = [[BundCardViewController alloc]init];
    [self.navigationController pushViewController:bundVC    animated:NO];
}
- (void)SaleBackClick{
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
