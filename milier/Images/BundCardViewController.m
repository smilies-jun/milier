//
//  BundCardViewController.m
//  milier
//
//  Created by amin on 17/4/19.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "BundCardViewController.h"
#import "SaleViewController.h"
#import "CustomView.h"
#import "CustomChooseView.h"
#import "ZHPickView.h"
#import "LLPayUtil.h"
#import "LLOrder.h"
#import "UserSetViewController.h"
#import "MyLeftViewController.h"
#import "BundProfileViewController.h"
#import "SaleViewController.h"
#import "MoneyViewController.h"
#import <AwAlertViewlib/AwAlertViewlib.h>
#import "ChoseBankTableViewCell.h"
#import <AwAlertViewlib/AwAlertViewlib.h>
#import "ChoseModel.h"

/*! TODO: 修改两个参数成商户自己的配置 */
static NSString *kLLOidPartner = @"201707271001909517";//@"201408071000001546";                 // 商户号
static NSString *kLLPartnerKey = @"szqhMLE2016Md5";//@"201408071000001546_test_20140815";   // 密钥
static NSString *signType = @"MD5"; //签名方式

/*! 接入什么支付产品就改成那个支付产品的LLPayType，如快捷支付就是LLPayTypeQuick */

static LLPayType payType = LLPayTypeVerify;




@interface BundCardViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>{
    UIScrollView *BackView;
    
    UILabel *MoneyLabel;
    
    CustomView *MoneyView;
    
    CustomView *CardNameView;
    
    CustomView *CardNumberView;

    CustomView *CardIphoneView;

    CustomChooseView *CardBankView;

    CustomView *CardWhichBankView;

    CustomView *CardBankCodeView;

    UILabel *ExlainLabel;
    NSArray *proTimeList;
    NSMutableArray *BankArray;
    NSMutableArray *BankIDArray;
    NSString *bankStr;
    UIButton *ClickBtn;
    
    NSString *orderStr;
    NSString *createTimeStr;
    NSString *reginStr;
    NSString *bankOid;
    MBProgressHUD *hud;
    int statusType;
    UITableView *StageTableView;

    NSMutableArray *stageArray;
    
    NSString *BankID;
    AwAlertView *alertView;
}

@property (nonatomic, strong) LLOrder *order;
@property (nonatomic, retain) NSMutableDictionary *orderDic;




@end

