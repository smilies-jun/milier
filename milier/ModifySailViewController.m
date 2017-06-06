//
//  ModifySailViewController.m
//  milier
//
//  Created by amin on 17/4/21.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "ModifySailViewController.h"
#import "UserSetViewController.h"
#import "customWithStatic.h"

@interface ModifySailViewController (){
customWithStatic *OldSailView;
customWithStatic *NewSailView;
customWithStatic *SureSailView;
UILabel *SaleLabel;
    
}
@end

@implementation ModifySailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"修改交易密码";
    self.view.backgroundColor = colorWithRGB(0.94, 0.94, 0.94);
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(0, 7, 18, 18);
    [leftBtn setImage:[UIImage imageNamed:@"backarrow@2x.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(ModifySailClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    [self ConfigUI];

}
- (void)ConfigUI{
    OldSailView = [[customWithStatic alloc]init];
    OldSailView.NameLabel.text = @"原交易密码";
    OldSailView.NameTextField.placeholder = @"请输入原交易密码";
    [self.view addSubview:OldSailView];
    [OldSailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(10);
        make.top.mas_equalTo(self.view.mas_top).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH - 20);
        make.height.mas_equalTo(40);
    }];
    
    NewSailView = [[customWithStatic alloc]init];
    NewSailView.NameLabel.text = @"新交易密码";
    NewSailView.NameTextField.placeholder = @"请输入新交易密码";
    [self.view addSubview:NewSailView];
    [NewSailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(10);
        make.top.mas_equalTo(OldSailView.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH - 20);
        make.height.mas_equalTo(40);
        
    }];
    
    SureSailView = [[customWithStatic alloc]init];
    SureSailView.NameLabel.text = @"确认交易密码";
    SureSailView.NameTextField.placeholder = @"请再次确认交易密码";
    [self.view addSubview:SureSailView];
    [SureSailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(10);
        make.top.mas_equalTo(NewSailView.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH - 20);
        make.height.mas_equalTo(40);
        
    }];
    
    SaleLabel = [[UILabel alloc]init];
    SaleLabel.text = @"提交";
    SaleLabel.userInteractionEnabled = YES;
    SaleLabel.backgroundColor = colorWithRGB(0.95, 0.6, 0.11);
    SaleLabel.textAlignment = NSTextAlignmentCenter;
    SaleLabel.textColor = [UIColor whiteColor];
    SaleLabel.layer.cornerRadius = 10;
    SaleLabel.layer.masksToBounds = YES;
    [self.view addSubview:SaleLabel];
    [SaleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(40);
        make.top.mas_equalTo(SureSailView.mas_bottom).offset(20);
        make.width.mas_equalTo(SCREEN_WIDTH - 80);
        make.height.mas_equalTo(40);
    }];
    
    UITapGestureRecognizer *SaleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SailBackBtn
                                                                                                          )];
    [SaleLabel addGestureRecognizer:SaleTap];
}
- (void)SailBackBtn{
    
    if (OldSailView.NameTextField.text.length) {
        if (NewSailView.NameLabel.text.length < 5 ) {
            normal_alert(@"提示", @"密码至少六位", @"确定");
            
        }else{
            if (NewSailView.NameTextField.text.length) {
                if ([NewSailView.NameTextField.text isEqualToString:SureSailView.NameTextField.text]) {
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
    url = [NSString stringWithFormat:@"%@/users/%@/dealPassword",HOST_URL,userID];
    
    NSMutableDictionary   *dic = [[NSMutableDictionary alloc]initWithObjectsAndKeys:OldSailView.NameTextField.text,@"dealPassword",NewSailView.NameTextField.text,@"newDealPassword",   nil];
    [[DateSource sharedInstance]requestPutWithParameters:dic withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
        NSString *staues = [result objectForKey:@"statusCode"];
        if ([staues integerValue] == 201) {
            //提交
            for (UIViewController *controller in self.navigationController.viewControllers) {
                if ([controller isKindOfClass:[UserSetViewController class]]) {
                    [self.navigationController popToViewController:controller animated:YES];
                }
            }
        }else{
            NSString *message = [result objectForKey:@"message"];
            normal_alert(@"提示", message, @"确定");
        }
        
    }];
    
    
    
}


- (void)ModifySailClick{
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
