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

@interface SaleViewController ()<UITableViewDelegate,UITableViewDelegate>{
    
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
    
    
    
    UILabel *StageLabel;
    
    AwAlertView *alertView;
    UITableView *StageTableView;

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
    
}

- (void)ConfigUI{
    TopView = [[UIView alloc]init];
    TopView.backgroundColor = colorWithRGB(0.28, 0.46, 0.91);
    [self.view addSubview:TopView];
    [TopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top);
        make.left.mas_equalTo(self.view.mas_left);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(200);
    }];
    TitleLabel = [[UILabel alloc]init];
    TitleLabel.text = @"米3－新密计划第一期";
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
    MoneyPercentLabel.text = @"23.34%";
    MoneyPercentLabel.textColor = [UIColor whiteColor];
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
    
    AddMoneyLabel = [[UILabel alloc]init];
    AddMoneyLabel.backgroundColor = colorWithRGB(0.95, 0.60, 0.11);
    AddMoneyLabel.textColor = [UIColor whiteColor];
    AddMoneyLabel.font = [UIFont systemFontOfSize:12];
    AddMoneyLabel.text = @"+1000000元";
    AddMoneyLabel.textAlignment = NSTextAlignmentLeft;
    [TopView addSubview:AddMoneyLabel];
    [AddMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MoneyPercentLabel.mas_right);
        make.top.mas_equalTo(TitleLabel.mas_bottom);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(20);
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
    MoneyLeftLbel.text = @"23123213元";
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
    StageLabel.text = @"%23加息卷";
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
    
    UITextField *BuyTextField = [[UITextField alloc]init];
    BuyTextField.backgroundColor = [UIColor whiteColor];
    BuyTextField.font = [UIFont systemFontOfSize:12];
    BuyTextField.textAlignment = NSTextAlignmentLeft;
    BuyTextField.placeholder = @"请输入对应信息";
    [SaleView addSubview:BuyTextField];
    [BuyTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(SaleView.mas_centerY);
        make.left.mas_equalTo(buyLabel.mas_right);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    }];
    
    AgreementLabel = [[UILabel alloc]init];
    AgreementLabel.text = @"我同意《服务协议》";
    AgreementLabel.textColor = [UIColor blackColor];
    AgreementLabel.font = [UIFont systemFontOfSize:12];
    AgreementLabel.textAlignment = NSTextAlignmentLeft;
    [BootmView addSubview:AgreementLabel];
    [AgreementLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(BootmView.mas_left).offset(40);
        make.top.mas_equalTo(SaleView.mas_bottom).offset(20);
        make.width.mas_equalTo(140);
        make.height.mas_equalTo(20);
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
        make.top.mas_equalTo(AgreementLabel.mas_bottom).offset(20);
        make.width.mas_equalTo(SCREEN_WIDTH - 80);
        make.height.mas_equalTo(40);
    }];
    
    UITapGestureRecognizer *SaleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SaleBtn
                                                                                                          )];
    [SaleLabel addGestureRecognizer:SaleTap];
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
    NSLog(@"道具选择");
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
