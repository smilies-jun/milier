//
//  UserViewController.m
//  milier
//
//  Created by amin on 17/4/20.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "UserViewController.h"
#import "SecondViewController.h"
#import "ZFChart.h"
#import "UserSetViewController.h"
#import "JinMiDetdailViewController.h"
#import "DinQiDeatilViewController.h"
#import "MyLeftViewController.h"
#import "MyJiFenViewController.h"
#import "ChangeSailViewController.h"
#import "MyStageViewController.h"
#import "ShareViewController.h"
#import "RiskViewController.h"

@interface UserViewController ()<ZFCirqueChartDataSource, ZFCirqueChartDelegate>{
    UIScrollView *MyScrollView;
    
    UIView *TopView;
    UIImageView *UserImageView;
    UILabel *UserLabel;
    UILabel *PhoneLabel;
    UILabel *VipLabel;
    UIImageView *ArrowLabel;
    UILabel *MoneyLabel;
    UILabel *MoneyNumberLabel;
    //金米
    UIImageView *JinMiImageView;
    UILabel *JinMiLabel;
    UILabel *JinMiNumber;
    UILabel *JinMiOldNumber;
    UILabel *JinMiDetailLabel;
    //定期投资
    UIImageView *DinQiImageView;
    UILabel *DinQiLabel;
    UILabel *DinQiNumber;
    UILabel *DinQidOldNumber;
    UILabel *DinQiDetailLabel;
    //我的余额
    UIImageView *MyLeftMoneyImageView;
    UILabel *MyLeftMoneyLabel;
    UILabel *MyLeftMoneyNumberLabel;
    //我的积分
    UIImageView *MyJiFenImageView;
    UILabel *MyJiFenLabel;
    UILabel *MyJifenNmberLabel;
    //债券转让
    UIImageView *ChangeImageView;
    UILabel *ChangeLabel;
    //我的道具
    UIImageView *MyStageImageView;
    UILabel *MyStageLabel;
    //分享邀请
    UIImageView *ShareImageView;
    UILabel *ShareLabel;
    //风险评估
    UIImageView *DangerTestImageView;
    UILabel *DangerTestLabel;
    
    
    
}
@property (nonatomic, strong) ZFCirqueChart * cirqueChart;

@property (nonatomic, assign) CGFloat height;
@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的";
    self.view.backgroundColor = [UIColor grayColor];
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(0, 7, 18, 18);
    [leftBtn setImage:[UIImage imageNamed:@"backarrow@2x.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(UserBackClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;

    [self ConfigUI];
}
- (void)ConfigUI{
    MyScrollView = [[UIScrollView alloc]init];
    MyScrollView.backgroundColor = [UIColor whiteColor];
    MyScrollView.showsVerticalScrollIndicator = NO;
    MyScrollView.showsHorizontalScrollIndicator = NO;
    MyScrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    MyScrollView.contentSize = CGSizeMake(0, SCREEN_HEIGHT+160);
    [self.view addSubview:MyScrollView];
    TopView = [[UIView alloc]init];
    TopView.userInteractionEnabled = YES;
    UITapGestureRecognizer *TopUserTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TopClick)];
    [TopView addGestureRecognizer:TopUserTap];
    TopView.backgroundColor = [UIColor greenColor];
    [MyScrollView addSubview:TopView];
    [TopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MyScrollView.mas_left);
        make.top.mas_equalTo(MyScrollView.mas_top);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(64);
    }];
    UserImageView = [[UIImageView alloc]init];
    UserImageView.image = [UIImage imageNamed:@"head"];
    [TopView addSubview:UserImageView];
    [UserImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(TopView.mas_left).offset(10);
        make.centerY.mas_equalTo(TopView.mas_centerY);
        make.width.mas_equalTo(28);
        make.height.mas_equalTo(28);
    }];
    
    UserLabel = [[UILabel alloc]init];
    UserLabel.text = @"阿萨德wew";
    UserLabel.font = [UIFont systemFontOfSize:12];
    [TopView addSubview:UserLabel];
    [UserLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(UserImageView.mas_right).offset(10);
        make.top.mas_equalTo(TopView.mas_top).offset(20);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(10);
    }];
    PhoneLabel = [[UILabel alloc]init];
    PhoneLabel.text= @"1511123213123";
    PhoneLabel.font = [UIFont systemFontOfSize:13];
    [TopView addSubview:PhoneLabel];
    [PhoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(UserImageView.mas_right).offset(10);
        make.top.mas_equalTo(UserLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(10);
    }];
    
    self.cirqueChart = [[ZFCirqueChart alloc] initWithFrame:CGRectMake(65, 64, 100, 100)];
    self.cirqueChart.dataSource = self;
    self.cirqueChart.delegate = self;
    self.cirqueChart.textLabel.hidden = YES;
    //self.cirqueChart.textLabel.backgroundColor = ZFOrange;
