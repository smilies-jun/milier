//
//  ModifyLoginViewController.m
//  milier
//
//  Created by amin on 17/4/21.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "ModifyLoginViewController.h"
#import "UserSetViewController.h"
#import "customWithStatic.h"

@interface ModifyLoginViewController (){
    customWithStatic *OldLoginView;
    customWithStatic *NewLoginView;
    customWithStatic *SureLoginView;
    UILabel *SaleLabel;

}

@end

@implementation ModifyLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];           // Do any additional setup after loading the view.
    self.navigationItem.title = @"修改登录密码";
    self.view.backgroundColor = [UIColor grayColor];
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(0, 7, 18, 18);
    [leftBtn setImage:[UIImage imageNamed:@"backarrow@2x.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(ModifyLoginClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    [self ConfigUI];
}
- (void)ConfigUI{
    OldLoginView = [[customWithStatic alloc]init];
    [self.view addSubview:OldLoginView];
    [OldLoginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(10);
        make.top.mas_equalTo(self.view.mas_top).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH - 20);
        make.height.mas_equalTo(40);
    }];
    
    NewLoginView = [[customWithStatic alloc]init];
    [self.view addSubview:NewLoginView];
    [NewLoginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(10);
        make.top.mas_equalTo(OldLoginView.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH - 20);
        make.height.mas_equalTo(40);

    }];
    
    SureLoginView = [[customWithStatic alloc]init];
    [self.view addSubview:SureLoginView];
    [SureLoginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(10);
        make.top.mas_equalTo(NewLoginView.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH - 20);
        make.height.mas_equalTo(40);
        
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
        make.top.mas_equalTo(SureLoginView.mas_bottom).offset(20);
        make.width.mas_equalTo(SCREEN_WIDTH - 80);
        make.height.mas_equalTo(30);
    }];
    
    UITapGestureRecognizer *SaleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(LoginBackBtn
                                                                                                          )];
    [SaleLabel addGestureRecognizer:SaleTap];
}
- (void)LoginBackBtn{
    //提交
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[UserSetViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
}
- (void)ModifyLoginClick{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[UserSetViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
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
