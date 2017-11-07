//
//  SaleViewController.m
//  milier
//
//  Created by amin on 17/4/19.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "SaleViewController.h"
#import "YWDLoginViewController.h"
#import "SalePassWordViewController.h"
#import "PayViewController.h"
#import "TouUpViewController.h"
#import "ProductDetailNewViewController.h"
#import <AwAlertViewlib/AwAlertViewlib.h>
#import "ChoiceStageTableViewCell.h"
#import "ChooseStageModel.h"
#import "BundCardViewController.h"
#import "TouUpViewController.h"
#import "BundProfileViewController.h"
#import "RiskViewController.h"
#import "MSNumberScrollAnimatedView.h"




@interface SaleViewController ()<UITableViewDelegate,UITableViewDelegate,UITextFieldDelegate,MBProgressHUDDelegate>{
    
    UIView *TopView;
    UIView *BootmView;
    
    UILabel *TitleLabel;
    UILabel *MoneyPercentLabel;
    UILabel *AddMoneyLabel;
    
    UILabel *LeftLabel;
    UILabel *MoneyLeftLbel;
    UILabel *ExplainLabel;
    
    UIView *ChoceStageView;
    UIView *SaleView;
    UIView *InterestView;
    UILabel *InterestMoneyLabel;//选择道具

    UIView *PassWordView;

    
    
    UILabel *TotalMoneyLabel;
    UILabel *AgreementLabel;
    
    UILabel *SaleLabel;//选择道具
    NSString *StageOid;
    NSString *BankID;
    UILabel *interestLabel;
    UILabel *StageLabel;
    
    AwAlertView *alertView;
    AwAlertView *RiskAlertView;
    AwAlertView *SureAlertView;
    UITableView *StageTableView;
    NSString *AddStr;
    UIButton *ClickBtn;
    UILabel *percentLabel;
    UITextField *BuyTextField;
    NSString *MyMoneyStr;//余额
    NSString *BankStatus;//绑卡
    NSString *PassWordStr;//交易密码
    UITextField *PassWordTextField;
    NSString *state;
    NSString *increase_type;
    NSString *percent;
    
    NSString *userRiskStr;
    NSMutableArray *stageArray;
    UIButton *RiskClickBtn;
    MSNumberScrollAnimatedView *numberAnimatedV;
    
    int agreeOrNo;
    int riskOrNo;
    int Type;
    
    NSString *StageChoseStr;
    MBProgressHUD *hud;
}

@end

@implementation SaleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"购买";
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
    
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(0, 7, 18, 18);
    [leftBtn setImage:[UIImage imageNamed:@"backarrow@2x.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(SaleOnTap) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    stageArray = [[NSMutableArray alloc]init];
    agreeOrNo = 0;
    riskOrNo = 0;
    AddStr = @"";
    NSString *PercentUrl = [NSString stringWithFormat:@"%@/activities/isProductAddIncrease",HOST_URL];

    [[DateSource sharedInstance]requestHtml5WithParameters:nil  withUrl:PercentUrl withTokenStr:nil usingBlock:^(NSDictionary *result, NSError *error) {
        state = [result objectForKey:@"state"];
        increase_type = [result objectForKey:@"increase_type"];
        percent = [result objectForKey:@"percent"];
        [self reloadMyMoney];
        [self reloadMyStage];
        [self ConfigUI];
    }];
   
    //[self ConfigInverest];
   
    
    // You can also adjust other label properties if needed.
    
    // hud.label.font = [UIFont italicSystemFontOfSize:16.f];
    
    
    
//    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
//        
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//            [hud hideAnimated:YES];
//            
//        });
//        
//    });
}
- (void)HideProgress{
    [hud hideAnimated:YES];
}
- (void)showProgress{
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
    
    // Set the label text.
    
    hud.label.text = NSLocalizedString(@"正在请求中", @"HUD loading title");
}
- (void)reloadMyMoney{
    NSString *Statisurl;
    NSString *userID = NSuserUse(@"userId");
    NSString *tokenID = NSuserUse(@"Authorization");
    Statisurl = [NSString stringWithFormat:@"%@/%@",USER_URL,userID];
    [[DateSource sharedInstance]requestHtml5WithParameters:nil  withUrl:Statisurl withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
        NSString *statusStr = [result objectForKey:@"statusCode"];

        if ([statusStr integerValue] == 200) {
            MyMoneyStr = [NSString stringWithFormat:@"%@",[[result objectForKey:@"data"]objectForKey:@"assets"]];
            BankStatus = [NSString stringWithFormat:@"%@",[[result objectForKey:@"data"]objectForKey:@"bankCardExist"]];
            PassWordStr = [NSString stringWithFormat:@"%@",[[result objectForKey:@"data"]objectForKey:@"dealPasswordExist"]];
            userRiskStr = [NSString stringWithFormat:@"%@",[[result objectForKey:@"data"]objectForKey:@"riskLevel"]];
             BankID = [NSString stringWithFormat:@"%@",[[result objectForKey:@"data"]objectForKey:@"bankId"]];
            [self ConfigUI];

        }
        
    }];

}
- (void)reloadMyStage{
    NSString *Statisurl;
    NSString *tokenID = NSuserUse(@"Authorization");
    Statisurl = [NSString stringWithFormat:@"%@/products/%@/props",HOST_URL,_productStr];
    [[DateSource sharedInstance]requestHtml5WithParameters:nil  withUrl:Statisurl withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
        NSString *statusStr = [result objectForKey:@"statusCode"];
        if ([statusStr integerValue] == 200) {
         NSArray *MyStageArray = [result objectForKey:@"items"];
            [self ConfigUI];
            for (NSDictionary *NewDic in MyStageArray) {
                ChooseStageModel *model = [[ChooseStageModel alloc]init];
                model.dataDictionary = NewDic;
                [stageArray addObject:model];
            }
            [StageTableView reloadData];
        }
        
    }];

}
- (void)ConfigUI{
    TopView = [[UIView alloc]init];
    TopView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(HideKeyBoardClick)];
    [TopView addGestureRecognizer:tap];
    TopView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:TopView];
    [TopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top);
        make.left.mas_equalTo(self.view.mas_left);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(150);
    }];
    TitleLabel = [[UILabel alloc]init];
    TitleLabel.text = _NameStr;
    TitleLabel.font = [UIFont systemFontOfSize:13];
    TitleLabel.textColor = colorWithRGB(0.67, 0.87, 0.1);
    TitleLabel.textAlignment = NSTextAlignmentCenter;
    [TopView addSubview:TitleLabel];
    [TitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(TopView.mas_centerX);
        make.top.mas_equalTo(TopView.mas_top).offset(20);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(20);
    }];
    
    MoneyPercentLabel = [[UILabel alloc]init];
    MoneyPercentLabel.text = [NSString stringWithFormat:@"%.2f%%",[_PercentStr doubleValue]];
    MoneyPercentLabel.textColor = colorWithRGB(0.67, 0.87, 0.1);
    MoneyPercentLabel.textAlignment = NSTextAlignmentCenter;
    MoneyPercentLabel.font = [UIFont systemFontOfSize:50];
