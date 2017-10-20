//
//  TouUpViewController.m
//  milier
//
//  Created by amin on 17/4/19.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "TouUpViewController.h"
#import "SaleViewController.h"
#import "MyLeftViewController.h"
#import "CustomView.h"
#import "LLPayUtil.h"
#import "LLOrder.h"
#import "YJForgetDealPassWordViewController.h"
#import "SaleViewController.h"

/*! TODO: 修改两个参数成商户自己的配置 */
static NSString *kLLOidPartner = @"201707271001909517";//@"201408071000001546";                 // 商户号
static NSString *kLLPartnerKey = @"szqhMLE2016Md5";//@"201408071000001546_test_20140815";   // 密钥
static NSString *signType = @"MD5"; //签名方式

/*! 接入什么支付产品就改成那个支付产品的LLPayType，如快捷支付就是LLPayTypeQuick */

static LLPayType payType = LLPayTypeVerify;


@interface TouUpViewController (){
    CustomView *payView;
    CustomView *PassWordView;
    
    NSDictionary *myDic;
    NSString *orderStr;
    NSString *createTimeStr;
    NSString *reginStr;
    
    UILabel *ForgetPayLabel;
    NSMutableDictionary *myBankDic;
    NSString *BankStatus;
    MBProgressHUD *hud;

}
@property (nonatomic, strong) LLOrder *order;
@property (nonatomic, retain) NSMutableDictionary *orderDic;
@end

@implementation TouUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"充值";
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
    
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(0, 7, 18, 18);
    [leftBtn setImage:[UIImage imageNamed:@"backarrow@2x.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(TouUpTap) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    myBankDic = [[NSMutableDictionary alloc]init];
    [self reloadData];
   // [self configUI];
    self.view.backgroundColor = colorWithRGB(0.94, 0.94, 0.94);
}
- (void)reloadData{
    NSString *Statisurl;
    NSString *tokenID = NSuserUse(@"Authorization");
    NSString *bankID = NSuserUse(@"bankId");
    
    Statisurl = [NSString stringWithFormat:@"%@/banks/%@",HOST_URL,bankID];
    [[DateSource sharedInstance]requestHtml5WithParameters:nil  withUrl:Statisurl withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
        NSString *statusStr = [result objectForKey:@"statusCode"];
        if ([statusStr integerValue] == 200) {
            myDic = [result objectForKey:@"items"];
            [self configUI];
        }
        
    }];
}
- (void)reloadMyMoney{
    NSString *Statisurl;
    NSString *userID = NSuserUse(@"userId");
    NSString *tokenID = NSuserUse(@"Authorization");
    Statisurl = [NSString stringWithFormat:@"%@/%@",USER_URL,userID];
    [[DateSource sharedInstance]requestHtml5WithParameters:nil  withUrl:Statisurl withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
        NSString *statusStr = [result objectForKey:@"statusCode"];
        if ([statusStr integerValue] == 200) {
            BankStatus = [NSString stringWithFormat:@"%@",[[result objectForKey:@"data"]objectForKey:@"bankCardExist"]];
       
            
        }
        
    }];
    
}

