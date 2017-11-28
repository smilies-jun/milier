//
//  ChangeBankCardViewController.m
//  milier
//
//  Created by amin on 2017/10/19.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "ChangeBankCardViewController.h"
#import "CustomView.h"
#import "TouUpViewController.h"
#import "ModifySailViewController.h"
#import "UserSetViewController.h"
#import "CustomChooseView.h"
#import "ZHPickView.h"
#import "BundProfileViewController.h"
#import <AwAlertViewlib/AwAlertViewlib.h>
#import "ChoseBankTableViewCell.h"
#import "ChoseModel.h"
#import "UIButton+CountDown.h"

@interface ChangeBankCardViewController ()<UITableViewDelegate,UITableViewDataSource>{
    CustomView *phoneNumView;
    CustomView *CodeNumView;
    CustomView *NewPassWordView;
    CustomView *SurePassWordView;
    CustomChooseView *CardBankView;
    UIButton *ClickBtn;
    NSMutableArray *BankArray;
    NSMutableArray *BankIDArray;
    NSString *bankStr;
    NSString *OrderID;
    int _second;
    MBProgressHUD *hud;
    AwAlertView *alertView;
    UITableView *StageTableView;
    NSMutableArray *stageArray;
    
    NSString *BankID;
}


@end

@implementation ChangeBankCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"更换银行卡";
    self.view.backgroundColor = colorWithRGB(0.97, 0.97, 0.97);
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(0, 7, 18, 18);
    [leftBtn setImage:[UIImage imageNamed:@"backarrow@2x.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(ForgetBackClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    BankArray = [[NSMutableArray alloc]init];
    BankIDArray = [[NSMutableArray alloc]init];
    stageArray = [[NSMutableArray alloc]init];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(nextHideKey)];
    [self.view addGestureRecognizer:tap];
    [self getBankCards];
    [self initUI];
}
- (void)nextHideKey{
    [self HideKeyBoardClick];
}
- (void)getBankCards{
    NSString *url;
    url = [NSString stringWithFormat:@"%@/banks?page=1&rows=100",HOST_URL];
    [[DateSource sharedInstance]requestHtml5WithParameters:nil  withUrl:url withTokenStr:@"" usingBlock:^(NSDictionary *result, NSError *error) {
        NSArray *MyStageArray = [result objectForKey:@"items"];
        for (NSDictionary *NewDic in MyStageArray) {
            ChoseModel *model = [[ChoseModel alloc]init];
            model.dataDictionary = NewDic;
            [stageArray addObject:model];
        }
        [StageTableView reloadData];
       [self initUI];
    }];
}
- (void)ForgetBackClick{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[UserSetViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
//    if ([_TypeStr integerValue] == 1) {
//        for (UIViewController *controller in self.navigationController.viewControllers) {
//            if ([controller isKindOfClass:[TouUpViewController class]]) {
//                [self.navigationController popToViewController:controller animated:YES];
//            }
//        }
//    }else if ([_TypeStr integerValue] == 2){
//        for (UIViewController *controller in self.navigationController.viewControllers) {
//            if ([controller isKindOfClass:[ModifySailViewController   class]]) {
//                [self.navigationController popToViewController:controller animated:YES];
//            }
//        }
//    }
}
- (void)initUI{
    UILabel *label = [[UILabel alloc]init];
    label.text = [NSString stringWithFormat:@"原绑定银行卡 %@(%@)",_BankName,_BankCard];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = colorWithRGB(0.95, 0.6, 0.11);
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self.view.mas_top).offset(5);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(20);
    }];
    
    NewPassWordView = [[CustomView alloc]init];
    NewPassWordView.NameLabel.text = @"新银行卡号:";
    NewPassWordView.NameTextField.placeholder = @"请输入持卡人银行卡号";
    NewPassWordView.NameTextField.delegate = self;
    [self.view addSubview:NewPassWordView];

    [NewPassWordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self.view.mas_top).offset(35);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(40);
    }];
    CardBankView = [[CustomChooseView alloc]init];
    CardBankView.NameLabel.text = @"选择银行:";
    CardBankView.ChooseLabel.userInteractionEnabled = YES;
    CardBankView.ChooseLabel.text = @"选择银行";
    UITapGestureRecognizer *ChooseTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseTapClick)];
    [CardBankView.ChooseLabel addGestureRecognizer:ChooseTap];
    
    
    [self.view addSubview:CardBankView];
    [CardBankView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(NewPassWordView.mas_bottom).offset(15);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(40);
    }];

    SurePassWordView = [[CustomView alloc]init];
    SurePassWordView.NameLabel.text = @"开户银行:";
    SurePassWordView.NameTextField.placeholder = @"请输入开户银行支行名称";
    SurePassWordView.NameTextField.delegate = self;
    [self.view addSubview:SurePassWordView];
 
    [SurePassWordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(CardBankView.mas_bottom).offset(15);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(40);
    }];

    
    
    phoneNumView = [[CustomView alloc]init];
    phoneNumView.NameLabel.text = @"手机号码:";
    phoneNumView.NameTextField.placeholder = @"请输入持卡人银行预留手机号";
    phoneNumView.NameTextField.delegate = self;
    phoneNumView.NameTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:phoneNumView];
    [phoneNumView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(SurePassWordView.mas_bottom).offset(15);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(40);
    }];
    
    CodeNumView = [[CustomView alloc]init];
    CodeNumView.NameLabel.text = @"短信验证码:";
    CodeNumView.NameTextField.placeholder = @"请输入短信验证码";
    CodeNumView.NameTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    CodeNumView.NameTextField.delegate = self;
    [CodeNumView.NameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(90);
    }];
    [CodeNumView.NameTextField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(CodeNumView.mas_right).offset(-80);
    }];
    [self.view addSubview:CodeNumView];
    [CodeNumView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(phoneNumView.mas_bottom).offset(15);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(40);
    }];
    
    ClickBtn = [[UIButton alloc]init];
    [ClickBtn setBackgroundImage:[UIImage imageNamed:@"uncheck"] forState:UIControlStateNormal];
    ClickBtn.selected = NO;
    [ClickBtn setBackgroundImage:[UIImage imageNamed:@"check"] forState:UIControlStateSelected];
    [ClickBtn addTarget:self action:@selector(SaleclickedChange:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ClickBtn];
    [ClickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.top.mas_equalTo(CodeNumView.mas_bottom).offset(10);
        make.width.mas_equalTo(18);
        make.height.mas_equalTo(18);
    }];
    UILabel *nameLabel =[[UILabel alloc]init];
    nameLabel.font = [UIFont systemFontOfSize:13];
    nameLabel.text = @"我同意服务协议";
    nameLabel.textColor =colorWithRGB(0.95, 0.6, 0.11);