//    NSMutableAttributedString *newAttrStr = [[NSMutableAttributedString alloc] initWithString:@"12.34%"];
//    [newAttrStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:50] range:NSMakeRange(0,MoneyPercentLabel.text.length
//                                                                                                          )];
//    [newAttrStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:20] range:NSMakeRange(MoneyPercentLabel.text.length - 1
//                                                                                                          ,1)];
//    MoneyPercentLabel.attributedText = newAttrStr;
//    MoneyPercentLabel.textAlignment = NSTextAlignmentCenter;
    [TopView addSubview:MoneyPercentLabel];
    [MoneyPercentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(TopView.mas_centerX);
        make.top.mas_equalTo(TitleLabel.mas_bottom).offset(20);
        make.width.mas_equalTo(180);
        make.height.mas_equalTo(40);
    }];
    percentLabel = [[UILabel alloc]init];
    if ([_Percent isEqualToString:@"0"]) {
        percentLabel.hidden = YES;
    }else{
         percentLabel.hidden = NO;
    }
    percentLabel.text =[NSString stringWithFormat:@"+%.2f%%",[percent doubleValue]];
    percentLabel.textColor = colorWithRGB(0.67, 0.87, 0.1);
    percentLabel.textAlignment = NSTextAlignmentLeft;
    [TopView addSubview:percentLabel];
    [percentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MoneyPercentLabel.mas_right);
        make.bottom.mas_equalTo(MoneyPercentLabel.mas_bottom);
        make.width.mas_equalTo(55);
        make.height.mas_equalTo(20);
    }];
    MoneyPercentLabel.font = [UIFont systemFontOfSize:50];
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = colorWithRGB(0.94, 0.94, 0.94);
    [TopView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(TopView.mas_left).offset(10);
        make.top.mas_equalTo(MoneyPercentLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH - 20);
        make.height.mas_equalTo(0.5);
    }];
    
    LeftLabel = [[UILabel alloc]init];
    LeftLabel.text = @"剩余额度";
    LeftLabel.textColor = colorWithRGB(0.27, 0.27, 0.27);
    LeftLabel.font = [UIFont systemFontOfSize:15];
    [TopView addSubview:LeftLabel];
    [LeftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(TopView.mas_left).offset(20);
        make.top.mas_equalTo(lineView.mas_bottom).offset(10);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(20);
    }];
    
    MoneyLeftLbel = [[UILabel alloc]init];
    NSString *totalStr = [NSString stringWithFormat:@"%@",_TotalStr];
    double totalDouble = [totalStr doubleValue];
    NSString *sellStr = [NSString stringWithFormat:@"%@",_SellStr];
    double sellDouble = [sellStr doubleValue];
        MoneyLeftLbel.text = [NSString stringWithFormat:@"%.2f元",totalDouble - sellDouble];
    MoneyLeftLbel.textColor = colorWithRGB(0.67, 0.87, 0.1);
    MoneyLeftLbel.textAlignment = NSTextAlignmentRight;
    MoneyLeftLbel.font = [UIFont systemFontOfSize:15];
    [TopView addSubview:MoneyLeftLbel];
    [MoneyLeftLbel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(TopView.mas_right).offset(-20);
        make.top.mas_equalTo(lineView.mas_bottom).offset(10);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(20);
    }];
    
    BootmView = [[UIView alloc]init];
    BootmView.userInteractionEnabled = YES;
    UITapGestureRecognizer *bottomTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(HideKeyBoardClick)];
    [BootmView addGestureRecognizer:bottomTap];

    BootmView.backgroundColor = colorWithRGB(0.97, 0.97, 0.97);
    [self.view addSubview:BootmView];
    [BootmView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(TopView.mas_bottom);
        make.left.mas_equalTo(self.view.mas_left);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(SCREEN_HEIGHT);
    }];
    
    ExplainLabel = [[UILabel alloc]init];
    ExplainLabel.text = @"注：若支付失败道具将在15分钟内返还";
    ExplainLabel.textColor =  colorWithRGB(0.67, 0.87, 0.1);
    ExplainLabel.textAlignment = NSTextAlignmentCenter;
    ExplainLabel.font = [UIFont systemFontOfSize:11];
    [BootmView addSubview:ExplainLabel];
    [ExplainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(BootmView.mas_centerX);
        make.top.mas_equalTo(BootmView.mas_top).offset(10);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(20);
    }];
    
    
    if ([_productID integerValue] == 6) {
        
       
        SaleView = [[UIView alloc]init];
        SaleView.backgroundColor = [UIColor whiteColor];
        [BootmView addSubview:SaleView];
        [SaleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(BootmView.mas_left);
            make.top.mas_equalTo(ExplainLabel.mas_bottom).offset(10);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(44);
        }];
        UIImageView *BuyImageView = [[UIImageView alloc]init];
        BuyImageView.image = [UIImage imageNamed:@"buy"];
        [SaleView addSubview:BuyImageView];
        [BuyImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(SaleView.mas_centerY);
            make.left.mas_equalTo(SaleView.mas_left).offset(10);
            make.width.mas_equalTo(22);
            make.height.mas_equalTo(22);
        }];
        UILabel *buyLabel = [[UILabel alloc]init];
        buyLabel.text  = @"购买金额";
        buyLabel.textColor= colorWithRGB(0.27, 0.27, 0.27);
        buyLabel.font = [UIFont systemFontOfSize:15];
        [SaleView addSubview:buyLabel];
        [buyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(SaleView.mas_centerY);
            make.left.mas_equalTo(BuyImageView.mas_right).offset(10);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(20);
        }];
        
        BuyTextField = [[UITextField alloc]init];
        BuyTextField.backgroundColor = [UIColor whiteColor];
        BuyTextField.font = [UIFont systemFontOfSize:15];
        BuyTextField.textAlignment = NSTextAlignmentLeft;
        BuyTextField.keyboardType = UIKeyboardTypeNumberPad;
        BuyTextField.delegate = self;
        BuyTextField.placeholder = @"请输入购买金额";
        [SaleView addSubview:BuyTextField];
        [BuyTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(SaleView.mas_centerY);
            make.left.mas_equalTo(buyLabel.mas_right);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(20);
        }];
        
        InterestView = [[UIView alloc]init];
        InterestView.backgroundColor = [UIColor whiteColor];
        [BootmView addSubview:InterestView];
        [InterestView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(BootmView.mas_left);
            make.top.mas_equalTo(SaleView.mas_bottom).offset(0.5);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(44);
        }];

    }else if([_productID integerValue] == 7 || [_productID integerValue] == 8 ){
        
        SaleView = [[UIView alloc]init];
        SaleView.backgroundColor = [UIColor whiteColor];
        [BootmView addSubview:SaleView];
        [SaleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(BootmView.mas_left);
            make.top.mas_equalTo(ExplainLabel.mas_bottom).offset(10);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(44);
        }];
        UIImageView *BuyImageView = [[UIImageView alloc]init];
        BuyImageView.image = [UIImage imageNamed:@"buy"];
        [SaleView addSubview:BuyImageView];
        [BuyImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(SaleView.mas_centerY);
            make.left.mas_equalTo(SaleView.mas_left).offset(10);
            make.width.mas_equalTo(22);
            make.height.mas_equalTo(22);
        }];
        UILabel *buyLabel = [[UILabel alloc]init];
        buyLabel.text  = @"购买金额";
        buyLabel.textColor= colorWithRGB(0.27, 0.27, 0.27);
        buyLabel.font = [UIFont systemFontOfSize:15];
        [SaleView addSubview:buyLabel];
        [buyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(SaleView.mas_centerY);
            make.left.mas_equalTo(BuyImageView.mas_right).offset(10);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(20);
        }];
        
        BuyTextField = [[UITextField alloc]init];
        BuyTextField.backgroundColor = [UIColor whiteColor];
        BuyTextField.font = [UIFont systemFontOfSize:15];
        BuyTextField.textAlignment = NSTextAlignmentLeft;
        BuyTextField.keyboardType = UIKeyboardTypeNumberPad;
        BuyTextField.delegate = self;
        BuyTextField.tag = 100;
        BuyTextField.placeholder = @"请输入购买金额";
        [SaleView addSubview:BuyTextField];
        [BuyTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(SaleView.mas_centerY);
            make.left.mas_equalTo(buyLabel.mas_right);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(20);
        }];
        
        InterestView = [[UIView alloc]init];
        InterestView.backgroundColor = [UIColor whiteColor];
        [BootmView addSubview:InterestView];
        [InterestView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(BootmView.mas_left);
            make.top.mas_equalTo(SaleView.mas_bottom).offset(0.5);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(44);
        }];
    }else if([_productID integerValue] == 7 || [_productID integerValue] == 8 ){
        
        SaleView = [[UIView alloc]init];
        SaleView.backgroundColor = [UIColor whiteColor];
        [BootmView addSubview:SaleView];
        [SaleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(BootmView.mas_left);
            make.top.mas_equalTo(ExplainLabel.mas_bottom).offset(10);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(44);
        }];
        UIImageView *BuyImageView = [[UIImageView alloc]init];
        BuyImageView.image = [UIImage imageNamed:@"buy"];
        [SaleView addSubview:BuyImageView];
        [BuyImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(SaleView.mas_centerY);
            make.left.mas_equalTo(SaleView.mas_left).offset(10);
            make.width.mas_equalTo(22);
            make.height.mas_equalTo(22);
        }];
        UILabel *buyLabel = [[UILabel alloc]init];
        buyLabel.text  = @"购买金额";
        buyLabel.textColor= colorWithRGB(0.27, 0.27, 0.27);
        buyLabel.font = [UIFont systemFontOfSize:15];
        [SaleView addSubview:buyLabel];
        [buyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(SaleView.mas_centerY);
            make.left.mas_equalTo(BuyImageView.mas_right).offset(10);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(20);
        }];
        
        BuyTextField = [[UITextField alloc]init];
        BuyTextField.backgroundColor = [UIColor whiteColor];
        BuyTextField.font = [UIFont systemFontOfSize:15];
        BuyTextField.textAlignment = NSTextAlignmentLeft;
        BuyTextField.keyboardType = UIKeyboardTypeNumberPad;
        BuyTextField.delegate = self;
        BuyTextField.tag = 100;
        BuyTextField.placeholder = @"请输入购买金额";
        [SaleView addSubview:BuyTextField];
        [BuyTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(SaleView.mas_centerY);
            make.left.mas_equalTo(buyLabel.mas_right);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(20);
        }];
        
        InterestView = [[UIView alloc]init];
        InterestView.backgroundColor = [UIColor whiteColor];
        [BootmView addSubview:InterestView];
        [InterestView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(BootmView.mas_left);
            make.top.mas_equalTo(SaleView.mas_bottom).offset(0.5);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(44);
        }];
    }
    

    
    
    else{
        ChoceStageView = [[UIView alloc]init];
        ChoceStageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *choiceTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(MyChoceClcik)];
        [ChoceStageView addGestureRecognizer:choiceTap];
        ChoceStageView.backgroundColor = [UIColor whiteColor];
        [BootmView addSubview:ChoceStageView];
        [ChoceStageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(BootmView.mas_left);
            make.top.mas_equalTo(ExplainLabel.mas_bottom).offset(10);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(44);
        }];
        UIImageView *ChoceImageView = [[UIImageView alloc]init];
        ChoceImageView.image = [UIImage imageNamed:@"tool"];
        [ChoceStageView addSubview:ChoceImageView];
        [ChoceImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(ChoceStageView.mas_centerY);
            make.left.mas_equalTo(ChoceStageView.mas_left).offset(10);
            make.width.mas_equalTo(22);
            make.height.mas_equalTo(22);
        }];
        
        UILabel *choceLabel = [[UILabel alloc]init];
        choceLabel.text  = @"选择道具";
        choceLabel.textColor = colorWithRGB(0.27, 0.27, 0.27);
        choceLabel.font = [UIFont systemFontOfSize:15];
        [ChoceStageView addSubview:choceLabel];
        [choceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(ChoceStageView.mas_centerY);
            make.left.mas_equalTo(ChoceImageView.mas_right).offset(10);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(20);
        }];
        StageLabel = [[UILabel alloc]init];
        StageLabel.textColor = [UIColor blackColor];
        if (AddStr.length) {
            StageLabel.text = AddStr;
            
        }else{
            StageLabel.text = @"请选择道具";
            
        }
        StageLabel.font = [UIFont systemFontOfSize:15];
        [ChoceStageView addSubview:StageLabel];
        [StageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(ChoceStageView.mas_centerY);
            make.left.mas_equalTo(choceLabel.mas_right);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(20);
            
        }];
        
        UIImageView *sorrowView = [[UIImageView alloc]init];
        sorrowView.image = [UIImage imageNamed:@"goarrow"];
        [ChoceStageView addSubview:sorrowView];
        [sorrowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(ChoceStageView.mas_right).offset(-10);
            make.centerY.mas_equalTo(ChoceStageView.mas_centerY);
            make.width.mas_equalTo(18);
            make.height.mas_equalTo(18);
        }];
        
        SaleView = [[UIView alloc]init];
        SaleView.backgroundColor = [UIColor whiteColor];
        [BootmView addSubview:SaleView];
        [SaleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(BootmView.mas_left);
            make.top.mas_equalTo(ChoceStageView.mas_bottom).offset(0.5);
            make.width.mas_equalTo(SCREEN_WIDTH );
            make.height.mas_equalTo(44);
        }];
        UIImageView *BuyImageView = [[UIImageView alloc]init];
        BuyImageView.image = [UIImage imageNamed:@"buy"];
        [SaleView addSubview:BuyImageView];
        [BuyImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(SaleView.mas_centerY);
            make.left.mas_equalTo(SaleView.mas_left).offset(10);
            make.width.mas_equalTo(22);
            make.height.mas_equalTo(22);
        }];
        UILabel *buyLabel = [[UILabel alloc]init];
        buyLabel.text  = @"购买金额";
        buyLabel.textColor = colorWithRGB(0.27, 0.27, 0.27);
        buyLabel.font = [UIFont systemFontOfSize:15];
        [SaleView addSubview:buyLabel];
        [buyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(SaleView.mas_centerY);
            make.left.mas_equalTo(BuyImageView.mas_right).offset(10);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(20);
        }];
        
        BuyTextField = [[UITextField alloc]init];
        BuyTextField.backgroundColor = [UIColor whiteColor];
        BuyTextField.font = [UIFont systemFontOfSize:15];
        BuyTextField.textAlignment = NSTextAlignmentLeft;
        BuyTextField.keyboardType = UIKeyboardTypeNumberPad;
        BuyTextField.tag = 100;
        BuyTextField.delegate = self;
        BuyTextField.placeholder = @"请输入购买金额";
        [SaleView addSubview:BuyTextField];
        [BuyTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(SaleView.mas_centerY);
            make.left.mas_equalTo(buyLabel.mas_right);
            make.width.mas_equalTo(130);
            make.height.mas_equalTo(20);
        }];
        
        InterestView = [[UIView alloc]init];
        InterestView.backgroundColor = [UIColor whiteColor];
        [BootmView addSubview:InterestView];
        [InterestView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(BootmView.mas_left);
            make.top.mas_equalTo(SaleView.mas_bottom).offset(0.5);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(44);
        }];

    }
    
    
    UIImageView *InterestImageView = [[UIImageView alloc]init];
    InterestImageView.image = [UIImage imageNamed:@"principal"];
    [InterestView addSubview:InterestImageView];
    [InterestImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(InterestView.mas_centerY);
        make.left.mas_equalTo(InterestView.mas_left).offset(10);
        make.width.mas_equalTo(22);
        make.height.mas_equalTo(22);
    }];
    
   
    if ([_productCatiID integerValue] == 8) {
         UILabel *InterestLabel = [[UILabel alloc]init];
        InterestLabel.text  = @"预计每日收益(元)";
        InterestLabel.textColor = colorWithRGB(0.27, 0.27, 0.27);
        InterestLabel.font = [UIFont systemFontOfSize:15];
        [InterestView addSubview:InterestLabel];
        [InterestLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(InterestView.mas_centerY);
            make.left.mas_equalTo(InterestImageView.mas_right).offset(10);
            make.width.mas_equalTo(140);
            make.height.mas_equalTo(20);
        }];
        InterestMoneyLabel = [[UILabel alloc]init];
        InterestMoneyLabel.text = @"0.00";
        InterestMoneyLabel.font = [UIFont systemFontOfSize:15];
        [InterestView addSubview:InterestMoneyLabel];
        [InterestMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(InterestView.mas_centerY);
            make.left.mas_equalTo(InterestLabel.mas_right);
            make.width.mas_equalTo(300);
            make.height.mas_equalTo(20);
            
        }];

    }else{
        UILabel *InterestLabel = [[UILabel alloc]init];

        InterestLabel.text  = @"预计本息";
        InterestLabel.textColor = colorWithRGB(0.27, 0.27, 0.27);
        InterestLabel.font = [UIFont systemFontOfSize:15];
        [InterestView addSubview:InterestLabel];
        [InterestLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(InterestView.mas_centerY);
            make.left.mas_equalTo(InterestImageView.mas_right).offset(10);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(20);
        }];
        InterestMoneyLabel = [[UILabel alloc]init];
        InterestMoneyLabel.text = @"0.00";
        InterestMoneyLabel.font = [UIFont systemFontOfSize:15];
        [InterestView addSubview:InterestMoneyLabel];
        [InterestMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(InterestView.mas_centerY);
            make.left.mas_equalTo(InterestLabel.mas_right);
            make.width.mas_equalTo(300);
            make.height.mas_equalTo(20);
            
        }];

    }
    
    

    PassWordView = [[UIView alloc]init];
    PassWordView.backgroundColor = [UIColor whiteColor];
    [BootmView addSubview:PassWordView];
    [PassWordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(BootmView.mas_left);
        make.top.mas_equalTo(InterestView.mas_bottom).offset(0.5);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(44);
    }];
    UIImageView *PassWordImageView = [[UIImageView alloc]init];
    PassWordImageView.image = [UIImage imageNamed:@"password"];
    [PassWordView addSubview:PassWordImageView];
    [PassWordImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(PassWordView.mas_centerY);
        make.left.mas_equalTo(PassWordView.mas_left).offset(10);
        make.width.mas_equalTo(22);
        make.height.mas_equalTo(22);
    }];
    UILabel *passWordLabel = [[UILabel alloc]init];
    passWordLabel.textColor = colorWithRGB(0.27, 0.27, 0.27);
    passWordLabel.text  = @"交易密码";
    passWordLabel.font = [UIFont systemFontOfSize:15];
    [PassWordView addSubview:passWordLabel];
    [passWordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(PassWordView.mas_centerY);
        make.left.mas_equalTo(PassWordImageView.mas_right).offset(10);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(20);
    }];
    
    PassWordTextField = [[UITextField alloc]init];
    PassWordTextField.backgroundColor = [UIColor whiteColor];
    PassWordTextField.font = [UIFont systemFontOfSize:15];
    PassWordTextField.textAlignment = NSTextAlignmentLeft;
    PassWordTextField.secureTextEntry = YES;
    PassWordTextField.delegate = self;
    PassWordTextField.placeholder = @"请输入交易密码";
    [PassWordView addSubview:PassWordTextField];
    [PassWordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(PassWordView.mas_centerY);
        make.left.mas_equalTo(passWordLabel.mas_right);
        make.width.mas_equalTo(130);
        make.height.mas_equalTo(20);
    }];
    
    ClickBtn = [[UIButton alloc]init];
    [ClickBtn setBackgroundImage:[UIImage imageNamed:@"uncheck"] forState:UIControlStateNormal];
    ClickBtn.selected = YES;
    [ClickBtn setBackgroundImage:[UIImage imageNamed:@"check"] forState:UIControlStateSelected];
    [ClickBtn addTarget:self action:@selector(Saleclicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ClickBtn];
    [ClickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.top.mas_equalTo(PassWordView.mas_bottom).offset(10);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    UILabel *nameLabel =[[UILabel alloc]init];
    nameLabel.font = [UIFont systemFontOfSize:13];
    NSMutableAttributedString *ConnectStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"我同意《服务协议》 及"]];
    [ConnectStr addAttribute:NSForegroundColorAttributeName value:colorWithRGB(0.62, 0.80, 0.09)range:NSMakeRange(3,6)];
    nameLabel.attributedText = ConnectStr;
    nameLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *gesTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SaleConnectClick)];
    [nameLabel addGestureRecognizer:gesTap];
    [self.view addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ClickBtn.mas_right).offset(10);
        make.top.mas_equalTo(PassWordView.mas_bottom).offset(10);
        make.width.mas_equalTo(140);
        make.height.mas_equalTo(15);
    }];
    
    UILabel *riskLabel = [[UILabel alloc]init];
    riskLabel.text = @"《风险提示》";
    riskLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *riskTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(riskClickOrNo)];
    [riskLabel addGestureRecognizer:riskTap];
    riskLabel.textAlignment = NSTextAlignmentLeft;
    riskLabel.font = [UIFont systemFontOfSize:13];
    riskLabel.textColor = colorWithRGB(0.62, 0.80, 0.09);
    [self.view addSubview:riskLabel];
    [riskLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameLabel.mas_right);
        make.top.mas_equalTo(PassWordView.mas_bottom).offset(10);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(15);
    }];
    
    
    
    SaleLabel = [[UILabel alloc]init];
    SaleLabel.text = @"购买";
    SaleLabel.userInteractionEnabled = YES;
    SaleLabel.backgroundColor = colorWithRGB(0.28, 0.46, 0.91);
    SaleLabel.textAlignment = NSTextAlignmentCenter;
    SaleLabel.textColor = [UIColor whiteColor];
    SaleLabel.layer.cornerRadius = 22;
    SaleLabel.layer.masksToBounds = YES;
    [BootmView addSubview:SaleLabel];
    [SaleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(BootmView.mas_left).offset(25);
        make.top.mas_equalTo(PassWordView.mas_bottom).offset(50);
        make.width.mas_equalTo(SCREEN_WIDTH - 50);
        make.height.mas_equalTo(44);
    }];
    
    UITapGestureRecognizer *SaleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SaleBtn
                                                                                                          )];
    [SaleLabel addGestureRecognizer:SaleTap];
    
    switch ([_productID integerValue]) {
        case 1:
            TitleLabel.textColor = colorWithRGB(0.62, 0.80, 0.09);
            MoneyPercentLabel.textColor = colorWithRGB(0.62, 0.80, 0.09);
            MoneyLeftLbel.textColor = colorWithRGB(0.62, 0.80, 0.09);
            ExplainLabel.textColor =  colorWithRGB(0.62, 0.80, 0.09);
            SaleLabel.backgroundColor = colorWithRGB(0.62, 0.80, 0.09);
            percentLabel.textColor = colorWithRGB(0.62, 0.80, 0.09);
            break;
        case 2:
            TitleLabel.textColor = colorWithRGB(0.99, 0.79, 0.09);
            MoneyPercentLabel.textColor = colorWithRGB(0.99, 0.79, 0.09);
            MoneyLeftLbel.textColor = colorWithRGB(0.99, 0.79, 0.09);
            ExplainLabel.textColor =  colorWithRGB(0.99, 0.79, 0.09);
            SaleLabel.backgroundColor = colorWithRGB(0.99, 0.79, 0.09);
           percentLabel.textColor = colorWithRGB(0.99, 0.79, 0.09);
            break;
        case 3:
            TitleLabel.textColor = colorWithRGB(0.99, 0.52, 0.18);
            MoneyPercentLabel.textColor =  colorWithRGB(0.99, 0.52, 0.18);
            MoneyLeftLbel.textColor =  colorWithRGB(0.99, 0.52, 0.18);
            ExplainLabel.textColor =   colorWithRGB(0.99, 0.52, 0.18);
            SaleLabel.backgroundColor =  colorWithRGB(0.99, 0.52, 0.18);
            percentLabel.textColor =  colorWithRGB(0.99, 0.52, 0.18);
            break;
        case 4:
            TitleLabel.textColor =colorWithRGB(0.27, 0.78, 0.96);
            MoneyPercentLabel.textColor = colorWithRGB(0.27, 0.78, 0.96);
            MoneyLeftLbel.textColor = colorWithRGB(0.27, 0.78, 0.96);
            ExplainLabel.textColor =  colorWithRGB(0.27, 0.78, 0.96);
            SaleLabel.backgroundColor = colorWithRGB(0.27, 0.78, 0.96);
             percentLabel.textColor = colorWithRGB(0.27, 0.78, 0.96);
            break;
        case 5:
            TitleLabel.textColor =  colorWithRGB(0.31, 0.69, 1);
            MoneyPercentLabel.textColor = colorWithRGB(0.31, 0.69, 1);
            MoneyLeftLbel.textColor = colorWithRGB(0.31, 0.69, 1);
            ExplainLabel.textColor =  colorWithRGB(0.31, 0.69, 1);
            SaleLabel.backgroundColor = colorWithRGB(0.31, 0.69,1);
             percentLabel.textColor = colorWithRGB(0.31, 0.69,1);
            break;
        case 6:
            TitleLabel.textColor = colorWithRGB(0.19, 0.39, 0.9);
            MoneyPercentLabel.textColor =  colorWithRGB(0.19, 0.39, 0.9);
            MoneyLeftLbel.textColor =  colorWithRGB(0.19, 0.39, 0.9);
            ExplainLabel.textColor =   colorWithRGB(0.19, 0.39, 0.9);
            SaleLabel.backgroundColor =  colorWithRGB(0.19, 0.39, 0.9);
            percentLabel.textColor =  colorWithRGB(0.19, 0.39, 0.9);
            BuyTextField.text = [NSString stringWithFormat:@"%@",_aggregateAmount];

            float text = [_productCi doubleValue]-[BuyTextField.text integerValue];
            NSInteger  percentStr = text *100;
            double  resultStr = (double)percentStr/100;
            InterestMoneyLabel.text = [NSString stringWithFormat:@"%@+%.2f",BuyTextField.text,resultStr];
            BuyTextField.enabled = NO;
            
            break;
        case 7:
            TitleLabel.textColor = colorWithRGB(0.99, 0.79, 0.09);
            MoneyPercentLabel.textColor = colorWithRGB(0.99, 0.79, 0.09);
            MoneyLeftLbel.textColor = colorWithRGB(0.99, 0.79, 0.09);
            ExplainLabel.textColor =  colorWithRGB(0.99, 0.79, 0.09);
            SaleLabel.backgroundColor = colorWithRGB(0.99, 0.79, 0.09);
            break;
        case 8:
            TitleLabel.textColor = colorWithRGB(0.99, 0.79, 0.09);
            MoneyPercentLabel.textColor = colorWithRGB(0.99, 0.79, 0.09);
            MoneyLeftLbel.textColor = colorWithRGB(0.99, 0.79, 0.09);
            ExplainLabel.textColor =  colorWithRGB(0.99, 0.79, 0.09);
            SaleLabel.backgroundColor = colorWithRGB(0.99, 0.79, 0.09);
            break;
        default:
            break;
    }
    AddMoneyLabel = [[UILabel alloc]init];
    AddMoneyLabel.backgroundColor = colorWithRGB(0.95, 0.60, 0.11);
    AddMoneyLabel.textColor = [UIColor whiteColor];
    AddMoneyLabel.font = [UIFont systemFontOfSize:14];
    AddMoneyLabel.layer.cornerRadius = 2;
    AddMoneyLabel.textAlignment = NSTextAlignmentCenter;
    AddMoneyLabel.layer.masksToBounds = YES;
    //mCGSize size =CGSizeMake(400,20);
    AddMoneyLabel.hidden = YES;
    AddMoneyLabel.text = @"";
