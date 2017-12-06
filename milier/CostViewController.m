//
//  CostViewController.m
//  milier
//
//  Created by amin on 2017/5/8.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "CostViewController.h"
#import "CustomChooseView.h"
#import "CustomView.h"
#import "ConvertViewController.h"
#import "giftModel.h"
#import "MyJiFenNewViewController.h"

@interface CostViewController (){
    CustomChooseView *NameChooseView;
    CustomChooseView *CodeChooseView;
    CustomView *PhoneView;
    MBProgressHUD *hud;
}

@end

@implementation CostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"兑换礼品";
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
    
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(0, 0, 44, 44);
    [leftBtn setImage:[UIImage imageNamed:@"backarrow"] forState:UIControlStateNormal];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0,0,0,8 *SCREEN_WIDTH/375.0)];
    [leftBtn addTarget:self action:@selector(PhoneTap) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.view.backgroundColor = colorWithRGB(0.93, 0.93, 0.93);
    [self ConfigUI];
}
- (void)ConfigUI{
    NameChooseView = [[CustomChooseView alloc]init];
    NameChooseView.NameLabel.text= @"礼品名称";
    NameChooseView.ChooseLabel.text = _NameStr;
    [self.view addSubview:NameChooseView];
    [NameChooseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self.view.mas_top).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(44);
    }];
    CodeChooseView = [[CustomChooseView alloc]init];
    CodeChooseView.NameLabel.text = @"消费积分";
    CodeChooseView.ChooseLabel.text = _ScoreStr ;
    [self.view addSubview:CodeChooseView];
    [CodeChooseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(NameChooseView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(44);
    }];
    PhoneView = [[CustomView alloc]init];
    PhoneView.NameLabel.text = @"手机号码";
    
    if ([_TypeStr integerValue] == 1) {
        NSString *PhoneID = NSuserUse(@"phoneNumber");
        
        PhoneView.NameTextField.text = PhoneID;
        PhoneView.NameTextField.enabled = NO;

    }else{
        
        PhoneView.NameTextField.placeholder = @"请输入手机号码";
    }
   
    PhoneView.NameTextField.keyboardType = UIKeyboardTypeNamePhonePad;
    [self.view addSubview:PhoneView];
    [PhoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(CodeChooseView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(44);
    }];
    

    UILabel *SaleLbel =  [[UILabel alloc]init];
    SaleLbel.text = @"兑换";
    SaleLbel.userInteractionEnabled = YES;
    SaleLbel.backgroundColor =colorWithRGB(0.95, 0.6, 0.11);
    SaleLbel.textAlignment = NSTextAlignmentCenter;
    SaleLbel.textColor = [UIColor whiteColor];
    SaleLbel.layer.cornerRadius = 20;
    SaleLbel.layer.masksToBounds = YES;
    [self.view addSubview:SaleLbel];
    [SaleLbel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.top.mas_equalTo(PhoneView.mas_bottom).offset(15);
        make.width.mas_equalTo(SCREEN_WIDTH-40);
        make.height.mas_equalTo(40);
    }];
    
    UITapGestureRecognizer *SaleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(QuerenBtnClick
                                                                                                          )];
    [SaleLbel addGestureRecognizer:SaleTap];
    
}

#pragma 正则匹配手机号
-(BOOL)checkTelNumber:(NSString *) telNumber
{
    NSString *MOBILE = @"^1[34578]\\d{9}$";
    
    NSPredicate *regexTestMobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",MOBILE];
    /*
     if ([regexTestMobile evaluateWithObject:self]) {
     
     return YES;
     
     }else {
     
     return NO;
     
     }*/
    return [regexTestMobile evaluateWithObject:telNumber];
}
- (void)HideProgress{
    [hud hideAnimated:YES afterDelay:1.f];
}
- (void)showProgress{
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
    
    // Set the label text.
    
    hud.label.text = NSLocalizedString(@"正在请求中", @"HUD loading title");
}
- (void)QuerenBtnClick{
    if (PhoneView.NameTextField.text.length) {
        
        if ([self checkTelNumber:PhoneView.NameTextField.text]) {
            NSString * url = [NSString stringWithFormat:@"%@/commodityOrders",HOST_URL];
            
            NSMutableDictionary *dic = [[NSMutableDictionary   alloc]initWithObjectsAndKeys:_ProductID, @"commodityId",PhoneView.NameTextField.text,@"phoneNumber",nil];
            NSString *tokenID = NSuserUse(@"Authorization");
            
            [self showProgress];
            [[DateSource sharedInstance]requestHomeWithParameters:dic withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
                if ([[result objectForKey:@"statusCode"]integerValue] == 201) {
                    [self HideProgress];
                     normal_alert(@"提示", @"兑换成功", @"确定");
                    for (UIViewController *controller in self.navigationController.viewControllers) {
                        if ([controller isKindOfClass:[MyJiFenNewViewController class]]) {
                            [self.navigationController popToViewController:controller animated:YES];
                        }
                    }
                }else{
                    [self HideProgress];

                    NSString *message = [result objectForKey:@"message"];
                    normal_alert(@"提示", message, @"确定");
                    
                }
            }];

        }else{
            normal_alert(@"提示", @"手机号码格式不正确", @"确定");
        }
        
    }else{
        normal_alert(@"提示", @"手机号不可为空", @"确定　");
    }
    
    
}
- (void)PhoneTap{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[ConvertViewController class]]) {
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
    // 马上进入刷新状态
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
