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
#import "MyJiFenViewController.h"
#import "giftModel.h"


@interface CostViewController (){
    CustomChooseView *NameChooseView;
    CustomChooseView *CodeChooseView;
    CustomView *PhoneView;
}

@end

@implementation CostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"兑换礼品";
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
    
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(0, 7, 18, 18);
    [leftBtn setImage:[UIImage imageNamed:@"backarrow@2x.png"] forState:UIControlStateNormal];
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
    PhoneView.NameLabel.text = @"消费积分";
    PhoneView.NameTextField.placeholder = @"请输入手机号码";
    PhoneView.NameTextField.keyboardType = UIKeyboardTypeNamePhonePad;
    [self.view addSubview:PhoneView];
    [PhoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(CodeChooseView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(44);    }];
    

    UILabel *SaleLbel =  [[UILabel alloc]init];
    SaleLbel.text = @"兑换";
    SaleLbel.userInteractionEnabled = YES;
    SaleLbel.backgroundColor =colorWithRGB(0.95, 0.6, 0.11);
    SaleLbel.textAlignment = NSTextAlignmentCenter;
    SaleLbel.textColor = [UIColor whiteColor];
    SaleLbel.layer.cornerRadius = 10;
    SaleLbel.layer.masksToBounds = YES;
    [self.view addSubview:SaleLbel];
    [SaleLbel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.top.mas_equalTo(PhoneView.mas_bottom).offset(15);
        make.width.mas_equalTo(SCREEN_WIDTH-40);
        make.height.mas_equalTo(44);
    }];
    
    UITapGestureRecognizer *SaleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(QuerenBtnClick
                                                                                                          )];
    [SaleLbel addGestureRecognizer:SaleTap];
    
}
- (void)QuerenBtnClick{
    if (PhoneView.NameTextField.text.length) {
        NSString * url = [NSString stringWithFormat:@"%@/commodityOrders",HOST_URL];
        
        NSMutableDictionary *dic = [[NSMutableDictionary   alloc]initWithObjectsAndKeys:_ProductID, @"commodityId",PhoneView.NameTextField.text,@"phoneNumber",nil];
        NSString *tokenID = NSuserUse(@"Authorization");
        [[DateSource sharedInstance]requestHomeWithParameters:dic withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
            if ([[result objectForKey:@"statusCode"]integerValue] == 201) {
                [self.navigationController popToRootViewControllerAnimated:NO];
            }else{
                NSString *message = [result objectForKey:@"message"];
                normal_alert(@"提示", message, @"确定");
                
            }
        }];

    }else{
        normal_alert(@"提示", @"手机号不可为空", @"确定　");
    }
    
    
}
- (void)PhoneTap{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[MyJiFenViewController class]]) {
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