@implementation BundCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"绑定银行卡并充值";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor blackColor]}];

    self.view.backgroundColor = colorWithRGB(0.97, 0.97, 0.97);
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(0, 0, 44, 44);
    [leftBtn setImage:[UIImage imageNamed:@"backarrow"] forState:UIControlStateNormal];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0,0,0,8 *SCREEN_WIDTH/375.0)];
    [leftBtn addTarget:self action:@selector(BundBackClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *BagTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(BagClcik)];
    [self.view addGestureRecognizer:BagTap];
    BankArray = [[NSMutableArray alloc]init];
    BankIDArray = [[NSMutableArray alloc]init];
    stageArray = [[NSMutableArray alloc]init];

    [self getBankCards];
    
    statusType = 0;
   
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
        [self ConfigUI];
    }];
}
- (void)BagClcik{
    [self HideKeyBoardClick];
}
- (void)ConfigUI{
    BackView = [[UIScrollView alloc]init];
    BackView.delegate = self;
    BackView.contentSize = CGSizeMake(0, SCREEN_HEIGHT + 100);
    BackView.backgroundColor = colorWithRGB(0.97, 0.97, 0.97);
    BackView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.view addSubview:BackView];
    
    MoneyView = [[CustomView alloc]init];
    MoneyView.NameLabel.text = @"充值金额:";
    MoneyView.NameTextField.placeholder = @"请输入充值金额";
    MoneyView.NameTextField.text = @"1";
    MoneyView.NameTextField.delegate = self;
    MoneyView.NameTextField.keyboardType = UIKeyboardTypeNumberPad;
    [BackView addSubview:MoneyView];
    [MoneyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(BackView.mas_left).offset(20);
        make.top.mas_equalTo(BackView.mas_top).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH - 40);
        make.height.mas_equalTo(40);
    }];
    
    CardNameView = [[CustomView alloc]init];
    CardNameView.NameLabel.text = @"持卡人姓名:";
    CardNameView.NameTextField.placeholder = @"请输入持卡人姓名";
    CardNameView.NameTextField.delegate = self;
    [BackView addSubview:CardNameView];
    [CardNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(BackView.mas_left).offset(20);
        make.top.mas_equalTo(MoneyView.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH - 40);
        make.height.mas_equalTo(40);
    }];
    
    CardNumberView = [[CustomView alloc]init];
    CardNumberView.NameLabel.text = @"身份证号:";
    CardNumberView.NameTextField.placeholder = @"身份证号";
    CardNumberView.NameTextField.delegate = self;
    [BackView addSubview:CardNumberView];
    [CardNumberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(BackView.mas_left).offset(20);
        make.top.mas_equalTo(CardNameView.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH - 40);
        make.height.mas_equalTo(40);
    }];
    
    CardIphoneView = [[CustomView alloc]init];
    CardIphoneView.NameLabel.text = @"手机号码:";
    CardIphoneView.NameTextField.placeholder = @"请输入持卡人银行预留手机号";
    CardIphoneView.NameTextField.delegate = self;
    CardIphoneView.NameTextField.keyboardType = UIKeyboardTypeNumberPad;
    [BackView addSubview:CardIphoneView];
    [CardIphoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(BackView.mas_left).offset(20);
        make.top.mas_equalTo(CardNumberView.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH - 40);
        make.height.mas_equalTo(40);
    }];
    
    CardBankView = [[CustomChooseView alloc]init];
    CardBankView.NameLabel.text = @"选择银行:";
    CardBankView.ChooseLabel.text = @"选择银行";
    CardBankView.ChooseLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *ChooseTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseTapClick)];
    [CardBankView.ChooseLabel addGestureRecognizer:ChooseTap];
    
    
    [BackView addSubview:CardBankView];
    [CardBankView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(BackView.mas_left).offset(20);
        make.top.mas_equalTo(CardIphoneView.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH - 40);
        make.height.mas_equalTo(40);
    }];
    
    
    CardWhichBankView = [[CustomView alloc]init];
    CardWhichBankView.NameLabel.text = @"开户银行:";
    CardWhichBankView.NameTextField.placeholder = @"请输入银行支行名称";
    CardWhichBankView.NameTextField.delegate = self;
    [BackView addSubview:CardWhichBankView];
    [CardWhichBankView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(BackView.mas_left).offset(20);
        make.top.mas_equalTo(CardBankView.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH - 40);
        make.height.mas_equalTo(40);
    }];
    CardBankCodeView = [[CustomView alloc]init];
    CardBankCodeView.NameLabel.text = @"银行卡号:";
    CardBankCodeView.NameTextField.placeholder = @"请输入持卡人银行卡号";
    CardBankCodeView.NameTextField.delegate = self;
    CardBankCodeView.NameTextField.keyboardType = UIKeyboardTypeNumberPad;
    [BackView addSubview:CardBankCodeView];
    [CardBankCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(BackView.mas_left).offset(20);
        make.top.mas_equalTo(CardWhichBankView.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH - 40);
        make.height.mas_equalTo(40);
    }];
    ExlainLabel = [[UILabel alloc]init];
    ExlainLabel.text = @"绑定银行卡用于提现以及充值。";
    ExlainLabel.textAlignment = NSTextAlignmentLeft;
    ExlainLabel.textColor = [UIColor orangeColor];
    ExlainLabel.font = [UIFont systemFontOfSize:12];
    [BackView addSubview:ExlainLabel];
    [ExlainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(BackView.mas_left).offset(30);
        make.top.mas_equalTo(CardBankCodeView.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH - 60);
        make.height.mas_equalTo(20);
    }];
    ClickBtn = [[UIButton alloc]init];
    [ClickBtn setBackgroundImage:[UIImage imageNamed:@"uncheck"] forState:UIControlStateNormal];
    ClickBtn.selected = YES;
    [ClickBtn setBackgroundImage:[UIImage imageNamed:@"check"] forState:UIControlStateSelected];
    [ClickBtn addTarget:self action:@selector(Saleclicked:) forControlEvents:UIControlEventTouchUpInside];
    [BackView addSubview:ClickBtn];
    [ClickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.top.mas_equalTo(ExlainLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(18);
        make.height.mas_equalTo(18);
    }];
    UILabel *nameLabel =[[UILabel alloc]init];
    nameLabel.font = [UIFont systemFontOfSize:14];
    nameLabel.text = @"我同意《绑定及解绑服务协议》";
    NSMutableAttributedString *ConnectStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"我同意《绑定及解绑服务协议》"]];
    NSRange conectRange = {4,9};
    [ConnectStr addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:conectRange];
    nameLabel.attributedText = ConnectStr;
    nameLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *gesTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(saleConnectClick)];
    [nameLabel addGestureRecognizer:gesTap];
    [BackView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ClickBtn.mas_right).offset(10);
        make.top.mas_equalTo(ExlainLabel.mas_bottom).offset(5);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(30);
    }];


    
    UILabel *SaleLbel =  [[UILabel alloc]init];
    SaleLbel.text = @"确定";
    SaleLbel.userInteractionEnabled = YES;
    SaleLbel.backgroundColor = colorWithRGB(0.95, 0.60, 0.11);
    SaleLbel.textAlignment = NSTextAlignmentCenter;
    SaleLbel.textColor = [UIColor whiteColor];
    SaleLbel.layer.cornerRadius = 10;
    SaleLbel.layer.masksToBounds = YES;
    [BackView addSubview:SaleLbel];
    [SaleLbel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(BackView.mas_left).offset(20);
        make.top.mas_equalTo(nameLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH - 40);
        make.height.mas_equalTo(40);
    }];
    
    UITapGestureRecognizer *SaleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(BundBtnClick
                                                                                                          )];
    [SaleLbel addGestureRecognizer:SaleTap];
    
}
- (void)HideProgress{
    [hud hideAnimated:YES];
}
- (void)showProgress{
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    // Set the label text.
    
    hud.label.text = NSLocalizedString(@"正在请求中", @"HUD loading title");
}
- (void)saleConnectClick{
    //协议
    BundProfileViewController *vc= [[BundProfileViewController alloc]init];
    vc.TitleStr = @"米粒儿金融银行卡绑定及解绑服务协议";
    vc.WebStr = [NSString stringWithFormat:@"%@/agreement/bank-card.html",HOST_URL];
    [self.navigationController pushViewController:vc animated:NO];
}
- (void)Saleclicked:(UIButton *)btn{
    if (btn.selected) {
        btn.selected = NO;
    }else{
        btn.selected = YES;
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self HideKeyBoardClick];
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
    bankStr= [NSString stringWithFormat:@"%@",model.name];
    [alertView dismissAnimated:NO];
    
    
}


