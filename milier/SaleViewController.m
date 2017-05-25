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

@interface SaleViewController ()<UITableViewDelegate,UITableViewDelegate,UITextFieldDelegate>{
    
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
    
    UILabel *TotalMoneyLabel;
    UILabel *AgreementLabel;
    
    UILabel *SaleLabel;
    
    
    UILabel *interestLabel;
    UILabel *StageLabel;
    
    AwAlertView *alertView;
    UITableView *StageTableView;
    NSString *AddStr;
    UIButton *ClickBtn;
    
    
    UITextField *BuyTextField;
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
    
    [self ConfigUI];
    [self ConfigInverest];
}

- (void)ConfigUI{
    TopView = [[UIView alloc]init];
    TopView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(HideKeyBoardClick)];
    [TopView addGestureRecognizer:tap];
    TopView.backgroundColor = colorWithRGB(0.28, 0.46, 0.91);
    [self.view addSubview:TopView];
    [TopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top);
        make.left.mas_equalTo(self.view.mas_left);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(200);
    }];
    TitleLabel = [[UILabel alloc]init];
    TitleLabel.text = _NameStr;
    TitleLabel.font = [UIFont systemFontOfSize:13];
    TitleLabel.textColor = [UIColor whiteColor];
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
    MoneyPercentLabel.textColor = [UIColor whiteColor];
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
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor whiteColor];
    [TopView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(TopView.mas_left).offset(10);
        make.top.mas_equalTo(MoneyPercentLabel.mas_bottom).offset(60);
        make.width.mas_equalTo(SCREEN_WIDTH - 20);
        make.height.mas_equalTo(0.5);
    }];
    
    LeftLabel = [[UILabel alloc]init];
    LeftLabel.text = @"剩余额度";
    LeftLabel.textColor = [UIColor whiteColor];
    LeftLabel.font = [UIFont systemFontOfSize:12];
    [TopView addSubview:LeftLabel];
    [LeftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(TopView.mas_left).offset(20);
        make.top.mas_equalTo(lineView.mas_bottom).offset(10);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(20);
    }];
    
    MoneyLeftLbel = [[UILabel alloc]init];
    
    NSString *totalStr = [NSString stringWithFormat:@"%@",_TotalStr];
    double totalDouble = [totalStr doubleValue];
    
    NSString *sellStr = [NSString stringWithFormat:@"%@",_SellStr];
    double sellDouble = [sellStr doubleValue];
        MoneyLeftLbel.text = [NSString stringWithFormat:@"%.2f元",totalDouble - sellDouble];
    MoneyLeftLbel.textColor = [UIColor whiteColor];
    MoneyLeftLbel.textAlignment = NSTextAlignmentRight;
    MoneyLeftLbel.font = [UIFont systemFontOfSize:12];
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

    BootmView.backgroundColor = colorWithRGB(0.92, 0.92, 0.92);
    [self.view addSubview:BootmView];
    [BootmView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(TopView.mas_bottom);
        make.left.mas_equalTo(self.view.mas_left);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(SCREEN_HEIGHT-240);
    }];
    
    ExplainLabel = [[UILabel alloc]init];
    ExplainLabel.text = @"注：若支付失败道具将在15分钟内返还";
    ExplainLabel.textColor =  colorWithRGB(0.28, 0.46, 0.91);
    ExplainLabel.textAlignment = NSTextAlignmentCenter;
    ExplainLabel.font = [UIFont systemFontOfSize:11];
    [BootmView addSubview:ExplainLabel];
    [ExplainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(BootmView.mas_centerX);
        make.top.mas_equalTo(BootmView.mas_top).offset(10);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(20);
    }];
    
    ChoceStageView = [[UIView alloc]init];
    ChoceStageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *choiceTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(MyChoceClcik)];
    [ChoceStageView addGestureRecognizer:choiceTap];
    ChoceStageView.backgroundColor = [UIColor whiteColor];
    [BootmView addSubview:ChoceStageView];
    [ChoceStageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(BootmView.mas_left).offset(20);
        make.top.mas_equalTo(ExplainLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH - 40);
        make.height.mas_equalTo(40);
    }];
    
    UIImageView *ChoceImageView = [[UIImageView alloc]init];
    ChoceImageView.image = [UIImage imageNamed:@"tool"];
    [ChoceStageView addSubview:ChoceImageView];
    [ChoceImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(ChoceStageView.mas_centerY);
        make.left.mas_equalTo(ChoceStageView.mas_left).offset(10);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    
    interestLabel = [[UILabel alloc]init];
    
    
    
    UILabel *choceLabel = [[UILabel alloc]init];
    choceLabel.text  = @"选择道具";
    choceLabel.font = [UIFont systemFontOfSize:12];
    [ChoceStageView addSubview:choceLabel];
    [choceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(ChoceStageView.mas_centerY);
        make.left.mas_equalTo(ChoceImageView.mas_right).offset(10);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(20);
    }];
    StageLabel = [[UILabel alloc]init];
    StageLabel.textColor = colorWithRGB(0.80, 0.80, 0.80);
    if (AddStr.length) {
        StageLabel.text = AddStr;

    }else{
        StageLabel.text = @"请选择道具";
  
    }
    StageLabel.font = [UIFont systemFontOfSize:12];
    [ChoceStageView addSubview:StageLabel];
    [StageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(ChoceStageView.mas_centerY);
        make.left.mas_equalTo(choceLabel.mas_right);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);

    }];
    
    
    
    SaleView = [[UIView alloc]init];
    SaleView.backgroundColor = [UIColor whiteColor];
    [BootmView addSubview:SaleView];
    [SaleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(BootmView.mas_left).offset(20);
        make.top.mas_equalTo(ChoceStageView.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH - 40);
        make.height.mas_equalTo(40);
    }];
    UIImageView *BuyImageView = [[UIImageView alloc]init];
    BuyImageView.image = [UIImage imageNamed:@"buy"];
    [SaleView addSubview:BuyImageView];
    [BuyImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(SaleView.mas_centerY);
        make.left.mas_equalTo(SaleView.mas_left).offset(10);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    UILabel *buyLabel = [[UILabel alloc]init];
    buyLabel.text  = @"购买金额";
    buyLabel.font = [UIFont systemFontOfSize:12];
    [SaleView addSubview:buyLabel];
    [buyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(SaleView.mas_centerY);
        make.left.mas_equalTo(BuyImageView.mas_right).offset(10);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(20);
    }];
    
    BuyTextField = [[UITextField alloc]init];
    BuyTextField.backgroundColor = [UIColor whiteColor];
    BuyTextField.font = [UIFont systemFontOfSize:12];
    BuyTextField.textAlignment = NSTextAlignmentLeft;
    BuyTextField.keyboardType = UIKeyboardTypeNumberPad;
    BuyTextField.delegate = self;
    BuyTextField.placeholder = @"请输入购买金额";
    [SaleView addSubview:BuyTextField];
    [BuyTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(SaleView.mas_centerY);
        make.left.mas_equalTo(buyLabel.mas_right);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    }];
    
    interestLabel = [[UILabel alloc]init];
    interestLabel.backgroundColor = colorWithRGB(0.95, 0.6, 0.11);
    interestLabel.font = [UIFont systemFontOfSize:10];
    interestLabel.textColor = [UIColor whiteColor];
    interestLabel.text = @"  预计本息(元):";
    [BootmView addSubview:interestLabel];
    [interestLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(BootmView.mas_left).offset(20);
        make.top.mas_equalTo(SaleView.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH - 40);
        make.height.mas_equalTo(30);
 
    }];
    
    
    
    ClickBtn = [[UIButton alloc]init];
    [ClickBtn setBackgroundImage:[UIImage imageNamed:@"uncheck_box"] forState:UIControlStateNormal];
    ClickBtn.selected = YES;
    [ClickBtn setBackgroundImage:[UIImage imageNamed:@"check_box"] forState:UIControlStateSelected];
    [ClickBtn addTarget:self action:@selector(Saleclicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ClickBtn];
    [ClickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.top.mas_equalTo(interestLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    UILabel *nameLabel =[[UILabel alloc]init];
    nameLabel.font = [UIFont systemFontOfSize:15];
    NSMutableAttributedString *ConnectStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"我同意《服务协议》"]];
    NSRange conectRange = {4,4};
    [ConnectStr addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:conectRange];
    nameLabel.attributedText = ConnectStr;
    nameLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *gesTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(saleConnectClick)];
    [nameLabel addGestureRecognizer:gesTap];
    [self.view addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ClickBtn.mas_right).offset(10);
        make.top.mas_equalTo(interestLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(30);
    }];

    
    SaleLabel = [[UILabel alloc]init];
    SaleLabel.text = @"购买";
    SaleLabel.userInteractionEnabled = YES;
    SaleLabel.backgroundColor = colorWithRGB(0.28, 0.46, 0.91);
    SaleLabel.textAlignment = NSTextAlignmentCenter;
    SaleLabel.textColor = [UIColor whiteColor];
    SaleLabel.layer.cornerRadius = 10;
    SaleLabel.layer.masksToBounds = YES;
    [BootmView addSubview:SaleLabel];
    [SaleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(BootmView.mas_left).offset(40);
        make.top.mas_equalTo(interestLabel.mas_bottom).offset(50);
        make.width.mas_equalTo(SCREEN_WIDTH - 80);
        make.height.mas_equalTo(40);
    }];
    
    UITapGestureRecognizer *SaleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SaleBtn
                                                                                                          )];
    [SaleLabel addGestureRecognizer:SaleTap];
}
- (void)saleConnectClick{
    //协议
}
- (void)Saleclicked:(UIButton *)btn{
    if (btn.selected) {
        btn.selected = NO;
    }else{
        btn.selected = YES;
    }
}
- (void)ConfigInverest{
    AddMoneyLabel = [[UILabel alloc]init];
    AddMoneyLabel.backgroundColor = colorWithRGB(0.95, 0.60, 0.11);
    AddMoneyLabel.textColor = [UIColor whiteColor];
    AddMoneyLabel.font = [UIFont systemFontOfSize:12];
    CGSize size =CGSizeMake(400,20);
    if (AddStr.length) {
        AddMoneyLabel.hidden = NO;
        AddMoneyLabel.text =[NSString stringWithFormat:@"+%@",AddStr];
        NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:12],NSFontAttributeName,nil];
        CGSize  actualsize =[AddMoneyLabel.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin  attributes:tdic context:nil].size;
        AddMoneyLabel.textAlignment = NSTextAlignmentLeft;
        [TopView addSubview:AddMoneyLabel];

        [AddMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(MoneyPercentLabel.mas_right);
            make.top.mas_equalTo(TitleLabel.mas_bottom);
            make.width.mas_equalTo(actualsize.width);
            make.height.mas_equalTo(20);
        }];
    }else{
        AddMoneyLabel.hidden = YES;
    }
   
    
  
}
- (void)SaleBtn{
    
//未登录
    //YWDLoginViewController *LoginVC = [[YWDLoginViewController alloc]init];
    //[self.navigationController pushViewController:LoginVC animated:NO];
    //未设置交易密码
    SalePassWordViewController *SaleVC = [[SalePassWordViewController alloc]init];
    [self.navigationController   pushViewController:SaleVC animated:NO];
//余额充足
//    PayViewController *PayVC = [[PayViewController alloc]init];
//    [self.navigationController   pushViewController:PayVC animated:NO];

    //余额不足
    
}
- (void)MyChoceClcik{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 280)];
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
    [self refreshInvest];
}


