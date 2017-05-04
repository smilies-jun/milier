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
}

@end

@implementation JinMiDetdailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"金米宝";
    self.view.backgroundColor = [UIColor grayColor];
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(0, 7, 18, 18);
    [leftBtn setImage:[UIImage imageNamed:@"backarrow@2x.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(JinMiClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    [self ConfigUI];
}

- (void)ConfigUI{
    UIView *TopView = [[UIView alloc]init];
    TopView.backgroundColor = [UIColor whiteColor];
    TopView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 200);
    [self.view addSubview:TopView];
    
    ShapeLayer = [CAShapeLayer layer];
    ShapeLayer.fillColor = [UIColor clearColor].CGColor;//填充颜色为ClearColor
    //设置线条的宽度和颜色
    ShapeLayer.lineWidth = 5.0f;
    ShapeLayer.strokeColor = [UIColor redColor].CGColor;
    //创建出圆形贝塞尔曲线
    UIBezierPath *circlePath =  [UIBezierPath bezierPathWithArcCenter:CGPointMake(TopView.centerX, TopView.centerY) radius:70 startAngle:0.75f*M_PI endAngle:0.25f*M_PI clockwise:YES];
    
    //让贝塞尔曲线与CAShapeLayer产生联系
    ShapeLayer.path = circlePath.CGPath;
    
    //添加并显示
    [TopView.layer addSublayer:ShapeLayer];
    
    BackShapeLayer = [CAShapeLayer layer];
    BackShapeLayer.fillColor = [UIColor clearColor].CGColor;//填充颜色为ClearColor
    //设置线条的宽度和颜色
    BackShapeLayer.lineWidth = 5.0f;
    BackShapeLayer.strokeColor = [UIColor blackColor].CGColor;
    //创建出圆形贝塞尔曲线
    UIBezierPath *backcirclePath =  [UIBezierPath bezierPathWithArcCenter:CGPointMake(TopView.centerX, TopView.centerY) radius:70 startAngle:0.75f*M_PI endAngle:1.5f*M_PI clockwise:YES];
    
    //让贝塞尔曲线与CAShapeLayer产生联系
    BackShapeLayer.path = backcirclePath.CGPath;
    
    //添加并显示
    [TopView.layer addSublayer:BackShapeLayer];
    
    TitleLabel = [[UILabel alloc]init];
    TitleLabel.text = @"在投资产";
    TitleLabel.textColor = [UIColor blackColor];
    TitleLabel.textAlignment = NSTextAlignmentCenter;
    TitleLabel.font = [UIFont systemFontOfSize:12];
    [TopView addSubview:TitleLabel];
    [TitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(TopView.mas_centerX);
        make.top.mas_equalTo(TopView.mas_top).offset(60);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    }];
    
    MoneyNumberLabel = [[UILabel alloc]init];
    MoneyNumberLabel.text = @"200000";
    MoneyNumberLabel.textAlignment = NSTextAlignmentCenter;
    MoneyNumberLabel.textColor = [UIColor blackColor];
    MoneyNumberLabel.font = [UIFont systemFontOfSize:16];
    [TopView addSubview:MoneyNumberLabel];
    [MoneyNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(TopView.mas_centerX);
        make.top.mas_equalTo(TitleLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(130);
        make.height.mas_equalTo(20);
    }];
    
    ProfileLabel = [[UILabel alloc]init];
    ProfileLabel.text = @"查看协议";
    ProfileLabel.textAlignment = NSTextAlignmentCenter;
    ProfileLabel.textColor = [UIColor blackColor];
    ProfileLabel.font = [UIFont systemFontOfSize:14];
    [TopView addSubview:ProfileLabel];
    [ProfileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(TopView.mas_centerX);
        make.top.mas_equalTo(MoneyNumberLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(130);
        make.height.mas_equalTo(20);
    }];
    StartLabel = [[UILabel alloc]init];
    StartLabel.text= @"0.00";
    StartLabel.font = [UIFont systemFontOfSize:10];
    StartLabel.textColor = [UIColor blackColor];
    [TopView addSubview:StartLabel];
    [StartLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(TopView.mas_left).offset(140);
        make.top.mas_equalTo(ProfileLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(20);
    }];
    
    EndLabel = [[UILabel alloc]init];
    EndLabel.text = @"8000000";
    EndLabel.font = [UIFont systemFontOfSize:10];
    EndLabel.textAlignment = NSTextAlignmentLeft;
    EndLabel.textColor = [UIColor blackColor];
    [TopView addSubview:EndLabel];
    [EndLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(StartLabel.mas_left).offset(80);
        make.top.mas_equalTo(ProfileLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
        
    }];
    
    OldProfdilView = [[ProfilView alloc]init];
    OldProfdilView.NameLabel.text = @"昨日收益";
    [self.view addSubview:OldProfdilView];
    [OldProfdilView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(TopView.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(40);
    }];
    AddProfileView = [[ProfilView alloc]init];
    AddProfileView.NameLabel.text = @"累计收益";
    [self.view addSubview:AddProfileView];
    [AddProfileView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(OldProfdilView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(40);
    }];
    PercentProfileView = [[ProfilView alloc]init];
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
    ComeLabel.frame = CGRectMake(0, SCREEN_HEIGHT -64-40, SCREEN_WIDTH/2-1, 40);
    ComeLabel.textAlignment = NSTextAlignmentCenter;
    ComeLabel.textColor = [UIColor orangeColor];
    [self.view addSubview:ComeLabel];

    OutLabel = [[UILabel alloc]init];
    OutLabel.backgroundColor = [UIColor whiteColor];
    OutLabel.frame = CGRectMake(SCREEN_WIDTH/2+1, SCREEN_HEIGHT -64-40, SCREEN_WIDTH/2, 40);
    OutLabel.text = @"转出";
    OutLabel.textAlignment = NSTextAlignmentCenter;
    OutLabel.textColor = [UIColor orangeColor];
    [self.view addSubview:OutLabel];
 
    
    
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
