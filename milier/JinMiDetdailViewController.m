//
//  JinMiDetdailViewController.m
//  milier
//
//  Created by amin on 17/4/21.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "JinMiDetdailViewController.h"
#import "UserViewController.h"
#import "ProfilView.h"
#import "AddProfitViewController.h"

@interface JinMiDetdailViewController (){
    CAShapeLayer *ShapeLayer;
    CAShapeLayer *BackShapeLayer;
    
    UILabel *TitleLabel;
    UILabel *MoneyNumberLabel;
    UILabel *ProfileLabel;
    UILabel *StartLabel;
    UILabel *EndLabel;
    
    ProfilView *OldProfdilView;
    ProfilView *AddProfileView;
    ProfilView *PercentProfileView;
    
    UILabel *ComeLabel;
    UILabel *OutLabel;
    NSDictionary *jinmiDic;
}

@end

@implementation JinMiDetdailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"金米宝";
    self.view.backgroundColor = colorWithRGB(0.97, 0.97, 0.97);
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(0, 7, 18, 18);
    [leftBtn setImage:[UIImage imageNamed:@"backarrow@2x.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(JinMiClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    [self ConfigUI];

     [self getNetworkData:YES];
}
-(void)getNetworkData:(BOOL)isRefresh
{
    NSString *url;
    NSString *userID = NSuserUse(@"userId");
    NSString *tokenID = NSuserUse(@"Authorization");
    url = [NSString stringWithFormat:@"%@/%@/investmentStatistics?productCategoryId=8",USER_URL,userID];
    [[DateSource sharedInstance]requestHtml5WithParameters:nil  withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
        jinmiDic = [result objectForKey:@"data"];
        [self reloadData];
    }];
    

    
}

- (void)ConfigUI{
    UIView *TopView = [[UIView alloc]init];
    TopView.backgroundColor = [UIColor whiteColor];
    TopView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 200);
    [self.view addSubview:TopView];
    
//    ShapeLayer = [CAShapeLayer layer];
//    ShapeLayer.fillColor = [UIColor clearColor].CGColor;//填充颜色为ClearColor
//    //设置线条的宽度和颜色
//    ShapeLayer.lineWidth = 5.0f;
//    ShapeLayer.strokeColor = colorWithRGB(0.99, 0.79, 0.09).CGColor;
//    //创建出圆形贝塞尔曲线
//    UIBezierPath *circlePath =  [UIBezierPath bezierPathWithArcCenter:CGPointMake(TopView.centerX, TopView.centerY) radius:70 startAngle:0.75f*M_PI endAngle:0.25f*M_PI clockwise:YES];
//    
//    //让贝塞尔曲线与CAShapeLayer产生联系
//    ShapeLayer.path = circlePath.CGPath;
//    
//    //添加并显示
//    [TopView.layer addSublayer:ShapeLayer];
//    
//    BackShapeLayer = [CAShapeLayer layer];
//    BackShapeLayer.fillColor = [UIColor clearColor].CGColor;//填充颜色为ClearColor
//    //设置线条的宽度和颜色
//    BackShapeLayer.lineWidth = 5.0f;
//    BackShapeLayer.strokeColor = colorWithRGB(0.9, 0.9, 0.9).CGColor;
//    //创建出圆形贝塞尔曲线
//    UIBezierPath *backcirclePath =  [UIBezierPath bezierPathWithArcCenter:CGPointMake(TopView.centerX, TopView.centerY) radius:70 startAngle:0.75f*M_PI endAngle:1.5f*M_PI clockwise:YES];
//    
//    //让贝塞尔曲线与CAShapeLayer产生联系
//    BackShapeLayer.path = backcirclePath.CGPath;
//    
//    //添加并显示
//    [TopView.layer addSublayer:BackShapeLayer];
    
    TitleLabel = [[UILabel alloc]init];
    TitleLabel.text = @"在投资产";
    TitleLabel.textColor = colorWithRGB(0.61, 0.61, 0.61);
    TitleLabel.textAlignment = NSTextAlignmentCenter;
    TitleLabel.font = [UIFont systemFontOfSize:15];
    [TopView addSubview:TitleLabel];
    [TitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(TopView.mas_centerX);
        make.top.mas_equalTo(TopView.mas_top).offset(40);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    }];
    
    MoneyNumberLabel = [[UILabel alloc]init];
    MoneyNumberLabel.text = @"¥200000";
    MoneyNumberLabel.textAlignment = NSTextAlignmentCenter;
    MoneyNumberLabel.textColor = colorWithRGB(0.99, 0.79, 0.09);
    MoneyNumberLabel.font = [UIFont systemFontOfSize:40];
    [TopView addSubview:MoneyNumberLabel];
    [MoneyNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(TopView.mas_centerX);
        make.top.mas_equalTo(TitleLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(40);
    }];
    
    ProfileLabel = [[UILabel alloc]init];
    ProfileLabel.text = @"查看协议";
    NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:ProfileLabel.text attributes:attribtDic];
    ProfileLabel.attributedText = attribtStr;
    ProfileLabel.textAlignment = NSTextAlignmentCenter;
    ProfileLabel.textColor = colorWithRGB(0.08, 0.08, 0.08);
    ProfileLabel.font = [UIFont systemFontOfSize:13];
    [TopView addSubview:ProfileLabel];
    [ProfileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(TopView.mas_centerX);
        make.top.mas_equalTo(MoneyNumberLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(130);
        make.height.mas_equalTo(20);
    }];