//    self.cirqueChart.textLabel.text = [NSString stringWithFormat:@"%.f%%",(6500.f / 10000.f) * 100];
//    self.cirqueChart.textLabel.textColor = ZFRed;
//    self.cirqueChart.textLabel.font = [UIFont boldSystemFontOfSize:12.f];
    self.cirqueChart.isResetMaxValue = YES;
    //    self.cirqueChart.isAnimated = NO;
    self.cirqueChart.cirquePatternType = kCirquePatternTypeForDefault;
    //    self.cirqueChart.cirqueStartOrientation = kCirqueStartOrientationOnRight;
    [MyScrollView addSubview:self.cirqueChart];
    [self.cirqueChart strokePath];
    
    MoneyLabel = [[UILabel alloc]init];
    MoneyLabel.text = @"在投资产";
    MoneyLabel.textColor = ZFGray;
    MoneyLabel.font =  [UIFont systemFontOfSize:14];
    [MyScrollView addSubview:MoneyLabel];
    [MoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(MyScrollView.mas_centerX);
        make.top.mas_equalTo(TopView.mas_bottom).offset(60);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(20);
    }];
    
    MoneyNumberLabel = [[UILabel alloc]init];
    MoneyNumberLabel.text = @"2762633.99";
    MoneyNumberLabel.font = [UIFont systemFontOfSize:30];
    MoneyNumberLabel.textAlignment = NSTextAlignmentCenter;
    MoneyNumberLabel.textColor = [UIColor blackColor];
    [MyScrollView addSubview:MoneyNumberLabel];
    [MoneyNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(MyScrollView.mas_centerX);
        make.top.mas_equalTo(MoneyLabel.mas_bottom).offset(20);
        make.width.mas_equalTo(220);
        make.height.mas_equalTo(40);
        
    }];
    
    JinMiImageView = [[UIImageView alloc]init];
    JinMiImageView.backgroundColor = [UIColor orangeColor];
    [MyScrollView addSubview:JinMiImageView];
    [JinMiImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(TopView.mas_left).offset(50);
        make.top.mas_equalTo(TopView.mas_bottom).offset(250);
        make.width.mas_equalTo(10);
        make.height.mas_equalTo(20);
    }];
    
    JinMiLabel = [[UILabel alloc]init];
    JinMiLabel.text = @"金米宝";
    JinMiLabel.textColor = [UIColor orangeColor];
    JinMiLabel.font = [UIFont systemFontOfSize:15];
    [MyScrollView addSubview:JinMiLabel];
    [JinMiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(JinMiImageView.mas_right).offset(5);
        make.centerY.mas_equalTo(JinMiImageView.mas_centerY);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(30);
    }];
    
    JinMiNumber = [[UILabel alloc]init];
    JinMiNumber.text = @"¥200000";
    JinMiNumber.font = [UIFont systemFontOfSize:16];
    JinMiNumber.textColor = [UIColor blackColor];
    [MyScrollView addSubview:JinMiNumber];
    [JinMiNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(TopView.mas_left).offset(50);
        make.top.mas_equalTo(JinMiImageView.mas_bottom).offset(5);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(30);
    }];
    JinMiOldNumber = [[UILabel alloc]init];
    JinMiOldNumber.text = @"昨日收益：1.23";
    JinMiOldNumber.textAlignment = NSTextAlignmentLeft;
    JinMiOldNumber.font = [UIFont systemFontOfSize:14];
    JinMiOldNumber.textColor = [UIColor blackColor];
    [MyScrollView addSubview:JinMiOldNumber];
    [JinMiOldNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(TopView.mas_left).offset(50);
        make.top.mas_equalTo(JinMiNumber.mas_bottom).offset(5);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    }];
    JinMiDetailLabel = [[UILabel alloc]init];
    JinMiDetailLabel.text = @"详情";
    JinMiDetailLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer*JinmiTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(jinmiClick)];
    [JinMiDetailLabel addGestureRecognizer:JinmiTap];
    JinMiDetailLabel.layer.borderColor = ZFOrange.CGColor;
    JinMiDetailLabel.layer.borderWidth = 0.5f;
    JinMiDetailLabel.layer.masksToBounds = YES;
    JinMiDetailLabel.layer.cornerRadius = 5;
    JinMiDetailLabel.textAlignment = NSTextAlignmentCenter;
    JinMiDetailLabel.textColor = [UIColor orangeColor];
    JinMiDetailLabel.font = [UIFont systemFontOfSize:14];
    [MyScrollView addSubview:JinMiDetailLabel];
    [JinMiDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(JinMiLabel.mas_centerX);
        make.top.mas_equalTo(JinMiOldNumber.mas_bottom).offset(5);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(20);
    }];
    
    DinQiImageView = [[UIImageView alloc]init];
    DinQiImageView.backgroundColor = [UIColor orangeColor];
    [MyScrollView addSubview:DinQiImageView];
    [DinQiImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(TopView.mas_right).offset(-150);
        make.top.mas_equalTo(TopView.mas_bottom).offset(250);
        make.width.mas_equalTo(10);
        make.height.mas_equalTo(20);
    }];
    
    DinQiLabel = [[UILabel alloc]init];
    DinQiLabel.text = @"定期投资";
    DinQiLabel.textColor = [UIColor orangeColor];
    DinQiLabel.font = [UIFont systemFontOfSize:15];
    [MyScrollView addSubview:DinQiLabel];
    [DinQiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(DinQiImageView.mas_right).offset(5);
        make.centerY.mas_equalTo(DinQiImageView.mas_centerY);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(30);
    }];
    
    DinQiNumber = [[UILabel alloc]init];
    DinQiNumber.text = @"¥200000";
    DinQiNumber.font = [UIFont systemFontOfSize:16];
    DinQiNumber.textColor = [UIColor blackColor];
    [MyScrollView addSubview:DinQiNumber];
    [DinQiNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(TopView.mas_right).offset(-150);
        make.top.mas_equalTo(DinQiImageView.mas_bottom).offset(5);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(30);
    }];
    DinQidOldNumber = [[UILabel alloc]init];
    DinQidOldNumber.text = @"昨日收益：1.23";
    DinQidOldNumber.textAlignment = NSTextAlignmentLeft;
    DinQidOldNumber.font = [UIFont systemFontOfSize:14];
    DinQidOldNumber.textColor = [UIColor blackColor];
    [MyScrollView addSubview:DinQidOldNumber];
    [DinQidOldNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(TopView.mas_right).offset(-150);
        make.top.mas_equalTo(DinQiNumber.mas_bottom).offset(5);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    }];
    DinQiDetailLabel = [[UILabel alloc]init];
    DinQiDetailLabel.text = @"详情";
    DinQiDetailLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer*DinQiTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(DinQiClick)];
    [DinQiDetailLabel addGestureRecognizer:DinQiTap];
    DinQiDetailLabel.layer.borderColor = ZFOrange.CGColor;
    DinQiDetailLabel.layer.borderWidth = 0.5f;
    DinQiDetailLabel.layer.masksToBounds = YES;
    DinQiDetailLabel.layer.cornerRadius = 5;
    DinQiDetailLabel.textAlignment = NSTextAlignmentCenter;
    DinQiDetailLabel.textColor = [UIColor orangeColor];
    DinQiDetailLabel.font = [UIFont systemFontOfSize:14];
    [MyScrollView addSubview:DinQiDetailLabel];
    [DinQiDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(DinQiLabel.mas_centerX);
        make.top.mas_equalTo(DinQidOldNumber.mas_bottom).offset(5);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(20);
    }];
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor =[UIColor grayColor];
    [MyScrollView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MyScrollView.mas_left);
        make.top.mas_equalTo(DinQiDetailLabel.mas_bottom).offset(20);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(5);
    }];
    MyLeftMoneyImageView = [[UIImageView alloc]init];
    MyLeftMoneyImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *YueTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(LeftClick)];
    [MyLeftMoneyImageView addGestureRecognizer:YueTap];
    MyLeftMoneyImageView.image = [UIImage imageNamed:@"portfolio"];
    [MyScrollView addSubview:MyLeftMoneyImageView];
    [MyLeftMoneyImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MyScrollView.mas_left).offset(40);
        make.top.mas_equalTo(DinQiDetailLabel.mas_bottom).offset(40);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(60);
    }];
    MyLeftMoneyLabel = [[UILabel alloc]init];
    MyLeftMoneyLabel.text =  @"我的余额";
    MyLeftMoneyLabel.textAlignment = NSTextAlignmentCenter;
    MyLeftMoneyLabel.textColor = [UIColor grayColor];
    MyLeftMoneyLabel.font = [UIFont systemFontOfSize:12];
    [MyScrollView addSubview:MyLeftMoneyLabel];
    [MyLeftMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(MyLeftMoneyImageView.mas_centerX);
        make.top.mas_equalTo(MyLeftMoneyImageView.mas_bottom).offset(5);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(20);
    }];
    MyLeftMoneyNumberLabel = [[UILabel alloc]init];
    MyLeftMoneyNumberLabel.text = @"23232.89";
    MyLeftMoneyNumberLabel.textColor = [UIColor orangeColor];
    MyLeftMoneyNumberLabel.font = [UIFont systemFontOfSize:12];
    MyLeftMoneyNumberLabel.textAlignment = NSTextAlignmentCenter;
    [MyScrollView addSubview:MyLeftMoneyNumberLabel];
    [MyLeftMoneyNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(MyLeftMoneyImageView.mas_centerX);
        make.top.mas_equalTo(MyLeftMoneyLabel.mas_bottom);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(15);
    }];
    
    
    MyJiFenImageView = [[UIImageView alloc]init];
    MyJiFenImageView.image = [UIImage imageNamed:@"star"];
    MyJiFenImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *JiFenTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(JiFenClick)];
    [MyJiFenImageView addGestureRecognizer:JiFenTap];
    [MyScrollView addSubview:MyJiFenImageView];
    [MyJiFenImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MyLeftMoneyImageView.mas_right).offset(60);
        make.top.mas_equalTo(DinQiDetailLabel.mas_bottom).offset(40);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(60);
    }];
    MyJiFenLabel   = [[UILabel alloc]init];
    MyJiFenLabel.text =  @"我的积分";
    MyJiFenLabel.textAlignment = NSTextAlignmentCenter;
    MyJiFenLabel.textColor = [UIColor grayColor];
    MyJiFenLabel.font = [UIFont systemFontOfSize:12];
    [MyScrollView addSubview:MyJiFenLabel];
    [MyJiFenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(MyJiFenImageView.mas_centerX);
        make.top.mas_equalTo(MyJiFenImageView.mas_bottom).offset(5);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(20);
    }];
    
    MyJifenNmberLabel = [[UILabel alloc]init];
    MyJifenNmberLabel.text = @"23232.89";
    MyJifenNmberLabel.textColor = [UIColor orangeColor];
    MyJifenNmberLabel.font = [UIFont systemFontOfSize:12];
    MyJifenNmberLabel.textAlignment = NSTextAlignmentCenter;
    [MyScrollView addSubview:MyJifenNmberLabel];
    [MyJifenNmberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(MyJiFenImageView.mas_centerX);
        make.top.mas_equalTo(MyJiFenLabel.mas_bottom);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(15);
    }];
    
    
    ChangeImageView = [[UIImageView alloc]init];
    ChangeImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *ChangeTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeClick)];
    [ChangeImageView addGestureRecognizer:ChangeTap];
    ChangeImageView.image = [UIImage imageNamed:@"attorn"];
    [MyScrollView addSubview:ChangeImageView];
    [ChangeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MyJiFenImageView.mas_right).offset(60);
        make.top.mas_equalTo(DinQiDetailLabel.mas_bottom).offset(40);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(60);
    }];
    ChangeLabel = [[UILabel alloc]init];
    ChangeLabel.text =  @"债权转让";
    ChangeLabel.textAlignment = NSTextAlignmentCenter;
    ChangeLabel.textColor = [UIColor grayColor];
    ChangeLabel.font = [UIFont systemFontOfSize:12];
    [MyScrollView addSubview:ChangeLabel];
    [ChangeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ChangeImageView.mas_centerX);
        make.top.mas_equalTo(ChangeImageView.mas_bottom).offset(5);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(20);
    }];
    
    MyStageImageView = [[UIImageView alloc]init];
    MyStageImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *StageTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(StageClick)];
    [MyStageImageView addGestureRecognizer:StageTap];
    MyStageImageView.image = [UIImage imageNamed:@"diamond"];
    [MyScrollView addSubview:MyStageImageView];
    [MyStageImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MyScrollView.mas_left).offset(40);
        make.top.mas_equalTo(ChangeImageView.mas_bottom).offset(60);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(60);
    }];
    MyStageLabel = [[UILabel alloc]init];
    MyStageLabel.text =  @"我的道具";
    MyStageLabel.textAlignment = NSTextAlignmentCenter;
    MyStageLabel.textColor = [UIColor grayColor];
    MyStageLabel.font = [UIFont systemFontOfSize:12];
    [MyScrollView addSubview:MyStageLabel];
    [MyStageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(MyStageImageView.mas_centerX);
        make.top.mas_equalTo(MyStageImageView.mas_bottom).offset(5);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(20);
    }];
    ShareImageView = [[UIImageView alloc]init];
    ShareImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *ShareTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ShareClick)];
    [ShareImageView addGestureRecognizer:ShareTap];
    ShareImageView.image = [UIImage imageNamed:@"share"];
    [MyScrollView addSubview:ShareImageView];
    [ShareImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MyStageImageView.mas_right).offset(60);
        make.top.mas_equalTo(ChangeImageView.mas_bottom).offset(60);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(60);
    }];
    ShareLabel = [[UILabel alloc]init];
    ShareLabel.text =  @"分享邀请";
    ShareLabel.textAlignment = NSTextAlignmentCenter;
    ShareLabel.textColor = [UIColor grayColor];
    ShareLabel.font = [UIFont systemFontOfSize:12];
    [MyScrollView addSubview:ShareLabel];
    [ShareLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ShareImageView.mas_centerX);
        make.top.mas_equalTo(ShareImageView.mas_bottom).offset(5);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(20);
    }];
    DangerTestImageView = [[UIImageView alloc]init];
    DangerTestImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *DangerTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(DangerClick)];
    [DangerTestImageView addGestureRecognizer:DangerTap];

    DangerTestImageView.image = [UIImage imageNamed:@"security"];
    [MyScrollView addSubview:DangerTestImageView];
    [DangerTestImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ShareImageView.mas_right).offset(60);
        make.top.mas_equalTo(ChangeImageView.mas_bottom).offset(60);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(60);
    }];
    DangerTestLabel = [[UILabel alloc]init];
    DangerTestLabel.text =  @"风险评估";
    DangerTestLabel.textAlignment = NSTextAlignmentCenter;
    DangerTestLabel.textColor = [UIColor grayColor];
    DangerTestLabel.font = [UIFont systemFontOfSize:12];
    [MyScrollView addSubview:DangerTestLabel];
    [DangerTestLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(DangerTestImageView.mas_centerX);
        make.top.mas_equalTo(DangerTestImageView.mas_bottom).offset(5);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(20);
    }];
}
//金米宝详情
- (void)jinmiClick{
    JinMiDetdailViewController *SetVC = [[JinMiDetdailViewController alloc]init];
    [self.navigationController   pushViewController:SetVC animated:NO];
}
//定期详情
- (void)DinQiClick{
    DinQiDeatilViewController *SetVC = [[DinQiDeatilViewController alloc]init];
    [self.navigationController   pushViewController:SetVC animated:NO];
}
//余额
- (void)LeftClick{
    MyLeftViewController *LeftVC = [[MyLeftViewController alloc]init];
    [self.navigationController   pushViewController:LeftVC animated:NO];
}
//积分
-(void)JiFenClick{
    MyJiFenViewController *JiFenVC = [[MyJiFenViewController alloc]init];
    [self.navigationController   pushViewController:JiFenVC animated:NO];
}
//债券转让
- (void)changeClick{
    ChangeSailViewController *changeVC = [[ChangeSailViewController alloc]init];
    [self.navigationController   pushViewController:changeVC animated:NO];

}
//我的道具
- (void)StageClick{
    MyStageViewController *StageVC = [[MyStageViewController alloc]init];
    [self.navigationController   pushViewController:StageVC animated:NO];
}
//分享邀请
- (void)ShareClick{
    ShareViewController *ShareVC = [[ShareViewController alloc]init];
    [self.navigationController   pushViewController:ShareVC animated:NO];

}

