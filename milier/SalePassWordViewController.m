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
#import "UserSetViewController.h"
#import "MyLeftViewController.h"

@interface SalePassWordViewController (){
    customWithStatic *SaleNewPassWordView;
    customWithStatic *SaleSurePassWordView;

}

@end

@implementation SalePassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.navigationItem.title = @"设置交易密码";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor blackColor]}];

    self.view.backgroundColor = colorWithRGB(0.97, 0.97, 0.97);
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(0, 0, 44, 44);
    [leftBtn setImage:[UIImage imageNamed:@"backarrow"] forState:UIControlStateNormal];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0,0,0,8 *SCREEN_WIDTH/375.0)];
    [leftBtn addTarget:self action:@selector(SaleBackClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;

    [self ConFigUI];
}
- (void)ConFigUI{
    SaleNewPassWordView = [[customWithStatic alloc]init];
    SaleNewPassWordView.NameLabel.text = @"新交易密码:";
    SaleNewPassWordView.NameTextField.placeholder = @"密码至少6位";
    SaleNewPassWordView.NameTextField.secureTextEntry = YES;;
    SaleNewPassWordView.NameTextField.delegate = self;
    [self.view addSubview:SaleNewPassWordView];
    [SaleNewPassWordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.top.mas_equalTo(self.view.mas_top).offset(10);
        make.width.mas_offset(SCREEN_WIDTH - 40);
        make.height.mas_equalTo(44);
    }];
    
    SaleSurePassWordView = [[customWithStatic alloc]init];
    SaleSurePassWordView.NameLabel.text = @"确认新密码:";
    SaleSurePassWordView.NameTextField.placeholder = @"请再次输入交易密码";
    SaleSurePassWordView.NameTextField.secureTextEntry =YES;
    SaleSurePassWordView.NameTextField.delegate = self;
    [self.view addSubview:SaleSurePassWordView];
    [SaleSurePassWordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.top.mas_equalTo(SaleNewPassWordView.mas_bottom).offset(10);
        make.width.mas_offset(SCREEN_WIDTH - 40);
        make.height.mas_equalTo(44);
    }];
    UILabel *SaleLbel =  [[UILabel alloc]init];
    SaleLbel.text = @"设置交易密码";
    SaleLbel.userInteractionEnabled = YES;
    SaleLbel.backgroundColor = colorWithRGB(0.95, 0.6, 0.11);
    SaleLbel.textAlignment = NSTextAlignmentCenter;
    SaleLbel.textColor = [UIColor whiteColor];
    SaleLbel.layer.cornerRadius = 20;
    SaleLbel.layer.masksToBounds = YES;
    [self.view addSubview:SaleLbel];
    [SaleLbel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(40);
        make.top.mas_equalTo(SaleSurePassWordView.mas_bottom).offset(20);
        make.width.mas_equalTo(SCREEN_WIDTH - 80);
        make.height.mas_equalTo(40);
    }];
    
    UITapGestureRecognizer *SaleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(reFreshData
                                                                                                          )];
    [SaleLbel addGestureRecognizer:SaleTap];

}

- (void)reFreshData{
    if (SaleNewPassWordView.NameTextField.text.length>=6) {
        if (SaleSurePassWordView.NameTextField.text.length) {
            if ([SaleNewPassWordView.NameTextField.text isEqualToString:SaleSurePassWordView.NameTextField.text]) {
                
                [self reloaData];
            }else{
                normal_alert(@"提示", @"两次输入密码不一致", @"确定");
                
            }
  
        }else{
              normal_alert(@"提示", @"确认交易密码不能为空", @"确定");
        }
        
        
        
    }else{
        normal_alert(@"提示", @"交易密码最少6位", @"确定");
        
   }
    
    
}



- (void)reloaData{
    
    
    NSString *url;
    NSString *userID = NSuserUse(@"userId");
    NSString *tokenID = NSuserUse(@"Authorization");
    //url = [NSString stringWithFormat:@"%@/%@/password",USER_URL,userID];
    url = [NSString stringWithFormat:@"%@/users/%@/dealPassword",HOST_URL,userID];
    
    NSMutableDictionary   *dic = [[NSMutableDictionary alloc]initWithObjectsAndKeys:SaleNewPassWordView.NameTextField.text,@"dealPassword", nil];
    [[DateSource sharedInstance]requestHomeWithParameters:dic withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
        NSString *staues = [result objectForKey:@"statusCode"];
        //NSLog(@"re == %@",result);
        if ([staues integerValue] == 201) {
            //提交
            normal_alert(@"提示", @"交易密码设置成功", @"确定");
            [self SaleBackClick];
//            for (UIViewController *controller in self.navigationController.viewControllers) {
//                if ([controller isKindOfClass:[SaleViewController class]]) {
//                    [self.navigationController popToViewController:controller animated:YES];
//                }
//            }
        }else{
            NSString *message = [result objectForKey:@"message"];
            normal_alert(@"提示", message, @"确定");
        }
        
    }];
}

///输入密码的判断
- (void)SaleSureBtnClick{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[SaleViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
    
//    //未绑卡
//    BundCardViewController *bundVC = [[BundCardViewController alloc]init];
//    [self.navigationController pushViewController:bundVC    animated:NO];
}
- (void)SaleBackClick{
    //  返回指定页面
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[SaleViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
    
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[UserSetViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
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
