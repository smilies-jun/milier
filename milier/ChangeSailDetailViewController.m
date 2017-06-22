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
#import "DataChoseView.h"
#import "WSDatePickerView.h"

@interface ChangeSailDetailViewController ()<UITextFieldDelegate>{
    UIView *TopView;
    ProfilView *ComeBackMoneyView;
    ProfilView *OneDayView;
    ProfilView *RateView;
    
    
    customWithStatic *ChangeView;
    customWithStatic *DealPassWordView;
    DataChoseView *OutSailView;
    UILabel *SaleLabel;
    NSInteger *myDataTimeStr;

}

@end

@implementation ChangeSailDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"债权转让";
    self.view.backgroundColor = colorWithRGB(0.93, 0.93, 0.93);
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
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
    TopView.userInteractionEnabled = YES;
    [TopView addGestureRecognizer:tap];
    TopView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:TopView];
    [TopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self.view.mas_top);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(100);
    }];
    
    UILabel *TitltLabel = [[UILabel alloc]init];
    TitltLabel.text =_TitleName;
    TitltLabel.textAlignment = NSTextAlignmentCenter;
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
    NumberLabel.text = [NSString stringWithFormat:@"¥%@",_MoneyName];
    NumberLabel.font = [UIFont systemFontOfSize:40];
    NumberLabel.textAlignment = NSTextAlignmentCenter;
    NumberLabel.textColor = colorWithRGB(0.95, 0.6, 0.11);
    [TopView addSubview:NumberLabel];
    [NumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(TopView.mas_centerX);
        make.top.mas_equalTo(TitltLabel.mas_bottom).offset(5);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(40);
    }];
    
    UILabel *DetailLabel = [[UILabel alloc]init];
    DetailLabel.text = @"(债权包价值)";
    DetailLabel.textAlignment = NSTextAlignmentCenter;
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
    ComeBackMoneyView.GorrowView.hidden = YES;
    ComeBackMoneyView.NameLabel.text = @"回款金额";
    [self.view addSubview:ComeBackMoneyView];
    [ComeBackMoneyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(TopView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(40);
    }];
    OneDayView = [[ProfilView alloc]init];
    OneDayView.GorrowView.hidden = YES;

    OneDayView.NameLabel.text = @"当日转让率";
    OneDayView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:OneDayView];
    [OneDayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(ComeBackMoneyView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(40);
    }];
    
    RateView = [[ProfilView alloc]init];
    RateView.NameLabel.text = @"手续费";
    RateView.GorrowView.hidden = YES;

    RateView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:RateView];
    [RateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(OneDayView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(40);
    }];
    
    ChangeView = [[customWithStatic alloc]init];
    ChangeView.NameLabel.text = @"转让金额";
    ChangeView.NameTextField.placeholder = @"请输入转让金额";
    ChangeView.NameTextField.delegate = self;
    ChangeView.NameTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:ChangeView];
    [ChangeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(10);
        make.top.mas_equalTo(RateView.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH -20);
        make.height.mas_equalTo(40);
    }];
    
    OutSailView = [[DataChoseView alloc]init];
    OutSailView.NameLabel.text = @"下架时间";
    OutSailView.NameChoseLabel.text = @"请选择日期";
    OutSailView.NameChoseLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *choseTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(choseClick)];
    [OutSailView addGestureRecognizer:choseTap];
    [self.view addSubview:OutSailView];
    [OutSailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(10);
        make.top.mas_equalTo(ChangeView.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH -20);
        make.height.mas_equalTo(40);
    }];
    
    DealPassWordView = [[customWithStatic alloc]init];
    DealPassWordView.NameLabel.text = @"交易密码";
    DealPassWordView.NameTextField.secureTextEntry = YES;
    DealPassWordView.NameTextField.placeholder = @"请输入交易密码";
    DealPassWordView.NameTextField.delegate = self;
    DealPassWordView.NameTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:DealPassWordView];
    [DealPassWordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(10);
        make.top.mas_equalTo(OutSailView.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH -20);
        make.height.mas_equalTo(40);
    }];
    
    
    UILabel *MyLabel = [[UILabel alloc]init];
    MyLabel.text = @"该日期零点前无人购买，自动取消转让";
    MyLabel.font = [UIFont systemFontOfSize:11];
    MyLabel.textAlignment = NSTextAlignmentCenter;
    MyLabel.textColor = [UIColor blackColor];
    [self.view addSubview:MyLabel];
    [MyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(DealPassWordView.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(20);
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
        make.top.mas_equalTo(MyLabel.mas_bottom).offset(20);
        make.width.mas_equalTo(SCREEN_WIDTH - 80);
        make.height.mas_equalTo(40);
    }];
    
    UITapGestureRecognizer *SaleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TiJiaoBtn
                                                                                                          )];
    [SaleLabel addGestureRecognizer:SaleTap];