//    AddMoneyLabel.text =[NSString stringWithFormat:@"+%@",AddStr];
//    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:12],NSFontAttributeName,nil];
//    CGSize  actualsize =[AddMoneyLabel.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin  attributes:tdic context:nil].size;
//    AddMoneyLabel.textAlignment = NSTextAlignmentLeft;
    AddMoneyLabel.frame = CGRectMake(SCREEN_WIDTH/2+65, 50, 100, 40);
    [TopView addSubview:AddMoneyLabel];
    
    
    

}
- (void)SaleConnectClick{
    //协议
    BundProfileViewController *vc= [[BundProfileViewController alloc]init];
    vc.TitleStr = @"米粒儿金融投资咨询与管理服务协议(出借人)";
    NSString *urlStr =  [NSString stringWithFormat:@"%@/agreement/registration.html",HOST_URL];
    vc.WebStr = urlStr;
    [self.navigationController pushViewController:vc animated:NO];

}

- (void)riskClickOrNo{
    [RiskAlertView dismissAnimated:YES];
    BundProfileViewController *vc= [[BundProfileViewController alloc]init];
    vc.TitleStr = @"米粒儿金融风险提示协议";
    vc.WebStr = [NSString stringWithFormat:@"%@/agreement/service.html",HOST_URL];
    [self.navigationController pushViewController:vc animated:NO];

}
- (void)Saleclicked:(UIButton *)btn{
    if (btn.selected) {
        btn.selected = NO;
    }else{
        btn.selected = YES;
    }
}
- (void)ConfigInverest{
//    AddMoneyLabel = [[UILabel alloc]init];
//    AddMoneyLabel.backgroundColor = colorWithRGB(0.95, 0.60, 0.11);
//    AddMoneyLabel.textColor = [UIColor whiteColor];
//    AddMoneyLabel.font = [UIFont systemFontOfSize:12];
    CGSize size =CGSizeMake(400,20);
//    AddMoneyLabel.text = @"";
    if (Type == 1) {
        AddMoneyLabel.text =[NSString stringWithFormat:@"+%@%%",AddStr];
   
    }else{
        AddMoneyLabel.text =[NSString stringWithFormat:@"+%@元",AddStr];
 
    }
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14],NSFontAttributeName,nil];
    CGSize  actualsize =[AddMoneyLabel.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin  attributes:tdic context:nil].size;
    AddMoneyLabel.textAlignment = NSTextAlignmentCenter;
    AddMoneyLabel.frame = CGRectMake(SCREEN_WIDTH/2+65, 50, actualsize.width+10, 25);
    [TopView addSubview:AddMoneyLabel];

    if (AddStr.length) {
        AddMoneyLabel.hidden = NO;
        
    }else{

        AddMoneyLabel.hidden = YES;
       
    }
   
  
}
- (void)SaleBtn{
    
    if (ClickBtn.selected) {
        NSString *userID = NSuserUse(@"userId");
        NSString *riskID = NSuserUse(@"riskLevel");
    
        if ([userID integerValue] > 0) {
            if ([BankStatus integerValue] ==1) {
                if ([PassWordStr integerValue] == 1) {
                    NSString *totalStr = [NSString stringWithFormat:@"%@",_TotalStr];
                    double totalDouble = [totalStr doubleValue];
                    
                    NSString *sellStr = [NSString stringWithFormat:@"%@",_SellStr];
                    double sellDouble = [sellStr doubleValue];
                    double leftMoney = totalDouble - sellDouble;
                    if ([BuyTextField.text doubleValue] <= leftMoney) {
                        if ([BuyTextField.text doubleValue] >= [_minBuyStr doubleValue]) {
                            if ([BuyTextField.text doubleValue] <= [MyMoneyStr doubleValue]) {
                                //购 买
                                if ([riskID integerValue] >0) {
                                    if ([userRiskStr integerValue] < [_riskLevelStr integerValue]){
                                        if (riskOrNo == 0) {
                                            [self popAlertView];
                                            
                                        }else{
                                            [self showProgress];

                                            [self WriteSailPassWord];
                                        }
                                        
                                    }else{
                                        [self showProgress];

                                            [self WriteSailPassWord];
 
                                      
                                    }
//                                    if (riskOrNo == 1) {
//                                        
//                                         [self popAlertView];
//                                    }else{
//                                        
//                                        if ([userRiskStr integerValue] < [_riskLevelStr integerValue]) {
//
//                                            [self popAlertView];
//
//                                                                                
//                                        }else{
//                                            //弹出提示框
                                    //                                            [self WriteSailPassWord];
//
//                                            
//                                        }
//
//                                    }



                                }else{
                                    //风险测试
                                    RiskViewController *RiskVC = [[RiskViewController alloc]init];
                                    [self.navigationController   pushViewController:RiskVC animated:NO];
                                }
                                
                                
                                
                            }else{
                                //跳转充值
                                TouUpViewController *SaleVC = [[TouUpViewController alloc]init];
                                SaleVC.bankID = BankID;
                                [self.navigationController   pushViewController:SaleVC animated:NO];
                            }
                            
                            
                        }else{
                            NSString *minStr = [NSString stringWithFormat:@"购买金额少于最低购买金额%@元",_minBuyStr];
                            normal_alert(@"提示", minStr, @"确定");
                        }
                        
                    }else{
                          NSString *minStr = [NSString stringWithFormat:@"购买金额不得大于剩余额度%.2f元",leftMoney];
                        normal_alert(@"提示", minStr, @"确定");
                    }
                    
                    
                    
                    
                }else{
                    //设置交易密码
                    SalePassWordViewController *SaleVC = [[SalePassWordViewController alloc]init];
                    [self.navigationController   pushViewController:SaleVC animated:NO];
                }
                
                
            }else{
                //绑卡页面
                BundCardViewController *LoginVC = [[BundCardViewController alloc]init];
                [self.navigationController pushViewController:LoginVC animated:NO];
                
            }
            
            
        }else{
            YWDLoginViewController *LoginVC = [[YWDLoginViewController alloc]init];
            LoginVC.Type = 1;
            [self presentViewController:LoginVC animated:NO completion:nil];
            
        }

    }else{
        normal_alert(@"提示", @"请同意协议", @"确定");
    }
    
    
    
}

