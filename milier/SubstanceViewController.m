//
//  SubstanceViewController.m
//  milier
//
//  Created by amin on 2017/5/8.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "SubstanceViewController.h"
#import "CustomChooseView.h"
#import "CustomView.h"
#import "MyJiFenViewController.h"
#import "LZCityPickerView.h"
#import "LZCityPickerController.h"
#import "FYLCityPickView.h"

@interface SubstanceViewController (){
    CustomChooseView *NameChooseView;
    CustomChooseView *CodeChooseView;
    
    CustomView *CustomUseView;
    CustomView *CustomPhoneView;
    CustomChooseView*AddressChooseView;
    CustomView *CustomAddressView;
}


@end

@implementation SubstanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"兑换礼品";
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
    self.view.backgroundColor = colorWithRGB(0.93, 0.93, 0.93);

    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(0, 7, 18, 18);
    [leftBtn setImage:[UIImage imageNamed:@"backarrow@2x.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(SubstanceTap) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;

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
    
    CustomUseView = [[CustomView alloc]init];
    CustomUseView.NameLabel.text = @"收货人";
    CustomUseView.NameTextField.placeholder = @"请输入收货人姓名";
    [self.view addSubview:CustomUseView];
    [CustomUseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(CodeChooseView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(44);
    }];
    CustomPhoneView = [[CustomView alloc]init];
    CustomPhoneView.NameLabel.text = @"手机号码";
    CustomPhoneView.NameTextField.keyboardType = UIKeyboardTypeNamePhonePad;

    CustomPhoneView.NameTextField.placeholder = @"请输入收货人手机号码";
    [self.view addSubview:CustomPhoneView];
    [CustomPhoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(CustomUseView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(44);
    }];
    AddressChooseView = [[CustomChooseView alloc]init];
    AddressChooseView.ChooseLabel.text = @"请选择地区";
    AddressChooseView.NameLabel.text = @"所在地区";
    AddressChooseView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ChoseBtnClick)];
    [AddressChooseView addGestureRecognizer:tap ];
    
    [self.view addSubview:AddressChooseView];
    [AddressChooseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(CustomPhoneView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(44);
    }];
    
    CustomAddressView = [[CustomView alloc]init];
    CustomAddressView.NameLabel.text = @"收获地址";
    CustomAddressView.NameTextField.placeholder = @"请输入收货人地址";
    [self.view addSubview:CustomAddressView];
    [CustomAddressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(AddressChooseView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(44);
    }];
    
    UILabel *SaleLbel =  [[UILabel alloc]init];
    SaleLbel.text = @"兑换";
    SaleLbel.userInteractionEnabled = YES;
    SaleLbel.backgroundColor = colorWithRGB(0.95, 0.6, 0.11);
    SaleLbel.textAlignment = NSTextAlignmentCenter;
    SaleLbel.textColor = [UIColor whiteColor];
    SaleLbel.layer.cornerRadius = 10;
    SaleLbel.layer.masksToBounds = YES;
    [self.view addSubview:SaleLbel];
    [SaleLbel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.top.mas_equalTo(CustomAddressView.mas_bottom).offset(15);
        make.width.mas_equalTo(SCREEN_WIDTH-40);
        make.height.mas_equalTo(44);
    }];
    
    UITapGestureRecognizer *SaleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(QuerenBtnClick
                                                                                                          )];
    [SaleLbel addGestureRecognizer:SaleTap];

}
- (void)QuerenBtnClick{
    [self HideKeyBoardClick];
    NSString *AddStr;
    if (CustomUseView.NameTextField.text.length) {
        if (CustomPhoneView.NameTextField.text.length) {
            if (CustomAddressView.NameTextField.text.length) {
                if ([AddressChooseView.ChooseLabel.text isEqualToString:@"请选择地区"]) {
                }else{
                    AddStr = AddressChooseView.ChooseLabel.text;
 
                }
               NSString * url = [NSString stringWithFormat:@"%@/commodityOrders",HOST_URL];

                NSString *MyAddressStr = [AddStr stringByAppendingString:[NSString stringWithFormat:@"%@",CustomAddressView.NameTextField.text]];
                NSMutableDictionary *dic = [[NSMutableDictionary   alloc]initWithObjectsAndKeys:_ProductID, @"commodityId",CustomPhoneView.NameTextField.text,@"phoneNumber",MyAddressStr,@"address",CustomUseView.NameTextField.text,@"person",nil];
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
                normal_alert(@"提示", @"请输入收货地址", @"确定");

            }
        }else{
            normal_alert(@"提示", @"请输入收货人手机号码", @"确定");
  
        }
    }else{
        normal_alert(@"提示", @"请输入收货人姓名", @"确定");
    


}
}

- (void)ChoseBtnClick{
    [self HideKeyBoardClick];
    [FYLCityPickView showPickViewWithComplete:^(NSArray *arr) {
        AddressChooseView.ChooseLabel.text = [NSString stringWithFormat:@"%@-%@-%@",arr[0],arr[1],arr[2]];
    }];

    
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

- (void)SubstanceTap{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[MyJiFenViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
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