//    NSMutableAttributedString *ConnectStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"我同意服务协议"]];
//    NSRange conectRange = {4,9};
//    [ConnectStr addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:conectRange];
//    nameLabel.attributedText = ConnectStr;
    nameLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *gesTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(saleConnectClick)];
    [nameLabel addGestureRecognizer:gesTap];
    [self.view addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ClickBtn.mas_right).offset(10);
        make.top.mas_equalTo(CodeNumView.mas_bottom).offset(5);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(30);
    }];
    _GetCode = [[UIButton alloc] init];
     [_GetCode fireWithTime:0 title:@"获取" countDownTitle:@"秒" mainBGColor:colorWithRGB(0.95, 0.6, 0.11) countBGColor:colorWithRGB(0.95, 0.6, 0.11) mainTextColor:[UIColor whiteColor] countTextColor:[UIColor whiteColor]];
    _GetCode.titleLabel.font = [UIFont systemFontOfSize:16];
    [_GetCode setBackgroundColor:colorWithRGB(0.95, 0.6, 0.11)];
    [_GetCode setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_GetCode addTarget:self action:@selector(forgetSenderCodeBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [CodeNumView addSubview:_GetCode];
    [_GetCode mas_makeConstraints:^(MASConstraintMaker* make) {
        make.top.mas_equalTo(CodeNumView.mas_top);
        make.right.mas_equalTo(self.view.mas_right);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(40);
    }];
    
    
    UIButton * PushBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [PushBtn setTitle:@"提交" forState:UIControlStateNormal];
    PushBtn.layer.masksToBounds = YES;
    PushBtn.layer.cornerRadius = 22;
    PushBtn.backgroundColor = colorWithRGB(0.95, 0.6, 0.11);
    [PushBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    PushBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [PushBtn addTarget:self action:@selector(PostBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:PushBtn];
    [PushBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.top.mas_equalTo(nameLabel.mas_bottom).offset(15);
        make.height.mas_equalTo(44);
    }];
}
- (void)SaleclickedChange:(UIButton *)btn{
    if (btn.selected) {
        btn.selected = NO;
    }else{
        btn.selected = YES;
    }
}
- (void)saleConnectClick{
    BundProfileViewController *vc= [[BundProfileViewController alloc]init];
    vc.TitleStr = @"米粒儿金融投资咨询与管理服务协议(出借人)";
    NSString *urlStr =  [NSString stringWithFormat:@"%@/agreement/registration.html",HOST_URL];
    vc.WebStr = urlStr;
    [self.navigationController pushViewController:vc animated:NO];
}
- (void)chooseTapClick{
    [self HideKeyBoardClick];
     [self showAlert];
//    ZHPickView *pickView = [[ZHPickView alloc] init];
//    [pickView setDataViewWithItem:BankArray title:@"选择银行"];
//    [pickView showPickView:self];
//
//    pickView.block = ^(NSString *selectedStr)
//    {
//        CardBankView.ChooseLabel.text = selectedStr;
//        bankStr = [NSString stringWithFormat:@"%@",selectedStr];
//    };
}

- (void)showAlert{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 280)];
    view.backgroundColor=[UIColor whiteColor];
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 5.0f;
    view.alpha = 0.9;
    
    UIImageView*  CancelImageView = [[UIImageView alloc]init];
    CancelImageView.image = [UIImage imageNamed:@"close"];
    CancelImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *CancelTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(CancelClick)];
    [CancelImageView addGestureRecognizer:CancelTap];
    CancelImageView.frame = CGRectMake(SCREEN_WIDTH - 30, 10, 20, 20);
    [view addSubview:CancelImageView];
    
    
    StageTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH,230) style:UITableViewStylePlain];
    StageTableView.delegate = self;
    StageTableView.dataSource = self;
    StageTableView.tableFooterView = [UIView new];
    StageTableView.backgroundColor = [UIColor whiteColor];
    [view addSubview:StageTableView];
    
    
    UILabel *label = [[UILabel alloc]init];
    label.frame = CGRectMake(20, 10, 80, 20);
    label.text = @"选择银行卡";
    label.font = [UIFont systemFontOfSize:15];
    [view addSubview:label];
    
    alertView=[[AwAlertView alloc]initWithContentView:view];
    alertView.isUseHidden=NO;
    [alertView showAnimated:YES];
}
- (void)CancelClick{
    [alertView dismissAnimated:YES];
}
//设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  stageArray.count;
}