- (void)WriteSailPassWord{
   
    if ([BuyTextField.text integerValue] >= [StageChoseStr integerValue]) {
        NSString *Bottomurl;
        NSString *tokenID = NSuserUse(@"Authorization");
        Bottomurl = [NSString stringWithFormat:@"%@/productOrders",HOST_URL];
        
        if (StageOid.length) {
            
        }else{
            StageOid = @"-1";
        }
        NSMutableDictionary   *dic = [[NSMutableDictionary alloc]initWithObjectsAndKeys:_productStr,@"productId", BuyTextField.text,@"amount",StageOid,@"propId",PassWordTextField.text,@"dealPassword",nil];
        [[DateSource sharedInstance]requestHomeWithParameters:dic withUrl:Bottomurl withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
            NSLog(@"re 购买== %@",result);
            if ([[result objectForKey:@"statusCode"]integerValue] == 201) {
                [self HideProgress];
                //UIAlertController风格：UIAlertControllerStyleAlert
                NSString *sucessStr = [NSString stringWithFormat:@"%@",[[result objectForKey:@"data"]objectForKey:@"award"]];
                NSString *mySucessStr;
                if ([sucessStr isEqualToString:@"(null)"]) {
                    mySucessStr = @"请到个人中心查看";
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"购买成功"
                                                                                             message:mySucessStr
                                                                                      preferredStyle:UIAlertControllerStyleAlert ];
                    
                    //添加取消到UIAlertController中
                    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
                    [alertController addAction:cancelAction];
                    
                    //添加确定到UIAlertController中
                    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        for (UIViewController *controller in self.navigationController.viewControllers) {
                            if ([controller isKindOfClass:[ProductDetailNewViewController class]]) {
                                [self.navigationController popToViewController:controller animated:YES];
                            }
                        }
                        
                    }];
                    [alertController addAction:OKAction];
                    [self presentViewController:alertController animated:YES completion:nil];
                }else{
                    mySucessStr = sucessStr;
                    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 260)];
                    view.backgroundColor=[UIColor whiteColor];
                    view.layer.masksToBounds = YES;
                    view.layer.cornerRadius = 5.0f;
                    view.alpha = 0.9;
                    
                    
                    UIImageView *  CancelImageView = [[UIImageView alloc]init];
                    CancelImageView.image = [UIImage imageNamed:@"close"];
                    CancelImageView.userInteractionEnabled = YES;
                    UITapGestureRecognizer *CancelTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sureClick)];
                    [CancelImageView addGestureRecognizer:CancelTap];
                    CancelImageView.frame = CGRectMake(SCREEN_WIDTH - 30, 10, 20, 20);
                    [view addSubview:CancelImageView];
                    
                    
                    UILabel *label = [[UILabel alloc]init];
                    label.frame = CGRectMake(20, 10, 80, 20);
                    label.text = @"提示";
                    label.font = [UIFont systemFontOfSize:15];
                    [view addSubview:label];
                    UILabel *buyLabel = [[UILabel alloc]init];
                    buyLabel.text = @"购买成功";
                    buyLabel.textColor = [UIColor greenColor];
                    buyLabel.font = [UIFont systemFontOfSize:16];
                    buyLabel.frame = CGRectMake(40, 40, 100, 30);
                    [view addSubview:buyLabel];
                    UILabel *buyLabel1 = [[UILabel alloc]init];
                    NSString *myMessage = [NSString stringWithFormat:@"%@",[[result objectForKey:@"data"]objectForKey:@"award"]];
                    
                    buyLabel1.text = [NSString stringWithFormat:@"%@",myMessage];
                    buyLabel1.font = [UIFont systemFontOfSize:15];
                    buyLabel1.frame = CGRectMake(40, 70, 300, 30);
                    [view addSubview:buyLabel1];
