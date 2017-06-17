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
#import "SaleViewController.h"

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
    
    NSMutableArray *titleArray;
    NSMutableArray *OptionesArray;
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
    [leftBtn setImage:[UIImage imageNamed:@"backarrow"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(RiskTap) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    TypeArray = @[@"A",@"B",@"C",@"D",@"E"];
    self.view.backgroundColor = colorWithRGB(0.94, 0.94, 0.94);
    titleArray =[[NSMutableArray  alloc]init];
    OptionesArray = [[NSMutableArray alloc]init];
    [self ShowAlert];
    [self reloadData];
   //[self ConfigUI];



}

- (void)reloadData{
    NSString *url;
    NSString *tokenID = NSuserUse(@"Authorization");
    
    url = [NSString stringWithFormat:@"%@/questions",HOST_URL];
    [[DateSource sharedInstance]requestHtml5WithParameters:nil  withUrl:url withTokenStr:tokenID  usingBlock:^(NSDictionary *result, NSError *error) {
     //  NSLog(@"result = %@",result);
        NSArray *MyArray = [result objectForKey:@"items"];
        for (NSDictionary *myDic in MyArray) {
            [titleArray addObject:[myDic objectForKey:@"question"]];
            [OptionesArray addObject:[myDic objectForKey:@"options"]];
            
        }
        [self ConfigUI];

    }];
}
- (void)ConfigUI{
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
    firstLabel.text = [NSString stringWithFormat:@"1:%@",[titleArray objectAtIndex:0]];
    firstLabel.font = [UIFont systemFontOfSize:15];
    firstLabel.numberOfLines = 0;
    firstLabel.frame = CGRectMake(20, 50, 300, 40);
    firstLabel.numberOfLines = 0;
    [RiskScroview addSubview:firstLabel];
    secondLabel = [[UILabel alloc]init];
    secondLabel.text = [NSString stringWithFormat:@"2:%@",[titleArray objectAtIndex:1]];
    secondLabel.font = [UIFont systemFontOfSize:15];
    secondLabel.numberOfLines = 0;
    secondLabel.frame = CGRectMake(SCREEN_WIDTH*1 - 20, 50, 300, 80);
    [RiskScroview addSubview:secondLabel];
    thirdLabel = [[UILabel alloc]init];
    thirdLabel.text = [NSString stringWithFormat:@"3:%@",[titleArray objectAtIndex:2]];
    thirdLabel.font = [UIFont systemFontOfSize:15];
    thirdLabel.numberOfLines = 0;
    thirdLabel.frame = CGRectMake(SCREEN_WIDTH*2 - 20*3, 10 +40, 300, 40);
    thirdLabel.numberOfLines = 0;
    [RiskScroview addSubview:thirdLabel];
    fourLabel = [[UILabel alloc]init];
    fourLabel.text = [NSString stringWithFormat:@"4:%@",[titleArray objectAtIndex:3]];
    fourLabel.font = [UIFont systemFontOfSize:15];
    fourLabel.numberOfLines = 0;
    fourLabel.frame = CGRectMake(SCREEN_WIDTH*3- 20*5, 10+40, 300, 40);
    fourLabel.numberOfLines = 0;
    [RiskScroview addSubview:fourLabel];
    fiveLabel = [[UILabel alloc]init];
    fiveLabel.text = [NSString stringWithFormat:@"5:%@",[titleArray objectAtIndex:4]];
    fiveLabel.font = [UIFont systemFontOfSize:15];
    fiveLabel.numberOfLines = 0;
    fiveLabel.frame = CGRectMake(SCREEN_WIDTH*4- 20*7, 10+40, 300, 40);
    fiveLabel.numberOfLines = 0;
    [RiskScroview addSubview:fiveLabel];
    sixLabel  = [[UILabel alloc]init];
    sixLabel.text = [NSString stringWithFormat:@"6:%@",[titleArray objectAtIndex:5]];
    sixLabel.font = [UIFont systemFontOfSize:15];
    sixLabel.numberOfLines = 0;
    sixLabel.frame = CGRectMake(SCREEN_WIDTH*5- 20*9, 10+40, 300, 60);
    sixLabel.numberOfLines = 0;
    [RiskScroview addSubview:sixLabel];
    secenLabel = [[UILabel alloc]init];
    secenLabel.text = [NSString stringWithFormat:@"7:%@",[titleArray objectAtIndex:6]];
    secenLabel.font = [UIFont systemFontOfSize:15];
    secenLabel.numberOfLines = 0;
    secenLabel.frame = CGRectMake(SCREEN_WIDTH*6- 20*11, 10+40, 300, 40);
    secenLabel.numberOfLines = 0;
    [RiskScroview addSubview:secenLabel];
    eightLabel = [[UILabel alloc]init];
    eightLabel.text =[NSString stringWithFormat:@"8:%@",[titleArray objectAtIndex:7]];
    eightLabel.font = [UIFont systemFontOfSize:15];
    eightLabel.numberOfLines = 0;
    eightLabel.frame = CGRectMake(SCREEN_WIDTH*7- 20*13, 10+40, 300, 40);
    eightLabel.numberOfLines = 0;
    [RiskScroview addSubview:eightLabel];
    nineLabel = [[UILabel alloc]init];
    nineLabel.text = [NSString stringWithFormat:@"9:%@",[titleArray objectAtIndex:8]];
    nineLabel.font = [UIFont systemFontOfSize:15];
    nineLabel.numberOfLines = 0;
    nineLabel.frame = CGRectMake(SCREEN_WIDTH*8- 20*15, 10+40, 300, 40);
    nineLabel.numberOfLines = 0;
    [RiskScroview addSubview:nineLabel];
    tenLabel  = [[UILabel alloc]init];
    tenLabel.text =[NSString stringWithFormat:@"10:%@",[titleArray objectAtIndex:9]];
    tenLabel.font = [UIFont systemFontOfSize:15];
    tenLabel.numberOfLines = 0;
    tenLabel.frame = CGRectMake(SCREEN_WIDTH*9- 20*17, 10+40, 300, 40);
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
        rb.frame = CGRectMake(20, 20+40+40 + 30 * i+40, 40, 40);
        [RiskScroview addSubview:rb];
        UILabel *TypeLabel = [[UILabel alloc]init];
        TypeLabel.frame = CGRectMake(40, 20+40+40 + 30 * i + 40, 20, 20);
        TypeLabel.text = [TypeArray objectAtIndex:i];
        [RiskScroview addSubview:TypeLabel];
        
        UILabel *NameLabel = [[UILabel alloc]init];
        NameLabel.font =[UIFont systemFontOfSize:12];
        NameLabel.frame = CGRectMake(60, 20+40+40 + 30 * i + 40, 220, 20);
       // NSLog(@" == %@",[[OptionesArray  objectAtIndex:i]objectForKey:@"option"]);
        NameLabel.text = [[[OptionesArray  objectAtIndex:0]objectAtIndex:i]objectForKey:@"option"];
        [RiskScroview addSubview:NameLabel];
    }
    
    for (int i = 0; i < 5; i++) {
        MHRadioButton *rb = [[MHRadioButton alloc] initWithGroupId:@"group2" atIndex:i];
        rb.frame = CGRectMake(SCREEN_WIDTH*1-20, 20+40+40 + 30 * i+40, 40, 40);
        [RiskScroview addSubview:rb];
        UILabel *TypeLabel = [[UILabel alloc]init];
        TypeLabel.frame = CGRectMake(SCREEN_WIDTH*1, 20+40+40 + 30 * i+40, 20, 20);
        TypeLabel.text = [TypeArray objectAtIndex:i];
        [RiskScroview addSubview:TypeLabel];
        UILabel *NameLabel = [[UILabel alloc]init];
        NameLabel.font =[UIFont systemFontOfSize:12];

        NameLabel.frame = CGRectMake(SCREEN_WIDTH*1 + 20, 20+40+40 + 30 * i+40, 220, 20);
        NameLabel.text = [[[OptionesArray  objectAtIndex:1]objectAtIndex:i]objectForKey:@"option"];
        [RiskScroview addSubview:NameLabel];
    }
    for (int i = 0; i < 5; i++) {
        MHRadioButton *rb = [[MHRadioButton alloc] initWithGroupId:@"group3" atIndex:i];
        rb.frame = CGRectMake(SCREEN_WIDTH*2+20-40*2, 20+40+40 + 30 * i +40, 40, 40);
        [RiskScroview addSubview:rb];
        UILabel *TypeLabel = [[UILabel alloc]init];
        TypeLabel.frame = CGRectMake(SCREEN_WIDTH*2-40*2+40,20+ 40+40 + 30 * i+40, 20, 20);
        TypeLabel.text = [TypeArray objectAtIndex:i];
        [RiskScroview addSubview:TypeLabel];
        UILabel *NameLabel = [[UILabel alloc]init];
        NameLabel.font =[UIFont systemFontOfSize:12];

        NameLabel.frame = CGRectMake(SCREEN_WIDTH*2+60-40*2,20+ 40+40 + 30 * i+40, 220, 20);
        NameLabel.text = [[[OptionesArray  objectAtIndex:2]objectAtIndex:i]objectForKey:@"option"];
        [RiskScroview addSubview:NameLabel];
        
    }
    for (int i = 0; i < 5; i++) {
        MHRadioButton *rb = [[MHRadioButton alloc] initWithGroupId:@"group4" atIndex:i];
        rb.frame = CGRectMake(SCREEN_WIDTH*3+20-40*3, 20+40+40 + 30 * i+40, 40, 40);
        [RiskScroview addSubview:rb];
        UILabel *TypeLabel = [[UILabel alloc]init];
        TypeLabel.frame = CGRectMake(SCREEN_WIDTH*3+40-40*3, 20+40+40 + 30 * i+40, 20, 20);
        TypeLabel.text = [TypeArray objectAtIndex:i];
        [RiskScroview addSubview:TypeLabel];
        UILabel *NameLabel = [[UILabel alloc]init];
        NameLabel.font =[UIFont systemFontOfSize:12];

        NameLabel.frame = CGRectMake(SCREEN_WIDTH*3+60-40*3, 20+40+40 + 30 * i+40, 220, 20);
        NameLabel.text = [[[OptionesArray  objectAtIndex:3]objectAtIndex:i]objectForKey:@"option"];
        [RiskScroview addSubview:NameLabel];
        
    }
    for (int i = 0; i < 5; i++) {
        MHRadioButton *rb = [[MHRadioButton alloc] initWithGroupId:@"group5" atIndex:i];
        rb.frame = CGRectMake(SCREEN_WIDTH*4+20-40*4,20+ 40+40 + 30 * i+40, 40, 40);
        [RiskScroview addSubview:rb];
        UILabel *TypeLabel = [[UILabel alloc]init];
        TypeLabel.frame = CGRectMake(SCREEN_WIDTH*4+40-40*4, 20+40+40 + 30 * i+40, 20, 20);
        TypeLabel.text = [TypeArray objectAtIndex:i];
        [RiskScroview addSubview:TypeLabel];
        UILabel *NameLabel = [[UILabel alloc]init];
        NameLabel.font =[UIFont systemFontOfSize:12];

        NameLabel.frame = CGRectMake(SCREEN_WIDTH*4+60-40*4, 20+40+40 + 30 * i+40, 220, 20);
        NameLabel.text = [[[OptionesArray  objectAtIndex:4]objectAtIndex:i]objectForKey:@"option"];
        [RiskScroview addSubview:NameLabel];
        
    }
    for (int i = 0; i < 5; i++) {
        MHRadioButton *rb = [[MHRadioButton alloc] initWithGroupId:@"group6" atIndex:i];
        rb.frame = CGRectMake(SCREEN_WIDTH*5+20-40*5,20+ 40+40 + 30 * i+40, 40+40, 40);
        [RiskScroview addSubview:rb];
        UILabel *TypeLabel = [[UILabel alloc]init];
        TypeLabel.frame = CGRectMake(SCREEN_WIDTH*5+40-40*5, 20+40+40 + 30 * i+40, 20, 20);
        TypeLabel.text = [TypeArray objectAtIndex:i];
        [RiskScroview addSubview:TypeLabel];
        UILabel *NameLabel = [[UILabel alloc]init];
        NameLabel.font =[UIFont systemFontOfSize:12];

        NameLabel.frame = CGRectMake(SCREEN_WIDTH*5+60-40*5,20+ 40+40 + 30 * i+40, 220, 20);
        NameLabel.text = [[[OptionesArray  objectAtIndex:5]objectAtIndex:i]objectForKey:@"option"];
        [RiskScroview addSubview:NameLabel];
        
    }
    for (int i = 0; i < 5; i++) {
        MHRadioButton *rb = [[MHRadioButton alloc] initWithGroupId:@"group7" atIndex:i];
        rb.frame = CGRectMake(SCREEN_WIDTH*6+20-40*6, 20+40+40 + 30 * i+40, 40, 40);
        [RiskScroview addSubview:rb];
        UILabel *TypeLabel = [[UILabel alloc]init];
        TypeLabel.frame = CGRectMake(SCREEN_WIDTH*6+40-40*6, 20+40+40 + 30 * i+40, 20, 20);
        TypeLabel.text = [TypeArray objectAtIndex:i];
        [RiskScroview addSubview:TypeLabel];
        UILabel *NameLabel = [[UILabel alloc]init];
        NameLabel.font =[UIFont systemFontOfSize:12];
        NameLabel.numberOfLines = 0;
        NameLabel.frame = CGRectMake(SCREEN_WIDTH*6+60-40*6, 20+40+40 + 30 * i+40, 220, 20);
        NameLabel.text = [[[OptionesArray  objectAtIndex:6]objectAtIndex:i]objectForKey:@"option"];
        [RiskScroview addSubview:NameLabel];
        
    }
    for (int i = 0; i < 5; i++) {
        MHRadioButton *rb = [[MHRadioButton alloc] initWithGroupId:@"group8" atIndex:i];
        rb.frame = CGRectMake(SCREEN_WIDTH*7+20-40*7, 20+40+40 + 30 * i+40, 40, 40);
        [RiskScroview addSubview:rb];
        UILabel *TypeLabel = [[UILabel alloc]init];
        TypeLabel.frame = CGRectMake(SCREEN_WIDTH*7+40-40*7,20+ 40+40 + 30 * i+40, 20, 20);
        TypeLabel.text = [TypeArray objectAtIndex:i];
        [RiskScroview addSubview:TypeLabel];
        UILabel *NameLabel = [[UILabel alloc]init];
        NameLabel.font =[UIFont systemFontOfSize:12];

        NameLabel.frame = CGRectMake(SCREEN_WIDTH*7+60-40*7,20+ 40+40 + 30 * i+40, 220, 20);
        NameLabel.text = [[[OptionesArray  objectAtIndex:7]objectAtIndex:i]objectForKey:@"option"];
        [RiskScroview addSubview:NameLabel];
        
    }
    for (int i = 0; i < 5; i++) {
        MHRadioButton *rb = [[MHRadioButton alloc] initWithGroupId:@"group9" atIndex:i];
        rb.frame = CGRectMake(SCREEN_WIDTH*8+20-40*8,20+40+ 40 + 30 * i+40, 40, 40);
        [RiskScroview addSubview:rb];
        UILabel *TypeLabel = [[UILabel alloc]init];
        TypeLabel.frame = CGRectMake(SCREEN_WIDTH*8+40-40*8,20+40+ 40 + 30 * i+40, 20, 20);
        TypeLabel.text = [TypeArray objectAtIndex:i];
        [RiskScroview addSubview:TypeLabel];
        UILabel *NameLabel = [[UILabel alloc]init];
        NameLabel.font =[UIFont systemFontOfSize:12];
        NameLabel.numberOfLines = 0;
        NameLabel.frame = CGRectMake(SCREEN_WIDTH*8+60-40*8, 20+40+40 + 30 * i+40, 220, 20);
        NameLabel.text = [[[OptionesArray  objectAtIndex:8]objectAtIndex:i]objectForKey:@"option"];
        [RiskScroview addSubview:NameLabel];
        
    }
    for (int i = 0; i < 5; i++) {
        MHRadioButton *rb = [[MHRadioButton alloc] initWithGroupId:@"group10" atIndex:i];
        rb.frame = CGRectMake(SCREEN_WIDTH*9+20-40*9, 20+40+40 + 30 * i+40, 40, 40);
        [RiskScroview addSubview:rb];
        UILabel *TypeLabel = [[UILabel alloc]init];
        TypeLabel.frame = CGRectMake(SCREEN_WIDTH*9+40-40*9,20+40+40 + 30 * i+40, 20, 20);
        TypeLabel.text = [TypeArray objectAtIndex:i];
        [RiskScroview addSubview:TypeLabel];
        UILabel *NameLabel = [[UILabel alloc]init];
        NameLabel.font =[UIFont systemFontOfSize:12];

        NameLabel.frame = CGRectMake(SCREEN_WIDTH*9+60-40*9, 20+40+40 + 30 * i+40, 220, 20);
        NameLabel.text = [[[OptionesArray  objectAtIndex:9]objectAtIndex:i]objectForKey:@"option"];
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
    
//    RiskBtn   = [UIButton buttonWithType:UIButtonTypeCustom];
//    RiskBtn.hidden = NO;
//    [RiskBtn setTitle:@"下一题" forState:UIControlStateNormal];
//    RiskBtn.layer.masksToBounds = YES;
//    RiskBtn.layer.cornerRadius = 10;
//    [RiskBtn addTarget:self action:@selector(NextClick) forControlEvents:UIControlEventTouchUpInside];
//    RiskBtn.titleLabel.font = [UIFont systemFontOfSize:14];
//    RiskBtn.backgroundColor = [UIColor orangeColor];
//    RiskBtn.tintColor = [UIColor whiteColor];
//    [self.view addSubview:RiskBtn];
//    [RiskBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(self.view.mas_centerX);
//        make.centerY.mas_equalTo(self.view.mas_centerY).offset(50);
//        make.width.mas_equalTo(SCREEN_WIDTH - 100);
//        make.height.mas_equalTo(40);
//    }];
    
    
    
    
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
        make.centerY.mas_equalTo(self.view.mas_centerY).offset(50);
        make.width.mas_equalTo(SCREEN_WIDTH - 100);
        make.height.mas_equalTo(40);
    }];
}
- (void)ShowAlert{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 500)];
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
    label.font = [UIFont systemFontOfSize:15];
    label.frame = CGRectMake(10, 20, SCREEN_WIDTH - 20, 20);
    [view addSubview:label];
    
    UILabel *ScroLabel = [[UILabel alloc]init];
    ScroLabel.frame = CGRectMake(10, 30, SCREEN_WIDTH-20, 420);
    ScroLabel.numberOfLines = 0;
    
    ScroLabel.text = @"尊敬的客户：您好！\n为了给您提供更优质的服务，请您花费几分钟的时间，如实填写以下调查问卷，本表可协助评估您对互联网金融及投资目标相关风险的态度，确定您对投资风险的适应力，进而为您挑选更适合投资的产品。衷心感谢您的支持与信任。\n重要提示：\n1、请投资者认真阅读问卷内容，了解评分规则，并确认所填写内容表达真实。\n2、本公司根据投资者的风险承受能力等级，对投资者的投资行为作出是否匹配的检查和提示。本次调查结果不构成对投资者的投资建议，或对投资者的投资决策形成实质影响。\n3、投资有风险，可能导致投资者产生亏损，请投资者在购买过程中注意根据调查结果核对自己的风险承受能力和互联网金融风险匹配情况。无论投资者是否根据调查结果进行投资，均属投资者的独立行为，相应的风险亦由投资者独立承担。\n4、本问卷共设计了10道问题，\n每题5个备选答案，得分依次为2、4、6、8、10。投资人得分越高，说明投资者的风险承受能力越强。\n5、所有题目均为单选。 ";
    ScroLabel.font = [UIFont systemFontOfSize:14];
    [view addSubview:ScroLabel];
    
    UILabel *complyLabel = [[UILabel alloc]init];
    complyLabel.text = @"开始";
    complyLabel.textAlignment = NSTextAlignmentCenter;
    complyLabel.backgroundColor = colorWithRGB(0.95, 0.6, 0.11);
    complyLabel.textColor = [UIColor whiteColor];
    complyLabel.font = [UIFont systemFontOfSize:20];
    complyLabel.layer.masksToBounds = YES;
    complyLabel.layer.cornerRadius = 15;
    complyLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *ComPlayTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(BeginClick)];
    [complyLabel addGestureRecognizer:ComPlayTap];
    [view addSubview:complyLabel];
    
    
    [complyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view.mas_centerX);
        make.bottom.mas_equalTo(view.mas_bottom).offset(-10);
        make.width.mas_equalTo(240);
        make.height.mas_equalTo(40);
        
    }];

}
- (void)ResultClick{
    [self showResult];
}
- (void)NextClick{
    CGFloat pageWidth = RiskScroview.frame.size.width;
    
    int page = floor((RiskScroview.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    for (int i = page; i < 9; i++) {
        RiskScroview.contentOffset = CGPointMake((SCREEN_WIDTH -i*40)*(page+1), 0);
        TitleLabel.text = [NSString stringWithFormat:@"风险能力测试题（%d/10）",page+1];
        RiskBtn.hidden = NO;
        ResultBtn.hidden = YES;

    }
    if (page == 9) {
        TitleLabel.text = [NSString stringWithFormat:@"风险能力测试题（%d/10）",page+1];
        RiskBtn.hidden = YES;
        ResultBtn.hidden = NO;
    }
   
}
- (void)showResult{
    [self showMyResult];
}
- (void)showMyResult{
    NSString *grop1Str = [NSString stringWithFormat:@"%lu",(unsigned long)[MHRadioButton getIndexWithGroupId:@"group1"]];
    NSString *grop2Str = [NSString stringWithFormat:@"%lu",(unsigned long)[MHRadioButton getIndexWithGroupId:@"group2"]];
    NSString *grop3Str = [NSString stringWithFormat:@"%lu",(unsigned long)[MHRadioButton getIndexWithGroupId:@"group3"]];
    NSString *grop4Str = [NSString stringWithFormat:@"%lu",(unsigned long)[MHRadioButton getIndexWithGroupId:@"group4"]];
    NSString *grop5Str = [NSString stringWithFormat:@"%lu",(unsigned long)[MHRadioButton getIndexWithGroupId:@"group5"]];
    NSString *grop6Str = [NSString stringWithFormat:@"%lu",(unsigned long)[MHRadioButton getIndexWithGroupId:@"group6"]];
    NSString *grop7Str = [NSString stringWithFormat:@"%lu",(unsigned long)[MHRadioButton getIndexWithGroupId:@"group7"]];
    NSString *grop8Str = [NSString stringWithFormat:@"%lu",(unsigned long)[MHRadioButton getIndexWithGroupId:@"group8"]];
    NSString *grop9Str = [NSString stringWithFormat:@"%lu",(unsigned long)[MHRadioButton getIndexWithGroupId:@"group9"]];
    NSString *grop10Str = [NSString stringWithFormat:@"%lu",(unsigned long)[MHRadioButton getIndexWithGroupId:@"group10"]];
    int a1 = 2;int a2=2;int a3=2;int a4=2;int a5=2;int a6=2;int a7=2;int a8=2;int a9=2;int a10=2;
    switch ([grop1Str integerValue]) {
        case 0:
            a1 = 2;
            break;
        case 1:
            a1 = 4;
            break;
        case 2:
            a1 = 6;
            break;
        case 3:
            a1 = 8;
            break;
        case 4:
            a1 = 10;
            break;
        default:
            break;
    }
    
    switch ([grop2Str integerValue]) {
        case 0:
            a2 = 2;
            break;
        case 1:
            a2 = 4;
            break;
        case 2:
            a2 = 6;
            break;
        case 3:
            a2 = 8;
            break;
        case 4:
            a2 = 10;
            break;
        default:
            break;
    }
    switch ([grop3Str integerValue]) {
        case 0:
            a3 = 2;
            break;
        case 1:
            a3 = 4;
            break;
        case 2:
            a3 = 6;
            break;
        case 3:
            a3 = 8;
            break;
        case 4:
            a3 = 10;
            break;
        default:
            break;
    }
    switch ([grop4Str integerValue]) {
        case 0:
            a4 = 2;
            break;
        case 1:
            a4 = 4;
            break;
        case 2:
            a4 = 6;
            break;
        case 3:
            a4 = 8;
            break;
        case 4:
            a4 = 10;
            break;
        default:
            break;
    }
    switch ([grop5Str integerValue]) {
        case 0:
            a5 = 2;
            break;
        case 1:
            a5 = 4;
            break;
        case 2:
            a5 = 6;
            break;
        case 3:
            a5 = 8;
            break;
        case 4:
            a5 = 10;
            break;
        default:
            break;
    }
    switch ([grop6Str integerValue]) {
        case 0:
            a6 = 2;
            break;
        case 1:
            a6 = 4;
            break;
        case 2:
            a6 = 6;
            break;
        case 3:
            a6 = 8;
            break;
        case 4:
            a6 = 10;
            break;
        default:
            break;
    }
    switch ([grop7Str integerValue]) {
        case 0:
            a7 = 2;
            break;
        case 1:
            a7 = 4;
            break;
        case 2:
            a7 = 6;
            break;
        case 3:
            a7 = 8;
            break;
        case 4:
            a7 = 10;
            break;
        default:
            break;
    }
    switch ([grop8Str integerValue]) {
        case 0:
            a8 = 2;
            break;
        case 1:
            a8 = 4;
            break;
        case 2:
            a8 = 6;
            break;
        case 3:
            a8 = 8;
            break;
        case 4:
            a8 = 10;
            break;
        default:
            break;
    }
    switch ([grop9Str integerValue]) {
        case 0:
            a9 = 2;
            break;
        case 1:
            a9 = 4;
            break;
        case 2:
            a9 = 6;
            break;
        case 3:
            a9 = 8;
            break;
        case 4:
            a9 = 10;
            break;
        default:
            break;
    }
    switch ([grop10Str integerValue]) {
        case 0:
            a10 = 2;
            break;
        case 1:
            a10 = 4;
            break;
        case 2:
            a10 = 6;
            break;
        case 3:
            a10 = 8;
            break;
        case 4:
            a10 = 10;
            break;
        default:
            break;
    }
    int a = a1+a2+a3+a4+a5+a6+a7+a8+a9+a10;
    
    
    
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 280)];
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
    ScroLabel.text = [NSString  stringWithFormat:@"我的得分：%d分",a];
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
    oneResultLabel.frame = CGRectMake(10, 10+120, 300, 10);
    oneResultLabel.text = @"-问我说明";
    oneResultLabel.font = [UIFont systemFontOfSize:12];
    [view addSubview:oneResultLabel];
    UILabel *twoResultLabel = [[UILabel alloc]init];
    twoResultLabel.frame = CGRectMake(10, 10+150, 300, 30);
    twoResultLabel.text = @"-结果说明";
    twoResultLabel.numberOfLines = 0;
    twoResultLabel.font = [UIFont systemFontOfSize:12];
    [view addSubview:twoResultLabel];
    UILabel *ThreeResultLabel = [[UILabel alloc]init];
    ThreeResultLabel.numberOfLines = 0;
    ThreeResultLabel.frame = CGRectMake(10, 10+180, 300, 30);
    ThreeResultLabel.text = @"-结果说明";
    ThreeResultLabel.font = [UIFont systemFontOfSize:12];
    [view addSubview:ThreeResultLabel];
    NSString *riskStr;
    if (a<=40) {
        typeLabel.text = @"风险类型：保守型";
        oneResultLabel.text = @"-希望本金安全，能接受较小的价格波动";
        twoResultLabel.text = @"-愿意尝试得到大于定期存款的回报并承担较小风险，希望投资本金不因通货膨胀而贬值";
        ThreeResultLabel.hidden = YES;
        riskStr = @"1";

    }else if (a>60){
        riskStr = @"3";
        typeLabel.text = @"风险类型：积极型";
        oneResultLabel.text = @"-资产市值波动比较大，可能会低于原始投资本金";
        twoResultLabel.text = @"-能承担全部收益包括本金可能损失的风险，预期收益率较高";
        ThreeResultLabel.text = @"-偏好投资高成长性的产品或投机性产品，希望投资较快的增长，尽可能获得最高回报";
    }else{
        riskStr = @"2";
        typeLabel.text = @"风险类型：稳健型";
        oneResultLabel.text = @"-能接受适中的价格波动";
        twoResultLabel.text = @"-能承受较高的投资风险";
        ThreeResultLabel.text = @"-偏好投资兼具成长性及收益性的产品";
    }
    NSString *url;
    NSString *userID = NSuserUse(@"userId");
    NSString *tokenID = NSuserUse(@"Authorization");
    
    url = [NSString stringWithFormat:@"%@/users/%@/riskLevel",HOST_URL,userID];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithObjectsAndKeys:riskStr,@"riskLevel", nil];
    [[DateSource sharedInstance]requestHomeWithParameters:dic withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
        NSLog(@"resulrt = %@",result);
    }];
    
   

    
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
    
    
    [alertView dismissAnimated:NO];
   
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
    
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[SaleViewController class]]) {
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