//风险评估
- (void)DangerClick{
    RiskViewController *RiskVC = [[RiskViewController alloc]init];
    [self.navigationController   pushViewController:RiskVC animated:NO];
}
//帐号设置
- (void)TopClick{
    UserSetViewController *SetVC = [[UserSetViewController alloc]init];
    [self.navigationController   pushViewController:SetVC animated:NO];
}
- (void)UserBackClick{
    [self.navigationController   popToRootViewControllerAnimated:NO];
}

#pragma mark - ZFCirqueChartDataSource

- (NSArray *)valueArrayInCirqueChart:(ZFCirqueChart *)cirqueChart{
    return @[@"6500"];
}

- (id)colorArrayInCirqueChart:(ZFCirqueChart *)cirqueChart{
    return ZFGold;
    //    return @[ZFRed, ZFOrange, ZFMagenta, ZFBlue, ZFPurple];
}

- (CGFloat)maxValueInCirqueChart:(ZFCirqueChart *)cirqueChart{
    return 10000.f;
}

#pragma mark - ZFCirqueChartDelegate

- (CGFloat)radiusForCirqueChart:(ZFCirqueChart *)cirqueChart{
    return 110.f;
}

//- (CGFloat)paddingForCirqueInCirqueChart:(ZFCirqueChart *)cirqueChart{
//    return 40.f;
//}
//
//- (CGFloat)lineWidthInCirqueChart:(ZFCirqueChart *)cirqueChart{
//    return 15d.f;
//}


#pragma mark - 横竖屏适配(若需要同时横屏,竖屏适配，则添加以下代码，反之不需添加)

/**
 *  PS：size为控制器self.view的size，若图表不是直接添加self.view上，则修改以下的frame值
 */
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator{
    
    if ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeLeft || [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeRight){
        self.cirqueChart.frame = CGRectMake(0, 0, size.width, size.height - NAVIGATIONBAR_HEIGHT * 0.5);
        
    }else{
        self.cirqueChart.frame = CGRectMake(0, 0, size.width, size.height + NAVIGATIONBAR_HEIGHT * 0.5);
        
    }
    
    [self.cirqueChart strokePath];
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