//                    UILabel *buyLabel2 = [[UILabel alloc]init];
//
//                    buyLabel2.font = [UIFont systemFontOfSize:15];
//                    buyLabel2.frame = CGRectMake(40, 100, 300, 30);
//                    [view addSubview:buyLabel2];
                    UIView *saleView = [[UIView alloc]init];
                    saleView.backgroundColor = [UIColor whiteColor];
                    saleView.frame = CGRectMake(0, 200, SCREEN_WIDTH, 60);
                    [view addSubview:saleView];
                    UILabel *SaleLbel =  [[UILabel alloc]init];
                    SaleLbel.text = @"确定";
                    SaleLbel.userInteractionEnabled = YES;
                    SaleLbel.backgroundColor = colorWithRGB(0.95, 0.60, 0.11);
                    SaleLbel.textAlignment = NSTextAlignmentCenter;
                    SaleLbel.textColor = [UIColor whiteColor];
                    SaleLbel.layer.cornerRadius = 20;
                    SaleLbel.layer.masksToBounds = YES;
                    [saleView addSubview:SaleLbel];
                    [SaleLbel mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.centerX.mas_equalTo(saleView.mas_centerX);
                        make.centerY.mas_equalTo(saleView.mas_centerY);
                        make.width.mas_equalTo(SCREEN_WIDTH - 40);
                        make.height.mas_equalTo(40);
                    }];
                    
                    UITapGestureRecognizer *SaleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(MySureClick
                                                                                                                    )];
                    [SaleLbel addGestureRecognizer:SaleTap];
                    numberAnimatedV = [[MSNumberScrollAnimatedView alloc] initWithFrame:CGRectMake(20, 130, SCREEN_WIDTH-40, 60)];
                    numberAnimatedV.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:42];
                    numberAnimatedV.textColor = [UIColor redColor];
                    numberAnimatedV.minLength = 7;
                    NSString *myPercent = [NSString stringWithFormat:@"%@",[[result objectForKey:@"data"]objectForKey:@"percent"]];
                    numberAnimatedV.number = @([myPercent integerValue]);
                    [numberAnimatedV startAnimation];
                    [view addSubview:numberAnimatedV];
                    
                    
                    UILabel *yuanLabel = [[UILabel alloc]init];
                    yuanLabel.text = @"元";
                    yuanLabel.textColor = [UIColor redColor];
                    [view addSubview:yuanLabel];
                    [yuanLabel   mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.mas_equalTo(numberAnimatedV.mas_right);
                        make.bottom.mas_equalTo(numberAnimatedV.mas_bottom);
                        make.width.mas_equalTo(30);
                        make.height.mas_equalTo(20);
                    }];
                    
                    //    UIImageView *UseImageView = [[UIImageView alloc]init];
                    //    UseImageView.image = [UIImage imageNamed:@"tip"];
                    //    [view addSubview:UseImageView];
                    //    [UseImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    //        make.centerX.mas_equalTo(view.mas_centerX);
                    //        make.top.mas_equalTo(view.mas_top).offset(40);
                    //        make.width.mas_equalTo(40);
                    //        make.height.mas_equalTo(40);
                    //
                    //    }];
                    
                    
                    
                    
                    SureAlertView=[[AwAlertView alloc]initWithContentView:view];
                    SureAlertView.isUseHidden=YES;
                    [SureAlertView showAnimated:YES];
  
                }
                
               
                
               
                //            normal_alert(@"提示", @"购买成功　", @"确定");
                //            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                //                //  返回指定页面
                //                for (UIViewController *controller in self.navigationController.viewControllers) {
                //                    if ([controller isKindOfClass:[ProductDetailNewViewController class]]) {
                //                        [self.navigationController popToViewController:controller animated:YES];
                //                    }
                //                }
                //            });
                
            }else{
                 [self HideProgress];
                NSString *message = [result objectForKey:@"message"];
                normal_alert(@"提示", message, @"确定");
            }
        }];

    }else{
        [self HideProgress];
        NSString *str = [NSString stringWithFormat:@"该道具使用的最低额度为%@元",StageChoseStr];
        normal_alert(@"提示", str, @"确定");
    }
    
    
    
}