- (void)refreshInvest{
    if (BuyTextField.text.length) {
        if (AddStr.length) {
            NSString *  isfull;
            if ([BuyTextField.text integerValue] == [_TotalStr integerValue]) {
                if ([_isFullScaleReward integerValue] == 1) {
                    if ([_fullScaleReward doubleValue]) {
                        isfull = [NSString stringWithFormat:@"%.2f",[_fullScaleReward doubleValue]];
                        if (isfull.length) {
                            interestLabel.text =[NSString stringWithFormat:@"  预计本息(元)1：%@+%@*(%@+%@+%@)+%@/365",BuyTextField.text,BuyTextField.text,_PercentStr,AddStr,
                                                 isfull,_investmentHorizonStr] ;
                        }
                    }else{
                        interestLabel.text =[NSString stringWithFormat:@"  预计本息(元)2：%@+%@*(%@+%@)+%@/365",BuyTextField.text,BuyTextField.text,_PercentStr,AddStr,_investmentHorizonStr] ;
                    }
                    
                    
                }
            }else{
                if (AddStr.length) {
                    interestLabel.text =[NSString stringWithFormat:@"  预计本息(元)4：%@+%@*(%@+%@)+%@/365",BuyTextField.text,BuyTextField.text,_PercentStr,AddStr,_investmentHorizonStr] ;
                }else{
                  interestLabel.text =[NSString stringWithFormat:@"  预计本息(元)5：%@+%@*%@+%@/365",BuyTextField.text,BuyTextField.text,_PercentStr,_investmentHorizonStr] ;
                }
                
              
            }
            
            
            
         
   
            
        }else{
             interestLabel.text =[NSString stringWithFormat:@"  预计本息(元)3：%@+%@*%@+%@/365",BuyTextField.text,BuyTextField.text,_PercentStr,_investmentHorizonStr] ;
        }
        　NSLog(@"a= %@",AddStr);
        
        NSLog(@" 1== %@",_isFullScaleReward);
        
        NSLog(@" 2== %@",_fullScaleReward);
        
        NSLog(@" 3== %@",_PercentStr);
        NSLog(@"4 == %@",_TotalStr);

        NSLog(@" 5== %@",_SellStr);
        NSLog(@"6 == %@",BuyTextField.text);

        
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
    return  30;
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
    
    static NSString *identifier = @"oldidentifier";
    
    ChoiceStageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[ChoiceStageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell configUI:indexPath];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *StageStr = @"10000";
    AddStr  = StageStr;
    StageLabel.text = AddStr;
    [self ConfigInverest];
    [self refreshInvest];
    [alertView dismissAnimated:NO];

    //    SectionViewController *sVC = [[SectionViewController alloc] init];
    //    sVC.rowLabelText = [NSString stringWithFormat:@"第%ld组的第%ld个cell",(long)indexPath.section,(long)indexPath.row];
    //    [self presentViewController:sVC animated:YES completion:nil];
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
