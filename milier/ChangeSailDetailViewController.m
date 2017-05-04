//
//  ChangeSailDetailViewController.m
//  milier
//
//  Created by amin on 17/4/25.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "ChangeSailDetailViewController.h"
#import "DinQiDeatilViewController.h"
#import "ProfilView.h"
#import "customWithStatic.h"

@interface ChangeSailDetailViewController (){
    UIView *TopView;
    ProfilView *ComeBackMoneyView;
    ProfilView *OneDayView;
    ProfilView *RateView;
    
    
    customWithStatic *ChangeView;
    customWithStatic *OutSailView;
    UILabel *SaleLabel;

}

@end

@implementation ChangeSailDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"债券转让";
    self.view.backgroundColor = [UIColor grayColor];
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(0, 7, 18, 18);
    [leftBtn setImage:[UIImage imageNamed:@"backarrow@2x.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(DetailChangeClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    [self ConfigUI];

}
- (void)ConfigUI{
    TopView = [[UIView alloc]init];
    TopView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:TopView];
    [TopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self.view.mas_top);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(100);
    }];
    
    UILabel *TitltLabel = [[UILabel alloc]init];
    TitltLabel.text = @"米3-新密计划第一期";
    TitltLabel.font = [UIFont systemFontOfSize:12];
    TitltLabel.textColor = [UIColor blackColor];
    [TopView addSubview:TitltLabel];
    [TitltLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(TopView.mas_centerX);
        make.top.mas_equalTo(TopView.mas_top).offset(20);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(10);
    }];
    
    UILabel *NumberLabel = [[UILabel alloc]init];
    NumberLabel.text = @"$777777元";
    NumberLabel.font = [UIFont systemFontOfSize:40];
    NumberLabel.textColor = [UIColor blackColor];
    [TopView addSubview:NumberLabel];
    [NumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(TopView.mas_centerX);
        make.top.mas_equalTo(TitltLabel.mas_bottom).offset(5);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(40);
    }];
    
    UILabel *DetailLabel = [[UILabel alloc]init];
    DetailLabel.text = @"（债券宝价值）";
    DetailLabel.font = [UIFont systemFontOfSize:9];
    DetailLabel.textColor = [UIColor blackColor];
    [TopView addSubview:DetailLabel];
    [DetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(TopView.mas_centerX);
        make.top.mas_equalTo(NumberLabel.mas_bottom).offset(5);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(10);
    }];
    
    
    
    ComeBackMoneyView = [[ProfilView alloc]init];
    [self.view addSubview:ComeBackMoneyView];
    [ComeBackMoneyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(TopView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(40);
    }];
    OneDayView = [[ProfilView alloc]init];
    OneDayView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:OneDayView];
    [OneDayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(ComeBackMoneyView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(40);
    }];
    
    RateView = [[ProfilView alloc]init];
    RateView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:RateView];
    [RateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(OneDayView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(40);
    }];
    
    ChangeView = [[customWithStatic alloc]init];
    [self.view addSubview:ChangeView];
    [ChangeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(10);
        make.top.mas_equalTo(RateView.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH -20);
        make.height.mas_equalTo(40);
    }];
    
    OutSailView = [[customWithStatic alloc]init];
    [self.view addSubview:OutSailView];
    [OutSailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(10);
        make.top.mas_equalTo(ChangeView.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH -20);
        make.height.mas_equalTo(40);
    }];
    UILabel *MyLabel = [[UILabel alloc]init];
    MyLabel.text = @"改日期零点无人购买，自动取消转让";
    MyLabel.font = [UIFont systemFontOfSize:11];
    MyLabel.textAlignment = NSTextAlignmentCenter;
    MyLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:MyLabel];
    [MyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(OutSailView.mas_bottom).offset(10);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(20);
    }];
    
    SaleLabel = [[UILabel alloc]init];
    SaleLabel.text = @"提交";
    SaleLabel.userInteractionEnabled = YES;
    SaleLabel.backgroundColor = [UIColor orangeColor];
    SaleLabel.textAlignment = NSTextAlignmentCenter;
    SaleLabel.textColor = [UIColor whiteColor];
    SaleLabel.layer.cornerRadius = 10;
    SaleLabel.layer.masksToBounds = YES;
    [self.view addSubview:SaleLabel];
    [SaleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(40);
        make.top.mas_equalTo(MyLabel.mas_bottom).offset(20);
        make.width.mas_equalTo(SCREEN_WIDTH - 80);
        make.height.mas_equalTo(30);
    }];
    
    UITapGestureRecognizer *SaleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TiJiaoBtn
                                                                                                          )];
    [SaleLabel addGestureRecognizer:SaleTap];
}
//提交
- (void)TiJiaoBtn{
    
}
- (void)DetailChangeClick{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[DinQiDeatilViewController class]]) {
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