//组头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
//cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"ChoseStageMyidentifier";
    
    ChoseBankTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[ChoseBankTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
         [cell configUI:indexPath];
    }
    if (stageArray.count) {
        ChoseModel *model  = [stageArray objectAtIndex:indexPath.row];
        cell.ChoseModel = model;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ChoseModel *model = [stageArray objectAtIndex:indexPath.row];
    CardBankView.ChooseLabel.text = [NSString stringWithFormat:@"%@",model.name];
    BankID =[NSString stringWithFormat:@"%@",model.oid];
    [alertView dismissAnimated:NO];
    
    
}

#pragma mark - 提交 -
- (void)PostBtnClick{
    if ([NewPassWordView.NameTextField.text integerValue]) {
        if (SurePassWordView.NameTextField.text.length) {
            if ([CodeNumView.NameTextField.text integerValue]) {
                if (ClickBtn.selected) {
                    [self postForgetCode];

                }else{
                   normal_alert(@"提示", @"请同意协议", @"确定");
                }
            }else{
               
            }
        }else{
            normal_alert(@"提示", @"开户银行不可为空", @"确定");
        }
    }else{
        normal_alert(@"提示", @"银行卡号不可为空", @"确定");
    }
   
//    if (phoneNumView.NameTextField.text.length) {
//        if (CodeNumView.NameTextField.text.length) {
//            if (NewPassWordView.NameTextField.text.length) {
//                if (SurePassWordView.NameTextField.text.length) {
//                    if (NewPassWordView.NameTextField.text.length < 6) {
//                        normal_alert(@"提示", @"密码不得小于6位", @"确定");
//
//                    }else{
//                        if (SurePassWordView.NameTextField.text == NewPassWordView.NameTextField.text) {
//
//                        }else{
//                            normal_alert(@"提示", @"二次密码不一致请重新输入", @"确定");
//
//                        }
//                    }
//                }else{
//                    normal_alert(@"提示", @"确认新密码不可为空", @"确定");
//
//                }
//            }else{
//                normal_alert(@"提示", @"新登录密码不可为空", @"确定");
//
//            }
//        }else{
//            normal_alert(@"提示", @"短信验证码不可为空", @"确定");
//
//        }
//    }else{
//        normal_alert(@"提示", @"手机号码不可为空", @"确定");
//    }
}

