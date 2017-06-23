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
    self.view.backgroundColor = colorWithRGB(0.94, 0.94, 0.94);
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor blackColor]}];

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
    OldLoginView.NameLabel.text = @"原登录密码";
    OldLoginView.NameTextField.placeholder = @"请输入原登录密码";
    [self.view addSubview:OldLoginView];
    [OldLoginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(10);
        make.top.mas_equalTo(self.view.mas_top).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH - 20);
        make.height.mas_equalTo(40);
    }];
    
    NewLoginView = [[customWithStatic alloc]init];
    NewLoginView.NameLabel.text = @"新登录密码";
    NewLoginView.NameTextField.placeholder = @"密码至少6位";
    [self.view addSubview:NewLoginView];
    [NewLoginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(10);
        make.top.mas_equalTo(OldLoginView.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH - 20);
        make.height.mas_equalTo(40);

    }];
    
    SureLoginView = [[customWithStatic alloc]init];
    SureLoginView.NameLabel.text = @"确认新密码";
    SureLoginView.NameTextField.placeholder = @"请再次输入登录密码";
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
    SaleLabel.backgroundColor = colorWithRGB(0.95, 0.6, 0.11);
    SaleLabel.textAlignment = NSTextAlignmentCenter;
    SaleLabel.textColor = [UIColor whiteColor];
    SaleLabel.layer.cornerRadius = 22;
    SaleLabel.layer.masksToBounds = YES;
    [self.view addSubview:SaleLabel];
    [SaleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(40);
        make.top.mas_equalTo(SureLoginView.mas_bottom).offset(20);
        make.width.mas_equalTo(SCREEN_WIDTH - 80);
        make.height.mas_equalTo(44);
    }];
    
    UITapGestureRecognizer *SaleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(LoginBackBtn
                                                                                                          )];
    [SaleLabel addGestureRecognizer:SaleTap];
}
- (void)LoginBackBtn{
    
    
    if (OldLoginView.NameTextField.text.length) {
        if (NewLoginView.NameLabel.text.length < 5 ) {
            normal_alert(@"提示", @"密码至少六位", @"确定");

        }else{
            if (NewLoginView.NameTextField.text.length) {
                if ([NewLoginView.NameTextField.text isEqualToString:SureLoginView.NameTextField.text]) {
                    [self reFreshData];
                }else{
                    normal_alert(@"提示", @"二次输入密码不一致", @"确定");
                    
                }
            }else{
                normal_alert(@"提示", @"密码不可为空", @"确定");

            }
            
            

        }
        
        
    }else{
        normal_alert(@"提示", @"原密码不可为空", @"确定");
    }
    
   }

- (void)reFreshData{
    NSString *url;
    NSString *userID = NSuserUse(@"userId");
    NSString *tokenID = NSuserUse(@"Authorization");
    //url = [NSString stringWithFormat:@"%@/%@/password",USER_URL,userID];
    url = [NSString stringWithFormat:@"%@/users/%@/password",HOST_URL,userID];

    NSMutableDictionary   *dic = [[NSMutableDictionary alloc]initWithObjectsAndKeys:OldLoginView.NameTextField.text,@"password",NewLoginView.NameTextField.text,@"newPassword",   nil];
    [[DateSource sharedInstance]requestPutWithParameters:dic withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
        NSString *staues = [result objectForKey:@"statusCode"];
        if ([staues integerValue] == 201) {
            NSuserRemove(@"userId");
            NSuserRemove(@"Authorization");
            //提交
            normal_alert(@"提示",@"密码修改成功", @"确定");

            [self.navigationController popToRootViewControllerAnimated:NO];
        }else{
            NSString *message = [result objectForKey:@"message"];
            normal_alert(@"提示", message, @"确定");
        }

    }];
    
    

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