- (void)SureSale{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 260)];
    view.backgroundColor=[UIColor whiteColor];
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 5.0f;
    view.alpha = 0.9;
    
    
    UIImageView *  CancelImageView = [[UIImageView alloc]init];
    CancelImageView.image = [UIImage imageNamed:@"close"];
    CancelImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *CancelTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sureClick)];
    [CancelImageView addGestureRecognizer:CancelTap];
    CancelImageView.frame = CGRectMake(SCREEN_WIDTH - 30, 10, 20, 20);
    [view addSubview:CancelImageView];
    
    
    UILabel *label = [[UILabel alloc]init];
    label.frame = CGRectMake(20, 10, 80, 20);
    label.text = @"提示";
    label.font = [UIFont systemFontOfSize:15];
    [view addSubview:label];
    UILabel *buyLabel = [[UILabel alloc]init];
    buyLabel.text = @"购买成功";
    buyLabel.textColor = [UIColor greenColor];
    buyLabel.font = [UIFont systemFontOfSize:14];
    buyLabel.frame = CGRectMake(40, 40, 100, 30);
    [view addSubview:buyLabel];
    UILabel *buyLabel1 = [[UILabel alloc]init];
    buyLabel1.text = @"恭喜您的财富再一次升级。";
    buyLabel1.textColor = [UIColor greenColor];
    buyLabel1.font = [UIFont systemFontOfSize:14];
    buyLabel1.frame = CGRectMake(40, 70, 300, 30);
    [view addSubview:buyLabel1];
    UILabel *buyLabel2 = [[UILabel alloc]init];
    buyLabel2.text = @"参加双12活动，获得随机抵扣投资金额:";
    buyLabel2.textColor = [UIColor greenColor];
    buyLabel2.font = [UIFont systemFontOfSize:14];
    buyLabel2.frame = CGRectMake(40, 100, 300, 30);
    [view addSubview:buyLabel2];
    UIView *saleView = [[UIView alloc]init];
    saleView.backgroundColor = [UIColor whiteColor];
    saleView.frame = CGRectMake(0, 200, SCREEN_WIDTH, 60);
    [view addSubview:saleView];
    UILabel *SaleLbel =  [[UILabel alloc]init];
    SaleLbel.text = @"确定";
    SaleLbel.userInteractionEnabled = YES;
    SaleLbel.backgroundColor = colorWithRGB(0.95, 0.60, 0.11);
    SaleLbel.textAlignment = NSTextAlignmentCenter;
    SaleLbel.textColor = [UIColor whiteColor];
    SaleLbel.layer.cornerRadius = 20;
    SaleLbel.layer.masksToBounds = YES;
    [saleView addSubview:SaleLbel];
    [SaleLbel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(saleView.mas_centerX);
        make.centerY.mas_equalTo(saleView.mas_centerY);
        make.width.mas_equalTo(SCREEN_WIDTH - 40);
        make.height.mas_equalTo(40);
    }];
    
    UITapGestureRecognizer *SaleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(MySureClick
                                                                                                          )];
    [SaleLbel addGestureRecognizer:SaleTap];
    numberAnimatedV = [[MSNumberScrollAnimatedView alloc] initWithFrame:CGRectMake(20, 130, SCREEN_WIDTH-40, 60)];
    numberAnimatedV.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:42];
    numberAnimatedV.textColor = [UIColor redColor];
    numberAnimatedV.minLength = 7;
    numberAnimatedV.number = @(200);
    [numberAnimatedV startAnimation];
    [view addSubview:numberAnimatedV];
    
    
    UILabel *yuanLabel = [[UILabel alloc]init];
    yuanLabel.text = @"元";
    yuanLabel.textColor = [UIColor redColor];
    [view addSubview:yuanLabel];
    [yuanLabel   mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(numberAnimatedV.mas_right);
        make.bottom.mas_equalTo(numberAnimatedV.mas_bottom);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(20);
    }];
    