//    if ([ChangeView.NameTextField.text integerValue] > 0) {
//        NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
//        NSTimeInterval a=[dat timeIntervalSince1970]*1000;
//        NSString *timeString = [NSString stringWithFormat:@"%f", a];
//        NSInteger time = [_TimeName integerValue] - [timeString integerValue];
//        NSInteger days = time/3600/24/1000;
//        
//        NSInteger myPercent = ([_MoneyName integerValue] - [ChangeView.NameTextField.text integerValue])*365*100/ [ChangeView.NameTextField.text integerValue]/days;
//        
//        OneDayView.DetailLabel.text = [NSString stringWithFormat:@"%ld%%",(long)myPercent];
//        
//        NSInteger rate = [ChangeView.NameTextField.text integerValue]*myPercent;
//        RateView.DetailLabel.text = [NSString stringWithFormat:@"%ld",(long)rate];
//        
//        NSInteger comeBack = [ChangeView.NameTextField.text integerValue] - rate;
//        ComeBackMoneyView.DetailLabel.text = [NSString stringWithFormat:@"%ld",(long)comeBack];
//    }
   

}
- (void)tapClick{
    [self HideKeyBoardClick];
    [self relreshUI];

}
- (void)choseClick{
    [self HideKeyBoardClick];
    WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDay CompleteBlock:^(NSDate *startDate) {
        NSString *date = [startDate stringWithFormat:@"yyyy-MM-dd "];
        OutSailView.NameChoseLabel.text = date;
        NSInteger timeSp = [[NSNumber numberWithDouble:[startDate timeIntervalSince1970]] integerValue];
        myDataTimeStr = timeSp;
    }];
    datepicker.doneButtonColor = [UIColor orangeColor];//确定按钮的颜色
    [datepicker show];

}
//提交
- (void)TiJiaoBtn{
    if ([ChangeView.NameTextField.text integerValue] > 0) {
        if ([ChangeView.NameTextField.text integerValue] <= [_MoneyName integerValue]) {
            
            
            
            if ([OutSailView.NameChoseLabel.text isEqualToString:@"请选择日期"]) {
                normal_alert(@"提示", @"请选择日期", @"确定");

            }else{
                
                if ([DealPassWordView.NameTextField.text integerValue] < 0) {
                    normal_alert(@"提示", @"交易密码不能为空", @"确定");

                }else{
                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                    
                    [formatter setDateStyle:NSDateFormatterMediumStyle];
                    
                    [formatter setTimeStyle:NSDateFormatterShortStyle];
                    
                    [formatter setDateFormat:@"YYYY-MM-dd"]; //(@"YYYY-MM-dd hh:mm:ss") ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
                    
                    
                    
                    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
                    
                    [formatter setTimeZone:timeZone];
                    
                    
                    NSDate* date = [formatter dateFromString:OutSailView.NameChoseLabel.text]; //------------将字符串按formatter转成nsdate
                    
                    //时间转时间戳的方法:
                    
                    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
                    
                    
                    NSString *ExpirTimeStr = [NSString stringWithFormat:@"%ld",(long)timeSp*1000];
                    
                    NSString *url;
                    NSString *tokenID = NSuserUse(@"Authorization");
                    //url = [NSString stringWithFormat:@"%@/%@/password",USER_URL,userID];
                    url = [NSString stringWithFormat:@"%@/products/action/addDebentureTransferProduct",HOST_URL];
                    
                    NSMutableDictionary   *dic = [[NSMutableDictionary alloc]initWithObjectsAndKeys:ChangeView.NameTextField.text,@"amount",RateView.DetailLabel.text,@"fee", _OrderNumber ,@"orderNo",ExpirTimeStr,@"expireTime",DealPassWordView.NameTextField.text,@"dealPassword",nil];
                    [[DateSource sharedInstance]requestHomeWithParameters:dic withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
                        NSString *state = [result objectForKey:@"statusCode"];
                        if ([state integerValue] == 201) {
                            normal_alert(@"提示", @"提交成功", @"确定");
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                [self.navigationController popToRootViewControllerAnimated:NO];
                            });
                        }else{
                            NSString *message = [result objectForKey:@"message"];
                            normal_alert(@"提示", message, @"确定");

                        }
                    }];
 
                }
                
                
            }

            
            

      }else{
            normal_alert(@"提示", @"转出金额不能大于债权包价值", @"确定");
 
        }
        
    }else{
        normal_alert(@"提示", @"转出金额不能为0", @"确定");
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.text.length) {
        [self relreshUI];
 
    }
   
    
    
}
- (void)relreshUI{
    if ([ChangeView.NameTextField.text integerValue] > 0) {
        NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
        NSTimeInterval a=[dat timeIntervalSince1970]*1000;
        NSString *timeString = [NSString stringWithFormat:@"%f", a];
        NSInteger time = [_TimeName integerValue] - [timeString integerValue];
        NSInteger days = time/3600/24/1000;
        
        double myPercent = ([_MoneyName integerValue] - [ChangeView.NameTextField.text doubleValue])*365*100/ [ChangeView.NameTextField.text doubleValue]/days;
        
        OneDayView.DetailLabel.text = [NSString stringWithFormat:@"%.2f%%",myPercent];
        
        double rate = [ChangeView.NameTextField.text integerValue]*myPercent/100*0.02;
        RateView.DetailLabel.text = [NSString stringWithFormat:@"%.2f元",rate];
        
        double comeBack = [ChangeView.NameTextField.text doubleValue] - rate;
        ComeBackMoneyView.DetailLabel.text = [NSString stringWithFormat:@"%.2f元",comeBack];
    }
    
    
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