- (void)configUI{
    payView = [[CustomView alloc]init];
    payView.NameLabel.text = @"充值金额";
    payView.NameTextField.placeholder = @"请输入充值金额";
    payView.NameTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:payView];
    [payView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.top.mas_equalTo(self.view.mas_top).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH - 40);
        make.height.mas_equalTo(44);
    }];
    PassWordView = [[CustomView alloc]init];
    PassWordView.NameLabel.text = @"交易密码";
    PassWordView.NameTextField.secureTextEntry = YES;
    PassWordView.NameTextField.placeholder = @"请输入交易密码";
    [self.view addSubview:PassWordView];
    [PassWordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.top.mas_equalTo(payView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH - 40);
        make.height.mas_equalTo(44);
    }];
    
    ForgetPayLabel = [[UILabel alloc]init];
    ForgetPayLabel.text = @"忘记交易密码？";
    ForgetPayLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *forgetSaleWordTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ForgetClick)];
    [ForgetPayLabel addGestureRecognizer:forgetSaleWordTap];
    
    ForgetPayLabel.textColor = [UIColor orangeColor];
    ForgetPayLabel.textAlignment = NSTextAlignmentLeft;
    ForgetPayLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:ForgetPayLabel];
    [ForgetPayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.top.mas_equalTo(PassWordView.mas_bottom).offset(5);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    }];
    
    UIImageView *bankImageView = [[UIImageView alloc]init];
    [bankImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[myDic objectForKey:@"icon"]]]];
    [self.view addSubview:bankImageView];
    [bankImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.top.mas_equalTo(ForgetPayLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
    }];
    NSString *bankid = NSuserUse(@"bankCardNumberSuffix");
    UILabel *bankLabel = [[UILabel alloc]init];
    bankLabel.text = [NSString stringWithFormat:@"%@(%@)",[myDic objectForKey:@"name"],bankid];
    bankLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:bankLabel];
    [bankLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bankImageView.mas_right).offset(5);
        make.top.mas_equalTo(ForgetPayLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(15);
    }];
    
    UILabel *bankDetailLabel = [[UILabel alloc]init];
    bankDetailLabel.textColor = colorWithRGB(0.53, 0.53, 0.53);
    NSString *single =  [myDic objectForKey:@"singleLimit"];
    NSString *day = [myDic objectForKey:@"dailyLimit"];
    NSString *month = [myDic objectForKey:@"monthLimit"];
    
    double singleLimit = [single doubleValue]/10000;
    
    double dayLimit = [day doubleValue]/10000;
    
    double monuthLimit = [month doubleValue]/10000;
    
    bankDetailLabel.text =[NSString stringWithFormat:@"单笔%.1f万，单日%.1f万，单月%.1f万",singleLimit,dayLimit,monuthLimit];
    bankDetailLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:bankDetailLabel];
    [bankDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bankImageView.mas_right).offset(5);
        make.top.mas_equalTo(bankLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH-10);
        make.height.mas_equalTo(15);
    }];
    
    UILabel *TestLabel =  [[UILabel alloc]init];
    TestLabel.text = @"充值";
    TestLabel.userInteractionEnabled = YES;
    TestLabel.backgroundColor = colorWithRGB(0.95, 0.6, 0.11);
    TestLabel.textAlignment = NSTextAlignmentCenter;
    TestLabel.textColor = [UIColor whiteColor];
    TestLabel.layer.cornerRadius = 20;
    TestLabel.layer.masksToBounds = YES;
    [self.view addSubview:TestLabel];
    [TestLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(40);
        make.top.mas_equalTo(bankImageView.mas_bottom).offset(20);
        make.width.mas_equalTo(SCREEN_WIDTH - 80);
        make.height.mas_equalTo(40);
    }];
    
    UITapGestureRecognizer *SaleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(PaySureBtnClick
                                                                                                          )];
    [TestLabel addGestureRecognizer:SaleTap];
    
}

- (void)ForgetClick{
    YJForgetDealPassWordViewController  *vc = [[YJForgetDealPassWordViewController alloc]init];
    vc.TypeStr = @"1";
    [self.navigationController pushViewController:vc animated:NO];
}
- (void)PaySureBtnClick{
        if ([payView.NameTextField.text integerValue] >= 100) {
            if (PassWordView.NameTextField.text.length) {

                    [self requestBank];
 
        
                
            }else{
                normal_alert(@"提示", @"交易密码不能为空", @"确定");
                
            }
        }else{
            normal_alert(@"提示", @"充值金额不能少于100", @"确定");
        }

   
    
   }
- (void)requestBank{
    NSString *BankStrUrl;
    NSString *bankID = NSuserUse(@"bankCardId");
    NSString *tokenID = NSuserUse(@"Authorization");

    BankStrUrl = [NSString stringWithFormat:@"%@/bankCards/%@",HOST_URL,bankID];
    [[DateSource sharedInstance]requestHtml5WithParameters:nil withUrl:BankStrUrl withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *erro) {
        NSString *statuesCode = [result objectForKey:@"statusCode"];
        if ([statuesCode integerValue] == 200) {
            myBankDic = [result objectForKey:@"data"];
            [self showProgress];
            [self payMoney];

        }else{
            NSString *messageStr = [result objectForKey:@"message"];
            normal_alert(@"提示", messageStr, @"确定");
        }

    }];
}
- (void)HideProgress{
    [hud hideAnimated:YES];
}
- (void)showProgress{
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
    
    // Set the label text.
    
    hud.label.text = NSLocalizedString(@"正在请求中", @"HUD loading title");
}
- (void)payMoney{
    NSString *url;
    NSString *tokenID = NSuserUse(@"Authorization");
    NSString *userID = NSuserUse(@"userId");

    url = [NSString stringWithFormat:@"%@/users/%@/recharge",HOST_URL,userID];
    
    
    NSMutableDictionary  *dic = [[NSMutableDictionary alloc]initWithObjectsAndKeys:payView.NameTextField.text,@"amount",PassWordView.NameTextField.text,@"dealPassword", nil];
    [[DateSource sharedInstance]requestHomeWithParameters:dic withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
        NSString *statuesCode = [result objectForKey:@"statusCode"];
        if ([statuesCode integerValue] == 201) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self HideProgress];

            });
            orderStr = [[result objectForKey:@"data"]objectForKey:@"dealOrderNo"];
            createTimeStr = [[result objectForKey:@"data"]objectForKey:@"createTime"];
            reginStr = [[result objectForKey:@"data"]objectForKey:@"userRegistrationTime"];
            [self createOrder];
            [self requestLLP];
        }else{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self HideProgress];
                
            });
            NSString *messageStr = [result objectForKey:@"message"];
            normal_alert(@"提示", messageStr, @"确定");
        }
        
        
    }];
    
   
    
    
}