//    UIImageView *UseImageView = [[UIImageView alloc]init];
//    UseImageView.image = [UIImage imageNamed:@"tip"];
//    [view addSubview:UseImageView];
//    [UseImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(view.mas_centerX);
//        make.top.mas_equalTo(view.mas_top).offset(40);
//        make.width.mas_equalTo(40);
//        make.height.mas_equalTo(40);
//
//    }];

    
 
    
    SureAlertView=[[AwAlertView alloc]initWithContentView:view];
    SureAlertView.isUseHidden=YES;
    [SureAlertView showAnimated:YES];
}
- (void)MySureClick{
    [SureAlertView dismissAnimated:NO];
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[ProductDetailNewViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
}
- (void)sureClick{
    [SureAlertView dismissAnimated:NO];
}
- (void)popAlertView{
    
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 260)];
    view.backgroundColor=[UIColor whiteColor];
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 5.0f;
    view.alpha = 0.9;

    
    UIImageView *  CancelImageView = [[UIImageView alloc]init];
    CancelImageView.image = [UIImage imageNamed:@"close"];
    CancelImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *CancelTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(RiskCancelClick)];
    [CancelImageView addGestureRecognizer:CancelTap];
    CancelImageView.frame = CGRectMake(SCREEN_WIDTH - 30, 10, 20, 20);
    [view addSubview:CancelImageView];
    
    
    UILabel *label = [[UILabel alloc]init];
    label.frame = CGRectMake(20, 10, 80, 20);
    label.text = @"提示";
    label.font = [UIFont systemFontOfSize:15];
    [view addSubview:label];
    
    UIImageView *UseImageView = [[UIImageView alloc]init];
    UseImageView.image = [UIImage imageNamed:@"tip"];
    [view addSubview:UseImageView];
    [UseImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view.mas_centerX);
        make.top.mas_equalTo(view.mas_top).offset(40);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
        
    }];
    UILabel *alertLabel = [[UILabel alloc]init];
    alertLabel.text = @"您的风险等级不够！";
    alertLabel.font = [UIFont systemFontOfSize:15];
    alertLabel.textAlignment = NSTextAlignmentCenter;
    alertLabel.textColor = colorWithRGB(0.95, 0.6, 0.11);
    [view addSubview:alertLabel];
    [alertLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(UseImageView.mas_centerX);
        make.top.mas_equalTo(UseImageView.mas_bottom).offset(20);
        make.width.mas_equalTo(140);
        make.height.mas_equalTo(20);
    }];
    
    UILabel *goonLabel = [[UILabel alloc]init];
    goonLabel.text = @"如果继续购买，请先打勾认可风险";
    goonLabel.font = [UIFont systemFontOfSize:14];
    goonLabel.textAlignment = NSTextAlignmentCenter;
    goonLabel.numberOfLines = 0;
    [view addSubview:goonLabel];
    [goonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(UseImageView.mas_centerX).offset(10);
        make.top.mas_equalTo(alertLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(3000);
        make.height.mas_equalTo(20);
    }];
    
    RiskClickBtn = [[UIButton alloc]init];
    [RiskClickBtn setBackgroundImage:[UIImage imageNamed:@"uncheck"] forState:UIControlStateNormal];
    RiskClickBtn.selected = YES;
    [RiskClickBtn setBackgroundImage:[UIImage imageNamed:@"check"] forState:UIControlStateSelected];
    [RiskClickBtn addTarget:self action:@selector(riskclicked:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:RiskClickBtn];
    [RiskClickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view.mas_left).offset(90);
        make.top.mas_equalTo(goonLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    UILabel *nameLabel =[[UILabel alloc]init];
    nameLabel.font = [UIFont systemFontOfSize:14];
    NSMutableAttributedString *ConnectStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"我同意《风险提示》"]];
   [ConnectStr addAttribute:NSForegroundColorAttributeName value:colorWithRGB(0.62, 0.8, 0.09) range:NSMakeRange(3,6)];
    nameLabel.attributedText = ConnectStr;
    nameLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *gesTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(riskClickOrNo)];
    [nameLabel addGestureRecognizer:gesTap];
    [view addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(RiskClickBtn.mas_right);
        make.top.mas_equalTo(goonLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(15);
    }];
    
   UILabel * RiskLabel = [[UILabel alloc]init];
    RiskLabel.text = @"继续购买";
    RiskLabel.userInteractionEnabled = YES;
    RiskLabel.backgroundColor = colorWithRGB(0.95, 0.6, 0.11);
    RiskLabel.textAlignment = NSTextAlignmentCenter;
    RiskLabel.textColor = [UIColor whiteColor];
    RiskLabel.layer.cornerRadius = 20;
    RiskLabel.layer.masksToBounds = YES;
    [view addSubview:RiskLabel];
    [RiskLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view.mas_centerX);
        make.top.mas_equalTo(RiskClickBtn.mas_bottom).offset(20);
        make.width.mas_equalTo(SCREEN_WIDTH - 180);
        make.height.mas_equalTo(40);
    }];
    
    UITapGestureRecognizer *SaleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(RiskBtnTap
                                                                                                          )];
    [RiskLabel addGestureRecognizer:SaleTap];
    
    RiskAlertView=[[AwAlertView alloc]initWithContentView:view];
    RiskAlertView.isUseHidden=YES;
    [RiskAlertView showAnimated:YES];
}
- (void)RiskBtnTap{
    if (RiskClickBtn.selected) {
        riskOrNo = 1;
       // [self WriteSailPassWord];
        [RiskAlertView dismissAnimated:NO];

    }else{
        
        riskOrNo = 0;
        [RiskAlertView dismissAnimated:NO];

    }

}
- (void)RiskCancelClick{
    [RiskAlertView dismissAnimated:NO];
    
  
}
- (void)riskClick{
    //服务协议
}