//    StartLabel = [[UILabel alloc]init];
//    StartLabel.text= @"0.00";
//    StartLabel.font = [UIFont systemFontOfSize:12];
//    StartLabel.textColor = [UIColor blackColor];
//    [TopView addSubview:StartLabel];
//    [StartLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(TopView.mas_left).offset(140);
//        make.top.mas_equalTo(ProfileLabel.mas_bottom).offset(10);
//        make.width.mas_equalTo(40);
//        make.height.mas_equalTo(20);
//    }];
//    
//    EndLabel = [[UILabel alloc]init];
//    EndLabel.text = @"8000000";
//    EndLabel.font = [UIFont systemFontOfSize:12];
//    EndLabel.textAlignment = NSTextAlignmentLeft;
//    EndLabel.textColor = [UIColor blackColor];
//    [TopView addSubview:EndLabel];
//    [EndLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(StartLabel.mas_left).offset(80);
//        make.top.mas_equalTo(ProfileLabel.mas_bottom).offset(10);
//        make.width.mas_equalTo(100);
//        make.height.mas_equalTo(20);
//        
//    }];
    
    OldProfdilView = [[ProfilView alloc]init];
    OldProfdilView.NameLabel.text = @"累计收益";
    OldProfdilView.userInteractionEnabled = YES;
    UITapGestureRecognizer *OldTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(OldClick)];
    [OldProfdilView addGestureRecognizer:OldTap];
    OldProfdilView.NameLabel.textColor = colorWithRGB(0.53, 0.53, 0.53);
    [self.view addSubview:OldProfdilView];
    [OldProfdilView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(TopView.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(40);
    }];
    
    AddProfileView = [[ProfilView alloc]init];
    AddProfileView.GorrowView.hidden = YES;
    AddProfileView.NameLabel.text = @"昨日收益";
    AddProfileView.NameLabel.textColor = colorWithRGB(0.53, 0.53, 0.53);
    [self.view addSubview:AddProfileView];
    [AddProfileView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(OldProfdilView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(40);
    }];
    PercentProfileView = [[ProfilView alloc]init];
    PercentProfileView.GorrowView.hidden = YES;
    PercentProfileView.NameLabel.textColor = colorWithRGB(0.53, 0.53, 0.53);
    PercentProfileView.NameLabel.text = @"万份收益";
    [self.view addSubview:PercentProfileView];
    [PercentProfileView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(AddProfileView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(40);
    }];
    
    ComeLabel = [[UILabel alloc]init];
    ComeLabel.backgroundColor = [UIColor whiteColor];
    ComeLabel.text = @"转入";
    ComeLabel.frame = CGRectMake(0, SCREEN_HEIGHT -64-40, SCREEN_WIDTH/2+0.5, 40);
    ComeLabel.textAlignment = NSTextAlignmentCenter;
    ComeLabel.textColor = colorWithRGB(0.99, 0.79, 0.09);
    [self.view addSubview:ComeLabel];

    OutLabel = [[UILabel alloc]init];
    OutLabel.backgroundColor = [UIColor whiteColor];
    OutLabel.frame = CGRectMake(SCREEN_WIDTH/2+1, SCREEN_HEIGHT -64-40, SCREEN_WIDTH/2+0.5, 40);
    OutLabel.text = @"转出";
    OutLabel.textAlignment = NSTextAlignmentCenter;
    OutLabel.textColor = colorWithRGB(0.99, 0.79, 0.09);
    [self.view addSubview:OutLabel];
 
    
    
}
-(void)reloadData{
    MoneyNumberLabel.text =[NSString stringWithFormat:@"¥%@",[jinmiDic objectForKey:@"investmentAmount"]] ;
    OldProfdilView.DetailLabel.text =[NSString stringWithFormat:@"%@",[jinmiDic objectForKey:@"yesterdayEarnings"]];
    PercentProfileView.DetailLabel.text = [NSString stringWithFormat:@"%@",[jinmiDic objectForKey:@"tenThousandIncome"]];
    AddProfileView.DetailLabel.text = [NSString stringWithFormat:@"%@",[jinmiDic objectForKey:@"accumulatedEarnings"]];

}
//累计收益
- (void)OldClick{
    AddProfitViewController *addVC = [[AddProfitViewController alloc]init];
    addVC.ProductType = 1;
    [self.navigationController pushViewController:addVC animated:NO];
}
- (void)JinMiClick{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[UserViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
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