- (void)postForgetCode{
    [self showProgress];
   NSString *userID = NSuserUse(@"userId");
//    //银行获取信息
//    int j  = 0;
//    for (int i = 0; i < BankArray.count; i++) {
//        NSString *str = [BankArray objectAtIndex:i];
//        if ([str isEqualToString:bankStr]) {
//            j = i;
//        }
//    }
//    NSInteger bankI = 0;
//    for (int i = 0; i < BankIDArray.count; i++) {
//        if (i  == j) {
//            bankI = [[BankIDArray objectAtIndex:i]integerValue];
//        }
//    }
    NSString *tokenID = NSuserUse(@"Authorization");
//    NSString *bankID = [NSString stringWithFormat:@"%ld",(long)bankI];
    NSMutableDictionary * YWDDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:phoneNumView.NameTextField.text,@"phoneNumber",CodeNumView.NameTextField.text,@"code",userID,@"userId",BankID,@"bankId",SurePassWordView.NameTextField.text,@"branchBank",NewPassWordView.NameTextField.text,@"bankCardNumber",OrderID,@"orderNo", nil];
    NSString *url = [NSString stringWithFormat:@"%@/bankCards/%@/validateBank",HOST_URL,userID];

    [[DateSource sharedInstance]requestHomeWithParameters:YWDDic withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
       // NSLog(@"re == %@",result);
        if ([[result objectForKey:@"statusCode"]integerValue] == 200) {
            
            normal_alert(@"提示", @"绑定成功", @"确定");
            [self HideProgress];
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                for (UIViewController *controller in self.navigationController.viewControllers) {
                                    if ([controller isKindOfClass:[UserSetViewController class]]) {
                                        [self.navigationController popToViewController:controller animated:YES];
                                    }
                                }
            
                            });
//            for (UIViewController *controller in self.navigationController.viewControllers) {
//                if ([controller isKindOfClass:[UserSetViewController class]]) {
//                    [self.navigationController popToViewController:controller animated:YES];
//                }
//            }
//            for (UIViewController *controller in self.navigationController.viewControllers) {
//                if ([controller isKindOfClass:[TouUpViewController class]]) {
//                    [self.navigationController popToViewController:controller animated:YES];
//                }
//            }
   
            
        }else{
          [self HideProgress];
            NSString *message = [result objectForKey:@"message"];
            normal_alert(@"提示", message, @"确定　");
        }
        //        //注册成功or失败
        //        [self dismissViewControllerAnimated:NO completion:nil];
        
    }];
    
    
    
}


- (void)forgetSenderCodeBtnClicked{
//    if (phoneNumView.NameTextField.text.length) {
//
//    }else{
//        normal_alert(@"提示", @"手机号码不可为空", @"确定");
//    }
     [self codeGet];
}