- (void)AgreeClick{
    
}
#pragma 正则匹配用户身份证号14或17位
- (BOOL)checkUserIdCard: (NSString *) idCard
{
    BOOL flag;
    
    if (idCard.length <= 0) {
        
        flag = NO;
        
        return flag;
        
    }
    
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    
    return [identityCardPredicate evaluateWithObject:idCard];
    
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
#pragma 正则匹配银行卡号

//身份证号
- (BOOL) validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}
- (BOOL) checkCardNo:(NSString*) cardNo{
    int oddsum = 0;     //奇数求和
    int evensum = 0;    //偶数求和
    int allsum = 0;
    int cardNoLength = (int)[cardNo length];
    int lastNum = [[cardNo substringFromIndex:cardNoLength-1] intValue];
    
    cardNo = [cardNo substringToIndex:cardNoLength - 1];
    for (int i = cardNoLength -1 ; i>=1;i--) {
        NSString *tmpString = [cardNo substringWithRange:NSMakeRange(i-1, 1)];
        int tmpVal = [tmpString intValue];
        if (cardNoLength % 2 ==1 ) {
            if((i % 2) == 0){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }else{
            if((i % 2) == 1){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }
    }
    
    allsum = oddsum + evensum;
    allsum += lastNum;
    if((allsum % 10) == 0)
        return YES;
    else
        return NO;
}
//银行卡验证
-(BOOL)validateBankCard:(NSString *)card{
    
    if (card.length==0) {
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
//                                                            message:@"银行卡不能为空"
//                                                           delegate:nil
//                                                  cancelButtonTitle:@"确定"
//                                                  otherButtonTitles:nil, nil];
        return NO;
    }
    NSString *bankNameregex = @"^[\u4e00-\u9fa5]{0,}$";
    NSPredicate *bankNamepredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", bankNameregex];
    BOOL isbankName = [bankNamepredicate evaluateWithObject:card];
    
    if (!isbankName) {
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
//                                                            message:@"银行卡格式不对"
//                                                           delegate:nil
//                                                  cancelButtonTitle:@"确定"
//                                                  otherButtonTitles:nil, nil];
//        [alertView show];
        return NO;
    }
    
    return YES;


}
- (void)BundBtnClick{
    [self HideKeyBoardClick];
    if ([MoneyView.NameTextField.text integerValue] >= 1) {
        if (CardNameView.NameTextField.text.length) {
            
//            if ([self checkTelNumber:CardIphoneView.NameTextField.text]) {
            
                if ([self validateIdentityCard:CardNumberView.NameTextField.text]) {
                    
                    if ([self checkCardNo:CardBankCodeView.NameTextField.text]) {
                        
                        
                        if (CardWhichBankView.NameTextField.text.length) {
                            
                            if (bankStr.length) {
                                    [self payMoney];
                                
                            }else{
                                normal_alert(@"提示", @"请选择银行", @"确定");

                            }
                            
                            
                        }else{
                            normal_alert(@"提示", @"开户银行不可为空", @"确定");
                            
                        }
                        
                    }else{
                        normal_alert(@"提示", @"银行卡号不正确", @"确定");
                        
                    }
                    
                    
                    
                }else{
                    normal_alert(@"提示", @"身份证号码不正确", @"确定");
                    
                }
                
                
                
//            }else{
//                normal_alert(@"提示", @"手机号码格式不正确", @"确定");
//                
//            }
            
        
        }else{
            normal_alert(@"提示", @"姓名不能为空", @"确定");
            
        }
    }else{
        normal_alert(@"提示", @"充值金额要大于等于1元", @"确定");
    }
   
    

}

- (void)postBankCard{
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
    
    NSString *url;
    NSString *userID = NSuserUse(@"userId");
    NSString *tokenID = NSuserUse(@"Authorization");
    //NSString *bankID = [NSString stringWithFormat:@"%ld",(long)bankI];
    url = [NSString stringWithFormat:@"%@/bankCards",HOST_URL];
    
    NSMutableDictionary  *dic = [[NSMutableDictionary alloc]initWithObjectsAndKeys:CardNameView.NameTextField.text,@"username",CardIphoneView.NameTextField.text,@"phoneNumber",CardNumberView.NameTextField.text,@"identityCardNumber",CardBankCodeView.NameTextField.text,@"bankCardNumber",userID,@"userId",BankID,@"bankId",CardWhichBankView.NameTextField.text,@"branchBank", nil];

   [[DateSource sharedInstance]requestHomeWithParameters:dic withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
       NSString *statuesCode = [result objectForKey:@"statusCode"];
       if ([statuesCode integerValue] == 201) {
           bankOid = [NSString stringWithFormat:@"%@",[[result objectForKey:@"data"]objectForKey:@"oid"]];
           [self payMoney];
       }else{
           statusType = 1;
           NSString *mesage = [result objectForKey:@"message"];
           normal_alert(@"提示", mesage, @"确定");
       }
       
       
   }];

    

}

- (void)payMoney{
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
    NSString *url;
    NSString *tokenID = NSuserUse(@"Authorization");
    //NSString *bankID = [NSString stringWithFormat:@"%ld",(long)bankI];
    url = [NSString stringWithFormat:@"%@/dealOrders",HOST_URL];
    
    NSMutableDictionary  *dic = [[NSMutableDictionary alloc]initWithObjectsAndKeys:MoneyView.NameTextField.text,@"amount",@"3",@"type",CardNameView.NameTextField.text,@"username",CardIphoneView.NameTextField.text,@"phoneNumber",CardNumberView.NameTextField.text,@"identityCardNumber",CardBankCodeView.NameTextField.text,@"bankCardNumber",BankID,@"bankId",CardWhichBankView.NameTextField.text,@"branchBank", nil];
    
    [[DateSource sharedInstance]requestHomeWithParameters:dic withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
        
        NSString *statuesCode = [result objectForKey:@"statusCode"];
        
        if ([statuesCode integerValue] == 201) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
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
            statusType =1;
            NSString *mesage = [result objectForKey:@"message"];
            normal_alert(@"提示", mesage, @"确定");
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
            msg = @"绑卡成功";
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                normal_alert(@"提示", msg, @"确定");
                [self BundBackClick];
            });

            //[self.navigationController popToRootViewControllerAnimated:NO];
        } break;
        case kLLPayResultFail: {
            statusType =1;
            msg = @"失败";
            [self HideProgress];
            normal_alert(@"提示", msg, @"确定");
        } break;
        case kLLPayResultCancel: {
            [self HideProgress];
            statusType =1;
            msg = @"取消";

        } break;
        case kLLPayResultInitError: {
            [self HideProgress];

            statusType = 1;
            msg = @"sdk初始化异常";
        } break;
        case kLLPayResultInitParamError: {
            statusType =1;
            [self HideProgress];

            msg = dic[@"ret_msg"];
        } break;
        default:
            break;
    }
    
    
    
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
    _order.money_order = MoneyView.NameTextField.text;
    //_order.notify_url = @"http://139.224.139.178:7000/sunpay-rest/v1/pay_mallpay_result_notify/029";//TEST
   _order.notify_url = @"http://139.224.95.121:8888/sunpay-rest/v1/pay_mallpay_result_notify/029";//正式
    _order.acct_name = CardNameView.NameTextField.text;
    _order.name_goods = @"充值";
    _order.card_no =[NSString stringWithFormat:@"%@",CardBankCodeView.NameTextField.text] ;
    _order.id_no =[NSString stringWithFormat:@"%@", CardNumberView.NameTextField.text];
    _order.risk_item = [LLOrder llJsonStringOfObj:@{@"user_info_dt_register" : reginStr,@"frms_ware_category":@"2009",@"user_info_mercht_userno":userID,@"user_info_bind_phone":phoneStr,@"user_info_identify_state":@"1",@"user_info_identify_type":@"1",@"user_info_full_name":CardNameView.NameTextField.text,@"user_info_id_no":[NSString stringWithFormat:@"%@", CardNumberView.NameTextField.text]}];
    _order.user_id = userID;
    
}
- (void)BundBackClick{
    //  返回指定页面
    
    if([_MoneyType integerValue] == 3){
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[UserSetViewController class]]) {
                [self.navigationController popToViewController:controller animated:YES];
            }
        }
    }else if ([_MoneyType integerValue] == 1){
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[MyLeftViewController class]]) {
                [self.navigationController popToViewController:controller animated:YES];
            }
        }
    }
    
    
    else{
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[SaleViewController class]]) {
                [self.navigationController popToViewController:controller animated:YES];
            }
        }
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[MoneyViewController class]]) {
                [self.navigationController popToViewController:controller animated:YES];
            }
        }
        
    }
    
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
