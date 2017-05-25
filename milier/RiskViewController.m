//
//  RiskViewController.m
//  milier
//
//  Created by amin on 17/4/26.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "RiskViewController.h"
#import "UserViewController.h"
#import "MHRadioButton.h"
#import <AwAlertViewlib/AwAlertViewlib.h>


@interface RiskViewController ()<MHRadioButtonDelegate,UIScrollViewDelegate>{
    UIImageView *FirstView;
    UIScrollView *RiskScroview;
    NSArray *TypeArray;
    UILabel *TitleLabel;
    UIButton *RiskBtn;
    UIButton *ResultBtn;
    AwAlertView *alertView;
    UILabel * firstLabel;
    UILabel * secondLabel;
    UILabel * thirdLabel;
    UILabel * fourLabel;
    UILabel * fiveLabel;
    UILabel * sixLabel;
    UILabel * secenLabel;
    UILabel * eightLabel;
    UILabel * nineLabel;
    UILabel * tenLabel;

}

@property (nonatomic, strong) NSMutableArray * itmeArray;
@property (nonatomic, strong) UIImageView * imageView;
@end

@implementation RiskViewController
static NSString * const ID = @"CollectionCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"风险评估";
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
    
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(0, 7, 18, 18);
    [leftBtn setImage:[UIImage imageNamed:@"backarrow@2x.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(RiskTap) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    TypeArray = @[@"A",@"B",@"C",@"D",@"E"];
    self.view.backgroundColor = colorWithRGB(0.94, 0.94, 0.94);
    
    [self ShowAlert];
    
    RiskScroview = [[UIScrollView alloc]init];
    RiskScroview.backgroundColor = [UIColor whiteColor];
    RiskScroview.layer.masksToBounds = YES;
    RiskScroview.layer.cornerRadius = 10;
    RiskScroview.frame = CGRectMake(20, 20, SCREEN_WIDTH - 40, SCREEN_HEIGHT - 64 - 40);
    RiskScroview.contentOffset = CGPointMake(0, 100);
    RiskScroview.contentSize = CGSizeMake(SCREEN_WIDTH*9-40, 400);
    RiskScroview.bounces = NO;
    RiskScroview.delegate = self;
    RiskScroview.userInteractionEnabled = YES;
    RiskScroview.pagingEnabled = YES;
    RiskScroview.showsVerticalScrollIndicator = NO;
    RiskScroview.showsHorizontalScrollIndicator = NO;
    RiskScroview.maximumZoomScale = 2;
    RiskScroview.minimumZoomScale = 0.8;
    [self.view addSubview:RiskScroview];

    firstLabel = [[UILabel alloc]init];
    firstLabel.text = @"第一个题目";
    firstLabel.font = [UIFont systemFontOfSize:15];
    firstLabel.numberOfLines = 0;
    firstLabel.frame = CGRectMake(20, 50, 300, 20);
    firstLabel.numberOfLines = 0;
    [RiskScroview addSubview:firstLabel];
    secondLabel = [[UILabel alloc]init];
    secondLabel.text = @"第2个题目";
    secondLabel.font = [UIFont systemFontOfSize:15];
    secondLabel.numberOfLines = 0;
    secondLabel.frame = CGRectMake(SCREEN_WIDTH*1 - 20, 50, 300, 20);
    secondLabel.numberOfLines = 0;
    [RiskScroview addSubview:secondLabel];
    thirdLabel = [[UILabel alloc]init];
    thirdLabel.text = @"第3个题目";
    thirdLabel.font = [UIFont systemFontOfSize:15];
    thirdLabel.numberOfLines = 0;
    thirdLabel.frame = CGRectMake(SCREEN_WIDTH*2 - 20*3, 10 +40, 300, 20);
    thirdLabel.numberOfLines = 0;
    [RiskScroview addSubview:thirdLabel];
    fourLabel = [[UILabel alloc]init];
    fourLabel.text = @"第4个题目";
    fourLabel.font = [UIFont systemFontOfSize:15];
    fourLabel.numberOfLines = 0;
    fourLabel.frame = CGRectMake(SCREEN_WIDTH*3- 20*5, 10+40, 300, 20);
    fourLabel.numberOfLines = 0;
    [RiskScroview addSubview:fourLabel];
    fiveLabel = [[UILabel alloc]init];
    fiveLabel.text = @"第5个题目";
    fiveLabel.font = [UIFont systemFontOfSize:15];
    fiveLabel.numberOfLines = 0;
    fiveLabel.frame = CGRectMake(SCREEN_WIDTH*4- 20*7, 10+40, 300, 20);
    fiveLabel.numberOfLines = 0;
    [RiskScroview addSubview:fiveLabel];
    sixLabel  = [[UILabel alloc]init];
    sixLabel.text = @"第6个题目";
    sixLabel.font = [UIFont systemFontOfSize:15];
    sixLabel.numberOfLines = 0;
    sixLabel.frame = CGRectMake(SCREEN_WIDTH*5- 20*9, 10+40, 300, 20);
    sixLabel.numberOfLines = 0;
    [RiskScroview addSubview:sixLabel];
    secenLabel = [[UILabel alloc]init];
    secenLabel.text = @"第7个题目";
    secenLabel.font = [UIFont systemFontOfSize:15];
    secenLabel.numberOfLines = 0;
    secenLabel.frame = CGRectMake(SCREEN_WIDTH*6- 20*11, 10+40, 300, 20);
    secenLabel.numberOfLines = 0;
    [RiskScroview addSubview:secenLabel];
    eightLabel = [[UILabel alloc]init];
    eightLabel.text = @"第8个题目";
    eightLabel.font = [UIFont systemFontOfSize:15];
    eightLabel.numberOfLines = 0;
    eightLabel.frame = CGRectMake(SCREEN_WIDTH*7- 20*13, 10+40, 300, 20);
    eightLabel.numberOfLines = 0;
    [RiskScroview addSubview:eightLabel];
    nineLabel = [[UILabel alloc]init];
    nineLabel.text = @"第9个题目";
    nineLabel.font = [UIFont systemFontOfSize:15];
    nineLabel.numberOfLines = 0;
    nineLabel.frame = CGRectMake(SCREEN_WIDTH*8- 20*15, 10+40, 300, 20);
    nineLabel.numberOfLines = 0;
    [RiskScroview addSubview:nineLabel];
    tenLabel  = [[UILabel alloc]init];
    tenLabel.text = @"第10个题目";
    tenLabel.font = [UIFont systemFontOfSize:15];
    tenLabel.numberOfLines = 0;
    tenLabel.frame = CGRectMake(SCREEN_WIDTH*9- 20*17, 10+40, 300, 20);
    tenLabel.numberOfLines = 0;
    [RiskScroview addSubview:tenLabel];
    
    TitleLabel = [[UILabel alloc]init];
    TitleLabel.text = @"风险能力测试题（1/10）";
    TitleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:TitleLabel];
    [TitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(40);
        make.top.mas_equalTo(self.view.mas_top).offset(40);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(20);
    }];
    
    for (int i = 0; i < 5; i++) {
        MHRadioButton *rb = [[MHRadioButton alloc] initWithGroupId:@"group1" atIndex:i];
        rb.frame = CGRectMake(20, 40 + 30 * i+40, 40, 40);
        [RiskScroview addSubview:rb];
        UILabel *TypeLabel = [[UILabel alloc]init];
        TypeLabel.frame = CGRectMake(40, 40 + 30 * i + 40, 20, 20);
        TypeLabel.text = [TypeArray objectAtIndex:i];
        [RiskScroview addSubview:TypeLabel];
        
        UILabel *NameLabel = [[UILabel alloc]init];
        NameLabel.frame = CGRectMake(60, 40 + 30 * i + 40, 20, 20);
        NameLabel.text = [TypeArray objectAtIndex:i];
        [RiskScroview addSubview:NameLabel];
    }
    
    for (int i = 0; i < 5; i++) {
        MHRadioButton *rb = [[MHRadioButton alloc] initWithGroupId:@"group2" atIndex:i];
        rb.frame = CGRectMake(SCREEN_WIDTH*1-20, 40 + 30 * i+40, 40, 40);
        [RiskScroview addSubview:rb];
        UILabel *TypeLabel = [[UILabel alloc]init];
        TypeLabel.frame = CGRectMake(SCREEN_WIDTH*1, 40 + 30 * i+40, 20, 20);
        TypeLabel.text = [TypeArray objectAtIndex:i];
        [RiskScroview addSubview:TypeLabel];
        UILabel *NameLabel = [[UILabel alloc]init];
        NameLabel.frame = CGRectMake(SCREEN_WIDTH*1 + 20, 40 + 30 * i+40, 120, 20);
        NameLabel.text = @"2323232323";
        [RiskScroview addSubview:NameLabel];
    }
    for (int i = 0; i < 5; i++) {
        MHRadioButton *rb = [[MHRadioButton alloc] initWithGroupId:@"group3" atIndex:i];
        rb.frame = CGRectMake(SCREEN_WIDTH*2+20-40*2, 40 + 30 * i +40, 40, 40);
        [RiskScroview addSubview:rb];
        UILabel *TypeLabel = [[UILabel alloc]init];
        TypeLabel.frame = CGRectMake(SCREEN_WIDTH*2-40*2+40, 40 + 30 * i+40, 20, 20);
        TypeLabel.text = [TypeArray objectAtIndex:i];
        [RiskScroview addSubview:TypeLabel];
        UILabel *NameLabel = [[UILabel alloc]init];
        NameLabel.frame = CGRectMake(SCREEN_WIDTH*2+60-40*2, 40 + 30 * i+40, 20, 20);
        NameLabel.text = [TypeArray objectAtIndex:i];
        [RiskScroview addSubview:NameLabel];

    }
    for (int i = 0; i < 5; i++) {
        MHRadioButton *rb = [[MHRadioButton alloc] initWithGroupId:@"group4" atIndex:i];
        rb.frame = CGRectMake(SCREEN_WIDTH*3+20-40*3, 40 + 30 * i+40, 40, 40);
        [RiskScroview addSubview:rb];
        UILabel *TypeLabel = [[UILabel alloc]init];
        TypeLabel.frame = CGRectMake(SCREEN_WIDTH*3+40-40*3, 40 + 30 * i+40, 20, 20);
        TypeLabel.text = [TypeArray objectAtIndex:i];
        [RiskScroview addSubview:TypeLabel];
        UILabel *NameLabel = [[UILabel alloc]init];
        NameLabel.frame = CGRectMake(SCREEN_WIDTH*3+60-40*3, 40 + 30 * i+40, 20, 20);
        NameLabel.text = [TypeArray objectAtIndex:i];
        [RiskScroview addSubview:NameLabel];

    }
    for (int i = 0; i < 5; i++) {
        MHRadioButton *rb = [[MHRadioButton alloc] initWithGroupId:@"group5" atIndex:i];
        rb.frame = CGRectMake(SCREEN_WIDTH*4+20-40*4, 40 + 30 * i+40, 40, 40);
        [RiskScroview addSubview:rb];
        UILabel *TypeLabel = [[UILabel alloc]init];
        TypeLabel.frame = CGRectMake(SCREEN_WIDTH*4+40-40*4, 40 + 30 * i+40, 20, 20);
        TypeLabel.text = [TypeArray objectAtIndex:i];
        [RiskScroview addSubview:TypeLabel];
        UILabel *NameLabel = [[UILabel alloc]init];
        NameLabel.frame = CGRectMake(SCREEN_WIDTH*4+60-40*4, 40 + 30 * i+40, 20, 20);
        NameLabel.text = [TypeArray objectAtIndex:i];
        [RiskScroview addSubview:NameLabel];

    }
    for (int i = 0; i < 5; i++) {
        MHRadioButton *rb = [[MHRadioButton alloc] initWithGroupId:@"group6" atIndex:i];
        rb.frame = CGRectMake(SCREEN_WIDTH*5+20-40*5, 40 + 30 * i+40, 40+40, 40);
        [RiskScroview addSubview:rb];
        UILabel *TypeLabel = [[UILabel alloc]init];
        TypeLabel.frame = CGRectMake(SCREEN_WIDTH*5+40-40*5, 40 + 30 * i+40, 20, 20);
        TypeLabel.text = [TypeArray objectAtIndex:i];
        [RiskScroview addSubview:TypeLabel];
        UILabel *NameLabel = [[UILabel alloc]init];
        NameLabel.frame = CGRectMake(SCREEN_WIDTH*5+60-40*5, 40 + 30 * i+40, 20, 20);
        NameLabel.text = [TypeArray objectAtIndex:i];
        [RiskScroview addSubview:NameLabel];

    }
    for (int i = 0; i < 5; i++) {
        MHRadioButton *rb = [[MHRadioButton alloc] initWithGroupId:@"group7" atIndex:i];
        rb.frame = CGRectMake(SCREEN_WIDTH*6+20-40*6, 40 + 30 * i+40, 40, 40);
        [RiskScroview addSubview:rb];
        UILabel *TypeLabel = [[UILabel alloc]init];
        TypeLabel.frame = CGRectMake(SCREEN_WIDTH*6+40-40*6, 40 + 30 * i+40, 20, 20);
        TypeLabel.text = [TypeArray objectAtIndex:i];
        [RiskScroview addSubview:TypeLabel];
        UILabel *NameLabel = [[UILabel alloc]init];
        NameLabel.frame = CGRectMake(SCREEN_WIDTH*6+60-40*6, 40 + 30 * i+40, 20, 20);
        NameLabel.text = [TypeArray objectAtIndex:i];
        [RiskScroview addSubview:NameLabel];

    }
    for (int i = 0; i < 5; i++) {
        MHRadioButton *rb = [[MHRadioButton alloc] initWithGroupId:@"group8" atIndex:i];
        rb.frame = CGRectMake(SCREEN_WIDTH*7+20-40*7, 40 + 30 * i+40, 40, 40);
        [RiskScroview addSubview:rb];
        UILabel *TypeLabel = [[UILabel alloc]init];
        TypeLabel.frame = CGRectMake(SCREEN_WIDTH*7+40-40*7, 40 + 30 * i+40, 20, 20);
        TypeLabel.text = [TypeArray objectAtIndex:i];
        [RiskScroview addSubview:TypeLabel];
        UILabel *NameLabel = [[UILabel alloc]init];
        NameLabel.frame = CGRectMake(SCREEN_WIDTH*7+60-40*7, 40 + 30 * i+40, 20, 20);
        NameLabel.text = [TypeArray objectAtIndex:i];
        [RiskScroview addSubview:NameLabel];

    }
    for (int i = 0; i < 5; i++) {
        MHRadioButton *rb = [[MHRadioButton alloc] initWithGroupId:@"group9" atIndex:i];
        rb.frame = CGRectMake(SCREEN_WIDTH*8+20-40*8, 40 + 30 * i+40, 40, 40);
        [RiskScroview addSubview:rb];
        UILabel *TypeLabel = [[UILabel alloc]init];
        TypeLabel.frame = CGRectMake(SCREEN_WIDTH*8+40-40*8, 40 + 30 * i+40, 20, 20);
        TypeLabel.text = [TypeArray objectAtIndex:i];
        [RiskScroview addSubview:TypeLabel];
        UILabel *NameLabel = [[UILabel alloc]init];
        NameLabel.frame = CGRectMake(SCREEN_WIDTH*8+60-40*8, 40 + 30 * i+40, 20, 20);
        NameLabel.text = [TypeArray objectAtIndex:i];
        [RiskScroview addSubview:NameLabel];

    }
    for (int i = 0; i < 5; i++) {
        MHRadioButton *rb = [[MHRadioButton alloc] initWithGroupId:@"group10" atIndex:i];
        rb.frame = CGRectMake(SCREEN_WIDTH*9+20-40*9, 40 + 30 * i+40, 40, 40);
        [RiskScroview addSubview:rb];
        UILabel *TypeLabel = [[UILabel alloc]init];
        TypeLabel.frame = CGRectMake(SCREEN_WIDTH*9+40-40*9, 40 + 30 * i+40, 20, 20);
        TypeLabel.text = [TypeArray objectAtIndex:i];
        [RiskScroview addSubview:TypeLabel];
        UILabel *NameLabel = [[UILabel alloc]init];
        NameLabel.frame = CGRectMake(SCREEN_WIDTH*9+60-40*9, 40 + 30 * i+40, 20, 20);
        NameLabel.text = [TypeArray objectAtIndex:i];
        [RiskScroview addSubview:NameLabel];

    }
    
    [MHRadioButton addObserver:self forFroupId:@"group1"];
    [MHRadioButton addObserver:self forFroupId:@"group2"];
    [MHRadioButton addObserver:self forFroupId:@"group3"];
    [MHRadioButton addObserver:self forFroupId:@"group4"];
    [MHRadioButton addObserver:self forFroupId:@"group5"];
    [MHRadioButton addObserver:self forFroupId:@"group6"];
    [MHRadioButton addObserver:self forFroupId:@"group7"];
    [MHRadioButton addObserver:self forFroupId:@"group8"];
    [MHRadioButton addObserver:self forFroupId:@"group9"];
    [MHRadioButton addObserver:self forFroupId:@"group10"];
    

    
    ResultBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    ResultBtn.hidden = YES;
    [ResultBtn setTitle:@"完成测试" forState:UIControlStateNormal];
    ResultBtn.layer.masksToBounds = YES;
    ResultBtn.layer.cornerRadius = 10;
    [ResultBtn addTarget:self action:@selector(ResultClick) forControlEvents:UIControlEventTouchUpInside];
    ResultBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    ResultBtn.backgroundColor = [UIColor orangeColor];
    ResultBtn.tintColor = [UIColor whiteColor];
    [self.view addSubview:ResultBtn];
    [ResultBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY);
        make.width.mas_equalTo(SCREEN_WIDTH - 100);
        make.height.mas_equalTo(40);
    }];


}
- (void)ShowAlert{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300)];
    view.backgroundColor=[UIColor whiteColor];
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 5.0f;
    view.alpha = 0.9;
    alertView=[[AwAlertView alloc]initWithContentView:view];
    alertView.isUseHidden=YES;
    [alertView showAnimated:YES];
    
    UILabel *label = [[UILabel alloc]init];
    label.text = @"风险承受能力测试问卷";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:12];
    label.frame = CGRectMake(10, 20, SCREEN_WIDTH - 20, 20);
    [view addSubview:label];
    
    UILabel *ScroLabel = [[UILabel alloc]init];
    ScroLabel.frame = CGRectMake(10, 30, SCREEN_WIDTH-20, 240);
    ScroLabel.numberOfLines = 0;
    
    ScroLabel.text = @"尊敬的客户：您好！\n为了给您提供更优质的服务，请您花费几分钟的时间，如实填写以下调查问卷，本表可协助评估您对互联网金融及投资目标相关风险的态度，确定您对投资风险的适应力，进而为您挑选更适合投资的产品。衷心感谢您的支持与信任。\n重要提示：\n1、请投资者认真阅读问卷内容，了解评分规则，并确认所填写内容表达真实。\n2、本公司根据投资者的风险承受能力等级，对投资者的投资行为作出是否匹配的检查和提示。本次调查结果不构成对投资者的投资建议，或对投资者的投资决策形成实质影响。\n3、投资有风险，可能导致投资者产生亏损，请投资者在购买过程中注意根据调查结果核对自己的风险承受能力和互联网金融风险匹配情况。无论投资者是否根据调查结果进行投资，均属投资者的独立行为，相应的风险亦由投资者独立承担。\n4、本问卷共设计了10道问题，\n每题5个备选答案，得分依次为2、4、6、8、10。投资人得分越高，说明投资者的风险承受能力越强。\n5、所有题目均为单选。 ";
    ScroLabel.font = [UIFont systemFontOfSize:10];
    [view addSubview:ScroLabel];
    
    UILabel *complyLabel = [[UILabel alloc]init];
    complyLabel.text = @"开始";
    complyLabel.textAlignment = NSTextAlignmentCenter;
    complyLabel.backgroundColor = colorWithRGB(0.95, 0.6, 0.11);
    complyLabel.textColor = [UIColor whiteColor];
    complyLabel.font = [UIFont systemFontOfSize:15];
    complyLabel.layer.masksToBounds = YES;
    complyLabel.layer.cornerRadius = 10;
    complyLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *ComPlayTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(BeginClick)];
    [complyLabel addGestureRecognizer:ComPlayTap];
    [view addSubview:complyLabel];
    
    
    [complyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view.mas_centerX);
        make.bottom.mas_equalTo(view.mas_bottom).offset(-10);
        make.width.mas_equalTo(140);
        make.height.mas_equalTo(30);
        
    }];

}
- (void)ResultClick{
    [self showResult];
}
- (void)NextClick{
    CGFloat pageWidth = RiskScroview.frame.size.width;
    
    int page = floor((RiskScroview.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    for (int i = page; i < 9; i++) {
        RiskScroview.contentOffset = CGPointMake(SCREEN_WIDTH*(page+1), 0);
        TitleLabel.text = [NSString stringWithFormat:@"风险能力测试题（%d/10）",page+1];
        RiskBtn.hidden = NO;
        ResultBtn.hidden = YES;

    }
    if (page == 9) {
        TitleLabel.text = [NSString stringWithFormat:@"风险能力测试题（%d/10）",page+1];
        RiskBtn.hidden = YES;
        ResultBtn.hidden = NO;
    }
    NSLog(@"page = %d",page);
   
}
- (void)showResult{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 260)];
    view.backgroundColor=[UIColor whiteColor];
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 5.0f;
    view.alpha = 0.9;
    alertView=[[AwAlertView alloc]initWithContentView:view];
    alertView.isUseHidden=YES;
    [alertView showAnimated:YES];
    UILabel *label = [[UILabel alloc]init];
    label.text = @"测试结果";
    label.frame = CGRectMake(10, 20, 100, 20);
    [view addSubview:label];
    
    UILabel *ScroLabel = [[UILabel alloc]init];
    ScroLabel.frame = CGRectMake(10, 10+40, 100, 10);
    ScroLabel.text = @"我的得分：46分";
    ScroLabel.font = [UIFont systemFontOfSize:12];
    [view addSubview:ScroLabel];
    
    UILabel *typeLabel = [[UILabel alloc]init];
    typeLabel.frame = CGRectMake(10, 10+70, 100, 10);
    typeLabel.text = @"风险类型：稳健型";
    typeLabel.font = [UIFont systemFontOfSize:12];
    [view addSubview:typeLabel];
    
    UILabel *resultLabel = [[UILabel alloc]init];
    resultLabel.frame = CGRectMake(10, 10+100, 100, 10);
    resultLabel.text = @"结果说明";
    resultLabel.font = [UIFont systemFontOfSize:12];
    [view addSubview:resultLabel];
    
    UILabel *oneResultLabel = [[UILabel alloc]init];
    oneResultLabel.frame = CGRectMake(10, 10+120, 100, 10);
    oneResultLabel.text = @"-问我说明";
    oneResultLabel.font = [UIFont systemFontOfSize:12];
    [view addSubview:oneResultLabel];
    UILabel *twoResultLabel = [[UILabel alloc]init];
    twoResultLabel.frame = CGRectMake(10, 10+150, 100, 10);
    twoResultLabel.text = @"-结果说明";
    twoResultLabel.font = [UIFont systemFontOfSize:12];
    [view addSubview:twoResultLabel];
    UILabel *ThreeResultLabel = [[UILabel alloc]init];
    ThreeResultLabel.frame = CGRectMake(10, 10+180, 100, 10);
    ThreeResultLabel.text = @"-结果说明";
    ThreeResultLabel.font = [UIFont systemFontOfSize:12];
    [view addSubview:ThreeResultLabel];

    UILabel *complyLabel = [[UILabel alloc]init];
    complyLabel.text = @"完成,谢谢参与!";
    complyLabel.textAlignment = NSTextAlignmentCenter;
    complyLabel.backgroundColor = colorWithRGB(0.95, 0.6, 0.11);
    complyLabel.textColor = [UIColor whiteColor];
    complyLabel.font = [UIFont systemFontOfSize:15];
    complyLabel.layer.masksToBounds = YES;
    complyLabel.layer.cornerRadius = 10;
    complyLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *ComPlayTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ComClick)];
    [complyLabel addGestureRecognizer:ComPlayTap];
    [view addSubview:complyLabel];
    

    [complyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view.mas_centerX);
        make.bottom.mas_equalTo(view.mas_bottom).offset(-10);
        make.width.mas_equalTo(140);
        make.height.mas_equalTo(40);

    }];
}
- (void)BeginClick{
    [alertView dismissAnimated:NO];

}
- (void)ComClick{
    NSLog(@"完成测试");
    [alertView dismissAnimated:NO];
    NSLog(@" 11111 ===  %lu", [MHRadioButton getIndexWithGroupId:@"group1"]);
    NSLog(@" 22222 ===  %lu", [MHRadioButton getIndexWithGroupId:@"group2"]);

    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[UserViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }

}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat pageWidth = RiskScroview.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    if (page<9) {
        TitleLabel.text = [NSString stringWithFormat:@"风险能力测试题（%d/10）",page+1];
        [RiskBtn setTitle:@"下一题" forState:UIControlStateNormal];
        RiskBtn.hidden = NO;
        ResultBtn.hidden = YES;
    }
    if (page == 9) {
        TitleLabel.text = [NSString stringWithFormat:@"风险能力测试题（%d/10）",page+1];
        RiskBtn.hidden = YES;
        ResultBtn.hidden = NO;
        
    }
}

// 代理方法 监控按钮选中状态的改变
- (void)radioButtonSelectedAtIndex:(NSUInteger)index inGroup:(NSString *)groupID{
  //  NSLog(@"%@ %lu", groupID, (unsigned long)index);
    
  //  NSLog(@"%lu", [MHRadioButton getIndexWithGroupId:@"group"]);
}
- (void)RiskTap{
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