- (void)codeGet{
    
    NSString *phoneRegex = @"^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    BOOL isMatch  = [phoneTest evaluateWithObject:phoneNumView.NameTextField.text];
    if (!isMatch) {
        normal_alert(@"提示", @"请输入正确的手机号", @"确定");
        
    }else{
        //银行获取信息
        int j  = 0;
        for (int i = 0; i < BankArray.count; i++) {
            NSString *str = [BankArray objectAtIndex:i];
            if ([str isEqualToString:bankStr]) {
                j = i;
            }
        }
        NSInteger bankI = 0;
        for (int i = 0; i < BankIDArray.count; i++) {
            if (i  == j) {
                bankI = [[BankIDArray objectAtIndex:i]integerValue];
            }
        }
        NSString *bankID = [NSString stringWithFormat:@"%ld",(long)bankI];

        NSString *userID = NSuserUse(@"userId");
        NSString *tokenID = NSuserUse(@"Authorization");
        NSString *url = [NSString stringWithFormat:@"%@/bankCards/%@/unbundling",HOST_URL,userID];
        //NSString *tokenID = NSuserUse(@"Authorization");
        _second = 90;
     
        NSMutableDictionary * YWDDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:phoneNumView.NameTextField.text ,@"phoneNumber",userID,@"userId",bankID,@"bankId",SurePassWordView.NameTextField.text,@"branchBank",NewPassWordView.NameTextField.text,@"bankCardNumber",nil];
        //验证码获取陈功or失败
        [[DateSource sharedInstance]requestHomeWithParameters:YWDDic withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
          //  NSLog(@"re == %@",result);
               [_GetCode fireWithTime:60 title:@"获取" countDownTitle:@"秒" mainBGColor:colorWithRGB(0.95, 0.6, 0.11) countBGColor:colorWithRGB(0.95, 0.6, 0.11) mainTextColor:[UIColor whiteColor] countTextColor:[UIColor whiteColor]];
            if ([[result objectForKey:@"statusCode"]integerValue]==200 ) {
                OrderID = [[result objectForKey:@"data"]objectForKey:@"orderNo"];
                normal_alert(@"提示", @"验证码已发送", @"确定");
                   [_GetCode fireWithTime:60 title:@"获取" countDownTitle:@"秒" mainBGColor:colorWithRGB(0.95, 0.6, 0.11) countBGColor:colorWithRGB(0.95, 0.6, 0.11) mainTextColor:[UIColor whiteColor] countTextColor:[UIColor whiteColor]];
            }else{
                NSString *ErrorMessage = [result objectForKey:@"message"];
                normal_alert(@"提示", ErrorMessage, @"确定");
                
            }
            
        }];
        
        
        
        
    }
    
}
#pragma mark  - - 验证码倒计时 - -
- (void)timing
{
    if (_second > 0) {
        _second--; // 时间递减
        NSString* title = [NSString stringWithFormat:@"%dS", _second];
        dispatch_async(dispatch_get_main_queue(), ^{
            _GetCode.enabled = NO;
            [_GetCode setTitle:title forState:UIControlStateDisabled];
        });
        
        
        
    }
    else if (_second == 0) {
        [_securityCodeTimer invalidate];
        dispatch_async(dispatch_get_main_queue(), ^{
            _GetCode.enabled = YES;
            [_GetCode setTitle:@"重新发送" forState:UIControlStateNormal];
        });
        
        
    }
}

- (void)ReginAndLoginBackClick{
    [self.navigationController popToRootViewControllerAnimated:NO];
}


- (void)ForgetPassClickBag{
    [self HideKeyBoardClick];
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

- (void)CallBackClick{
    
    if ([_TypeStr integerValue]== 1) {
        //  返回指定页面
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[TouUpViewController class]]) {
                [self.navigationController popToViewController:controller animated:YES];
            }
        }
    }
    
    
}
- (void)HideProgress{
    [hud hideAnimated:YES];
}
- (void)showProgress{
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
    
    // Set the label text.
    
    hud.label.text = NSLocalizedString(@"正在请求中", @"HUD loading title");
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