- (void)requestLLP{
    self.orderDic = [[_order tradeInfoForPayment] mutableCopy];
    LLPayUtil *payUtil = [[LLPayUtil alloc] init];
    
    // 进行签名
    NSDictionary *signedOrder = [payUtil signedOrderDic:self.orderDic andSignKey:kLLPartnerKey];
    
    [LLPaySdk sharedSdk].sdkDelegate = self;
    
    //接入什么产品就传什么LLPayType
    [[LLPaySdk sharedSdk] presentLLPaySDKInViewController:self
                                              withPayType:payType
                                            andTraderInfo:signedOrder];
}

#pragma - mark 支付结果 LLPaySdkDelegate
// 订单支付结果返回，主要是异常和成功的不同状态
// TODO: 开发人员需要根据实际业务调整逻辑
- (void)paymentEnd:(LLPayResult)resultCode withResultDic:(NSDictionary *)dic {
    
    NSString *msg = @"异常";
    switch (resultCode) {
        case kLLPayResultSuccess: {
            msg = @"成功";
            normal_alert(@"提示", msg, @"确定");
                [self TouUpTap];
        } break;
        case kLLPayResultFail: {
            msg = @"失败";
        } break;
        case kLLPayResultCancel: {
            msg = @"取消";
        } break;
        case kLLPayResultInitError: {
            msg = @"sdk初始化异常";
        } break;
        case kLLPayResultInitParamError: {
            msg = dic[@"ret_msg"];
        } break;
        default:
            break;
    }
    
    NSString *showMsg =
    [msg stringByAppendingString:[LLPayUtil jsonStringOfObj:dic]];
    
}


-(void)createOrder{
                        NSString *userID =[NSString stringWithFormat:@"%@",NSuserUse(@"userId"]);
                       NSString *phoneStr = NSuserUse(@"phoneNumber");
                 
                       _order = [[LLOrder alloc] initWithLLPayType:payType];
                       NSString *timeStamp = [LLOrder timeStamp];
                       _order.oid_partner = kLLOidPartner;
                       _order.sign_type = signType;
                       _order.busi_partner = @"101001";
                       _order.no_order = orderStr;
                       _order.dt_order = timeStamp;
                       _order.money_order = payView.NameTextField.text;
                       _order.notify_url = @"http://139.224.139.178:7000/sunpay-rest/v1/pay_mallpay_result_notify/029";
                        _order.name_goods = @"充值";
                       _order.acct_name =[myBankDic objectForKey:@"username"];
                        _order.card_no = [NSString stringWithFormat:@"%@",[myBankDic objectForKey:@"bankCardNumber"]];
                       _order.id_no = [NSString stringWithFormat:@"%@",[myBankDic objectForKey:@"identityCardNumber"]];
                                           
                       _order.risk_item = [LLOrder llJsonStringOfObj:@{@"user_info_dt_register" : reginStr,@"frms_ware_category":@"2009",@"user_info_mercht_userno":userID,@"user_info_bind_phone":phoneStr,@"user_info_identify_state":@"1",@"user_info_identify_type":@"1",@"user_info_full_name":[myBankDic objectForKey:@"username"],@"user_info_id_no":[NSString stringWithFormat:@"%@",[myBankDic objectForKey:@"identityCardNumber"]]}];
                       _order.user_id = userID;
                       
                       }

- (void)TouUpTap{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[MyLeftViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
    
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[SaleViewController   class]]) {
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
    [super viewWillDisappear:animated];
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