- (void)riskclicked:(UIButton *)btn{
    if (btn.selected) {
        btn.selected = NO;
    }else{
        btn.selected = YES;
    }
}
- (void)MyChoceClcik{
    
    UIView *view=[[UIView alloc]init];
    view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 280);

    view.backgroundColor=[UIColor whiteColor];
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 5.0f;
    view.alpha = 0.9;
    StageTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH,230) style:UITableViewStylePlain];
    StageTableView.delegate = self;
    StageTableView.dataSource = self;
    StageTableView.tableFooterView = [UIView new];
    StageTableView.backgroundColor = [UIColor whiteColor];
    [view addSubview:StageTableView];

    UIImageView *  CancelImageView = [[UIImageView alloc]init];
    CancelImageView.image = [UIImage imageNamed:@"close"];
    CancelImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *CancelTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SaleCancelClick)];
    [CancelImageView addGestureRecognizer:CancelTap];
    CancelImageView.frame = CGRectMake(SCREEN_WIDTH - 30, 10, 20, 20);
    [view addSubview:CancelImageView];
    
    
    UILabel *label = [[UILabel alloc]init];
    label.frame = CGRectMake(20, 10, 80, 20);
    label.text = @"选择道具";
    label.font = [UIFont systemFontOfSize:15];
    [view addSubview:label];
    
    
    alertView=[[AwAlertView alloc]initWithContentView:view];
    alertView.isUseHidden=YES;
    [alertView showAnimated:YES];
}
- (void)textFieldDidEndEditing:(UITextField *)textField{

    [self HideKeyBoardClick];
    
    if (BuyTextField.tag ==100) {
        if ([textField.text doubleValue] >= [_minBuyStr doubleValue]){
            [self refreshInvest];
            
        }else{
           // normal_alert(@"提示", @"购买金额少于最低购买金额", @"确定");
        };
    }
   
    
}
- (void)MyIsFull{

    NSString *  isfull;
    isfull = [NSString stringWithFormat:@"%.2f",[_fullScaleReward doubleValue]];
    if ([BuyTextField.text integerValue] == [_TotalStr integerValue]) {
        if ([_isFullScaleReward integerValue] == 1  ) {
            if ([_fullScaleReward doubleValue]) {
                if (Type == 1) {
                    float text =[BuyTextField.text integerValue]*([_PercentStr doubleValue]+[AddStr doubleValue]+[isfull doubleValue]+[percent doubleValue])*[_investmentHorizonStr doubleValue]/36500.0f;
                    
                    NSInteger  percentStr = text *100;
                    double  resultStr = (double)percentStr/100;

                    InterestMoneyLabel.text  = [NSString stringWithFormat:@"%ld+%.2f",[BuyTextField.text integerValue],resultStr];
                }else if(Type ==2){
                    float text = [BuyTextField.text integerValue]*([_PercentStr doubleValue]+[isfull doubleValue]+[percent doubleValue])*[_investmentHorizonStr doubleValue]/36500.0f;
                    NSInteger  percentStr = text *100;
                    double  resultStr = (double)percentStr/100;

                    InterestMoneyLabel.text  = [NSString stringWithFormat:@"%ld+%.2f",[BuyTextField.text integerValue]-[AddStr integerValue],resultStr+[AddStr integerValue]];
                    
                }else{
//                    float text =[BuyTextField.text integerValue] + [BuyTextField.text integerValue]*([_PercentStr doubleValue]/100+[isfull integerValue])*[_investmentHorizonStr doubleValue]/365.0f;
//                    float jifen = [BuyTextField.text integerValue]*[_investmentHorizonStr doubleValue]/3000;
//                    InterestMoneyLabel.text = [NSString stringWithFormat:@"%@+%.2f(积分:%.1f)",BuyTextField.text,(text*100)/100,(jifen*100)/100];
                    
                }
            }else{
                
            }
        }else{
            
        }
    }else{
        if (Type == 1) {
            float text =[BuyTextField.text integerValue]*([_PercentStr doubleValue]+[AddStr doubleValue]+[percent doubleValue])*[_investmentHorizonStr doubleValue]/36500.0f;
            NSInteger  percentStr = text *100;
            double  resultStr = (double)percentStr/100;
            InterestMoneyLabel.text  = [NSString stringWithFormat:@"%ld+%.2f",[BuyTextField.text integerValue],resultStr];
        }else if(Type ==2){
            float text = [BuyTextField.text integerValue]*([_PercentStr doubleValue]+[percent doubleValue])*[_investmentHorizonStr doubleValue]/36500.0f;
            NSInteger  percentStr = text *100;
            double  resultStr = (double)percentStr/100;

            InterestMoneyLabel.text  = [NSString stringWithFormat:@"%.2f+%.2f",[BuyTextField.text integerValue]-[AddStr doubleValue],resultStr+[AddStr integerValue]];
            
        }else{
//            float text =[BuyTextField.text integerValue] + [BuyTextField.text integerValue]*([_PercentStr doubleValue]/100)*[_investmentHorizonStr doubleValue]/365.0f;
//            float jifen = [BuyTextField.text integerValue]*[_investmentHorizonStr doubleValue]/3000;
//            InterestMoneyLabel.text = [NSString stringWithFormat:@"%@+%.2f(积分:%.1f)",BuyTextField.text,(text*100)/100,(jifen*100)/100];
            
        }
    }
    

    
    
    


}
- (void)emptyStage{
    NSString *  isfull;
    isfull = [NSString stringWithFormat:@"%.2f",[_fullScaleReward doubleValue]];
    if ([BuyTextField.text integerValue] == [_TotalStr integerValue]) {
        if ([_isFullScaleReward integerValue] == 1  ) {
            if ([_fullScaleReward doubleValue]) {
                
                float text = [BuyTextField.text integerValue]*([_PercentStr doubleValue]+[isfull doubleValue]+[percent doubleValue])*[_investmentHorizonStr doubleValue]/36500.0f;
                NSInteger  percentStr = text *100;
                double  resultStr = (double)percentStr/100;

                NSInteger jifenStr =[_investmentHorizonStr integerValue]/30;
                float jifen = [BuyTextField.text integerValue]*jifenStr/100;
                InterestMoneyLabel.text = [NSString stringWithFormat:@"%@+%.2f(积分:%.1f)",BuyTextField.text,resultStr,(jifen*1000)/1000];
                
                
            }
        }
    }else{
        float text =[BuyTextField.text integerValue]*(([_PercentStr doubleValue]+[percent doubleValue])/100*[_investmentHorizonStr doubleValue]/365.0f);
        NSInteger  percentStr = text *100;
        double  resultStr = (double)percentStr/100;

        NSInteger jifenStr =[_investmentHorizonStr integerValue]/30;
        float jifen = [BuyTextField.text integerValue]*jifenStr/100;
        InterestMoneyLabel.text = [NSString stringWithFormat:@"%@+%.2f(积分:%.1f)",BuyTextField.text,resultStr,(jifen*1000)/1000];
    }

}
- (void)refreshInvest{
    InterestMoneyLabel.text = nil;
    if ([_productCatiID integerValue] == 8) {
        float text = [BuyTextField.text integerValue]*[_PercentStr doubleValue]/100/365;
        NSInteger  percentStr = text *100;
        double  resultStr = (double)percentStr/100;

        InterestMoneyLabel.text  = [NSString stringWithFormat:@"%.2f",resultStr];
        
    }else if([_productCatiID integerValue] == 7){
        float text =[BuyTextField.text integerValue]*([_PercentStr doubleValue]*[_investmentHorizonStr doubleValue]/36500.0f);
        NSInteger  percentStr = text *100;
        double  resultStr = (double)percentStr/100;
        
        InterestMoneyLabel.text = [NSString stringWithFormat:@"%@+%.2f",BuyTextField.text,resultStr];
    }else{
        if (BuyTextField.text.length) {
            if (AddStr.length) {
                [self MyIsFull];
            }else{
                
                [self emptyStage];
    
    }
    
    
    
    
    
        }
    }
}
    


- (void)SaleCancelClick{
    [alertView dismissAnimated:NO];

}
- (void)SaleOnTap{
    //  返回指定页面
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[ProductDetailNewViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
}
//设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  [stageArray count];
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
    
    static NSString *identifier = @"StageMyidentifier";
    
    ChoiceStageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[ChoiceStageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell configUI:indexPath];
    }

    if (stageArray.count) {
        ChooseStageModel *model  = [stageArray objectAtIndex:indexPath.row];
        cell.stageModel = model;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *StageStr;
    if (indexPath.row == 0) {
        StageStr = @"";
        StageLabel.text = @"不使用道具";
        AddStr  = StageStr;
        StageOid   = @"-1";
        [self ConfigInverest];
        [self refreshInvest];

    }else{
        
        ChooseStageModel *model = [stageArray objectAtIndex:indexPath.row];
        StageChoseStr = model.minimumInvestmentAmount;
        
        switch ([model.type integerValue]) {
            case 1:
                Type = 1;
                StageStr = [NSString stringWithFormat:@"%@%%%@",model.value,model.name];
   
                break;
            case  2:
                Type =2;
                StageStr = [NSString stringWithFormat:@"%@元%@",model.value,model.name];
                break;

            case 3:
                Type =2;
                StageStr = [NSString stringWithFormat:@"%@元%@",model.value,model.name];
                break;
            case 4:
                Type =2;
                StageStr = [NSString stringWithFormat:@"%@元%@",model.value,model.name];
                break;
            default:
                break;
        }
        switch ([model.type integerValue]) {
            case 1:
                Type = 1;
                AddStr  = [NSString stringWithFormat:@"%@",model.value];
                break;
                
            case 2:
                Type = 2;
                AddStr  = [NSString stringWithFormat:@"%@",model.value];
                break;
            case 3:
                Type =2;
                AddStr  = [NSString stringWithFormat:@"%@",model.value];
                break;
            case 4:
                Type =2;
                AddStr  = [NSString stringWithFormat:@"%@",model.value];
                break;
                break;
            default:
                break;
        }
        NSLog(@" --- %@",AddStr);
        StageOid =  [NSString stringWithFormat:@"%@",model.oid];
        StageLabel.text = StageStr;
    }
    
    [self ConfigInverest];
    [self refreshInvest];
    [alertView dismissAnimated:NO];

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
