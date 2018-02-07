//
//  NewRiskViewController.m
//  milier
//
//  Created by amin on 2017/11/21.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "NewRiskViewController.h"
#import "TadayExamTableViewCell.h"
#import "SaleViewController.h"
#import "UserViewController.h"

#import "SingChooseTableView.h"
#import "ZSSaveTools.h"
#import "tadayExamCollectionViewCell.h"
#import "UIView+WHC_AutoLayout.h"
#import "UITableViewCell+WHC_AutoHeightForCell.h"
#import <AwAlertViewlib/AwAlertViewlib.h>

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define FONT(a)  [UIFont fontWithName:@"Heiti SC" size:a]


#define Ktimer 10
@interface NewRiskViewController ()<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{
    NSMutableArray *titleArray;
    NSMutableArray *OptionesArray;
    UILabel *timeLabel;
     AwAlertView *alertView;
    NSArray *_titleArr;
    //正确的
    UILabel *correntLabel;
    /**
     *  错误的个数
     */
    UILabel *errorLabel;
    
    /**
     *  题目
     */
    UILabel *titleLabel;
    
    TadayExamTableViewCell *cell;
    
    //  SingChooseTableView *MyTable;
    
    //    MulChooseTable *mulchooseTabView;
    
    //  NSMutableArray * dataArr;
    /**
     *  目录
     */
    UIButton *catalogBtn;
    /**
     *  答题卡view
     */
    UIView *anmitionView;
    
    
    /**
     *  scrollView偏移量
     */
    //    NSInteger indexPage;
    
    // NSInteger index;
    
    
}

@property(nonatomic,assign) NSInteger Current;

@property(nonatomic,strong)NSTimer *countTimer;

@property(nonatomic,strong)UIView *headView;

@property(nonatomic,strong)UIScrollView *scrollView;

@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)    SingChooseTableView *MyTable;
/**
 *  存放答案的字典
 */
@property(nonatomic,strong)NSMutableDictionary *answerDict;

@property(nonatomic,assign)NSInteger tableIndex;
/**
 *  scrollView偏移量
 */

@property(nonatomic,assign)  NSInteger indexPage;
/**
 *  多选答案的数组
 */
@property(nonatomic,strong)NSMutableArray *mulChooseArr;
/**
 *  答案数组
 */
@property(nonatomic,strong)NSMutableArray *dataArr;
/**
 *  存放题目选项数组
 */
@property(nonatomic,strong)NSMutableArray *bigArr;
/**
 *  存放问题的题目数组
 */
@property(nonatomic,strong)NSMutableArray *titlequestArr;
/**
 *  存放block回调的多选答案数组
 */
@property(nonatomic,strong)NSArray *pathArr;


/**
 *  正确答案数组
 */
@property(nonatomic,strong)NSMutableArray *trueAnsArr;

/**
 *  错误答案数组
 */
@property(nonatomic,strong)NSMutableArray *errorAnsArr;

/**
 *  模考回答正确的数组
 */
@property(nonatomic,strong)NSMutableArray *scoreArr;
/**
 *  交卷数组
 */
@property(nonatomic,strong)NSMutableArray *handArr;

@property(nonatomic,assign)NSInteger removeTag;


@end

@implementation NewRiskViewController

-(NSMutableArray *)scoreArr{
    if (!_scoreArr) {
        _scoreArr = [NSMutableArray array];
    }
    return _scoreArr;
}

-(NSMutableArray *)titlequestArr{
    if (!_titlequestArr) {
        _titlequestArr = [NSMutableArray array];
    }
    return _titlequestArr;
}

-(NSMutableArray *)bigArr{
    if (!_bigArr) {
        _bigArr = [NSMutableArray array];
    }
    return _bigArr;
}

-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

-(NSMutableArray *)mulChooseArr{
    if (!_mulChooseArr) {
        _mulChooseArr = [NSMutableArray array];
    }
    return _mulChooseArr;
}

-(NSMutableDictionary *)answerDict{
    if (!_answerDict) {
        _answerDict = [NSMutableDictionary dictionary];
    }
    return _answerDict;
}

-(void)viewWillAppear:(BOOL)animated{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"MyChooseAnswer"];
    [defaults removeObjectForKey:@"scrollViewAnswer"];
    [defaults removeObjectForKey:@"answerDict"];
    [defaults removeObjectForKey:@"cellTagIndex"];
    [defaults removeObjectForKey:@"string"];
    // [defaults removeObjectForKey:@"historyExam"];
    
    [defaults synchronize];
     [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
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
- (void)ShowAlert{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 500)];
    view.backgroundColor=[UIColor whiteColor];
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 5.0f;
    view.alpha = 0.9;
    
    
    UILabel *label = [[UILabel alloc]init];
    label.text = @"风险承受能力测试问卷";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:15];
    label.frame = CGRectMake(10, 20, SCREEN_WIDTH - 70, 20);
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
    complyLabel.layer.cornerRadius = 20;
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
    UIImageView *CanCelView = [[UIImageView alloc]init];
    UITapGestureRecognizer *tapClick = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SureBackBtn)];
    CanCelView.userInteractionEnabled = YES;
    [CanCelView addGestureRecognizer:tapClick];
    CanCelView.image = [UIImage imageNamed:@"close"];
    CanCelView.frame = CGRectMake(SCREEN_WIDTH - 30, 10, 20, 20);
    [view addSubview:CanCelView];
    
    
    alertView=[[AwAlertView alloc]initWithContentView:view];
    alertView.isUseHidden=NO;
    [alertView showAnimated:YES];
}
- (void)BeginClick{
    [alertView dismissAnimated:NO];
    
}
- (void)SureBackBtn{
    [alertView dismissAnimated:NO];
//    for (UIViewController *controller in self.navigationController.viewControllers) {
//        if ([controller isKindOfClass:[UserViewController class]]) {
//            [self.navigationController popToViewController:controller animated:YES];
//        }
//    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    titleArray =[[NSMutableArray  alloc]init];
    OptionesArray = [[NSMutableArray alloc]init];
    self.navigationItem.title = @"风险评估";
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
    
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(0, 0, 44, 44);
    [leftBtn setImage:[UIImage imageNamed:@"backarrow"] forState:UIControlStateNormal];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0,0,0,8 *SCREEN_WIDTH/375.0)];
    [leftBtn addTarget:self action:@selector(RiskTap) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.view.backgroundColor = colorWithRGB(0.94, 0.94, 0.94);
    [self reloadData];
    self.IsPractice = YES;
    
     [self ShowAlert];
    _indexPage = 1;
    _handArr = [NSMutableArray array];
    
}
- (void)reloadData{
    NSString *url;
    NSString *tokenID = NSuserUse(@"Authorization");
    
    url = [NSString stringWithFormat:@"%@/questions",HOST_URL];
    [[DateSource sharedInstance]requestHtml5WithParameters:nil  withUrl:url withTokenStr:tokenID  usingBlock:^(NSDictionary *result, NSError *error) {
        NSArray *MyArray = [result objectForKey:@"items"];
        for (NSDictionary *myDic in MyArray) {
            [titleArray addObject:[myDic objectForKey:@"question"]];
            [OptionesArray addObject:[myDic objectForKey:@"options"]];

        }
        [self InitUi];
    }];
}
- (void)InitUi{
    UIImageView*   _TotalImageView = [[UIImageView alloc]init];
    _TotalImageView.image = [UIImage imageNamed:@"tip_orange"];
    [self.view addSubview:_TotalImageView];
    [_TotalImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(80);
        make.top.mas_equalTo(self.view.mas_top).offset(15);
        make.width.mas_equalTo(13);
        make.height.mas_equalTo(13);
    }];
    
    UILabel *_TitleLable = [[UILabel alloc]init];
    _TitleLable.text = @"左右滑动屏幕跳转到上一题／下一题";
    _TitleLable.font = [UIFont systemFontOfSize:13];
    _TitleLable.textColor = colorWithRGB(0.96, 0.6, 0.11);
    [self.view addSubview:_TitleLable];
    [_TitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_TotalImageView.mas_right).offset(5);
        make.centerY.mas_equalTo(_TotalImageView.mas_centerY);
        make.width.mas_equalTo(280);
        make.height.mas_equalTo(20);
    }];
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    //确定水平滑动方向
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    //   [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];垂直方向
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(20, 40, SCREEN_WIDTH-40, SCREEN_HEIGHT-130) collectionViewLayout:flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.scrollEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    //注册Cell，必须要有
    [self.collectionView registerClass:[tadayExamCollectionViewCell class] forCellWithReuseIdentifier:@"tadayExamCollectionViewCell"];
    [self.view addSubview:self.collectionView];
    
   
    //_dataArr = [NSMutableArray arrayWithObjects:@"后冠的吴茜莉妙答参议员针对“南海仲裁”的提问年仅20岁的王汉民",@"吴茜莉妙答参议员针对“南海仲裁",@"后冠的吴茜莉妙答参议员针对“南海仲裁”的提问年仅20岁的王汉",@"后冠的吴茜莉妙答参议员针对“南海仲裁”的提问年仅20岁的王汉民", @"南海仲裁”的提问年仅20岁的王汉民",nil];
}
#pragma mark - scrollView代理
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    /**
     *  视图滚动时将存储到本地的答案删除
     */
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"MyChooseAnswer"];
    
    
    CGPoint point = scrollView.contentOffset;
    
    _indexPage = (int)point.x/SCREEN_WIDTH + 1;
    
    
    [defaults synchronize];
    
    
    
}



-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return titleArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *Idenfire = @"tadayExamCollectionViewCell";
    UICollectionViewCell *mycell = [collectionView dequeueReusableCellWithReuseIdentifier:Idenfire forIndexPath:indexPath];
    mycell.layer.cornerRadius = 20;
    if (mycell) {
        
        for (UIView *view in mycell.contentView.subviews) {
            if (view) {
                [view removeFromSuperview];
            }}}
    
  
    __weak typeof(self)weakSelf = self;
    self.pathArr = [NSMutableArray array];
        //单选
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.font = [UIFont systemFontOfSize:15];
        titleLabel.text = [NSString stringWithFormat:@"风险能力测试(%ld/10)",indexPath.row+1];
        titleLabel.frame = CGRectMake(10, 20, SCREEN_WIDTH-60, 20);
        [mycell.contentView addSubview:titleLabel];
    
  
    __block NSIndexPath *test =[NSIndexPath indexPathForRow:indexPath.row+1 inSection:0];
    
        _MyTable = [SingChooseTableView ShareTableWithFrame:CGRectMake(0, 40, SCREEN_WIDTH-40, self.view.frame.size.height-160)];
        _MyTable.layer.cornerRadius =20;
        NSMutableArray *dateArray = [[NSMutableArray alloc]init];
        NSArray *myArray = [OptionesArray objectAtIndex:indexPath.row];
        for (int i=0; i<5; i++) {
            [dateArray addObject:[[myArray objectAtIndex:i]objectForKey:@"option"] ];
        }
        _MyTable.dataArr =    dateArray;
        [_MyTable createHeadView:[NSString stringWithFormat:@"%ld:%@",indexPath.row+1,[titleArray objectAtIndex:indexPath.row]]];
        NSString *str = [NSString stringWithFormat:@"%ld",indexPath.row+1];
        [ZSSaveTools setObject:str forKey:@"string"];
    
    
    
    
  
    //选中内容
        _MyTable.block = ^(NSString *chooseContent,NSIndexPath *indePath){
        //weakSelf.removeTag = 1024;
        weakSelf.tableIndex = indePath.row+1;
        //存储
        [weakSelf.answerDict setValue:[NSString stringWithFormat:@"%ld",weakSelf.tableIndex]forKey:[NSString stringWithFormat:@"%ld",indexPath.row+1]];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setValue:weakSelf.answerDict forKey:@"answerDict"];
        [defaults synchronize];
        NSString *str = [NSString stringWithFormat:@"%ld",indexPath.row+1];
        [ZSSaveTools setObject:str forKey:@"string"];
     
            if (indexPath.row <9) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                     [self.collectionView setContentOffset:CGPointMake((SCREEN_WIDTH-40)*(indexPath.row +1), 0)];
                });

            }
           
    };
        
        
    
        [mycell.contentView addSubview:self.MyTable];
    
    UIButton *  ResultBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    ResultBtn.frame = CGRectMake(10, SCREEN_HEIGHT-210, SCREEN_WIDTH-60, 40);
    if (indexPath.row == 9) {
        ResultBtn.hidden = NO;
    }else{
        ResultBtn.hidden = YES;
    }
    [ResultBtn setTitle:@"进行保存" forState:UIControlStateNormal];
    ResultBtn.layer.masksToBounds = YES;
    ResultBtn.layer.cornerRadius = 20;
    [ResultBtn addTarget:self action:@selector(ResultClick) forControlEvents:UIControlEventTouchUpInside];
    ResultBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    ResultBtn.backgroundColor = [UIColor orangeColor];
    ResultBtn.tintColor = [UIColor whiteColor];
    [mycell.contentView addSubview:ResultBtn];
   
    
    return mycell;
}

#pragma mark - 用户单选的时候
/**
 *  单选
 *
 *  @param flast      错误答案
 *  @param tureAnswer 正确答案
 *  @param JieXi      解析
 */
-(void)ExamAnswerWith:(NSString *)flast andWith:(NSString *)tureAnswer AndWith:(NSString *)JieXi andWithTitle:(NSString *)title andWith:(NSString *)seqStr{
    NSLog(@"");
    
    
}

- (void)ResultClick{
     __weak typeof(self)weakSelf = self;
    NSArray *keyArray = [weakSelf.answerDict allKeys];
    if (keyArray.count <10) {
     normal_alert(@"提示", @"您还有题目未选择", @"确定");
    }else {
        int MyCount = 0;
        for (int i = 0; i < keyArray.count; i++) {
            //根据键值处理字典中的每一项
            NSString *key = keyArray[i];
            NSString *value = weakSelf.answerDict[key];
            switch (value.integerValue) {
                case 1:
                    MyCount+=2;
                    break;
                case 2:
                     MyCount+=4;
                    break;
                case 3:
                     MyCount+=6;
                    break;
                case 4:
                     MyCount+=8;
                    break;
                case 5:
                     MyCount+=10;
                    break;
                default:
                    break;
            }
            
        }
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 320)];
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
        ScroLabel.text = [NSString  stringWithFormat:@"我的得分：%d分",MyCount];
        ScroLabel.font = [UIFont systemFontOfSize:12];
        [view addSubview:ScroLabel];
        
        UILabel *typeLabel = [[UILabel alloc]init];
        typeLabel.frame = CGRectMake(10, 10+70, 200, 10);
        
        
        typeLabel.text = @"风险类型：稳健型";
        typeLabel.font = [UIFont systemFontOfSize:14];
        [view addSubview:typeLabel];
        
        UILabel *resultLabel = [[UILabel alloc]init];
        resultLabel.frame = CGRectMake(10, 10+100, 100, 20);
        resultLabel.text = @"结果说明";
        resultLabel.font = [UIFont systemFontOfSize:12];
        [view addSubview:resultLabel];
        
        UILabel *oneResultLabel = [[UILabel alloc]init];
        oneResultLabel.frame = CGRectMake(10, 10+120, 300, 40);
        oneResultLabel.text = @"-问我说明";
        oneResultLabel.numberOfLines = 0;
        oneResultLabel.font = [UIFont systemFontOfSize:14];
        [view addSubview:oneResultLabel];
        UILabel *twoResultLabel = [[UILabel alloc]init];
        twoResultLabel.frame = CGRectMake(10, 10+150, 300, 40);
        twoResultLabel.text = @"-结果说明";
        twoResultLabel.numberOfLines = 0;
        twoResultLabel.font = [UIFont systemFontOfSize:14];
        [view addSubview:twoResultLabel];
        UILabel *ThreeResultLabel = [[UILabel alloc]init];
        ThreeResultLabel.numberOfLines = 0;
        ThreeResultLabel.frame = CGRectMake(10, 20+180, 300, 40);
        ThreeResultLabel.text = @"-结果说明";
        ThreeResultLabel.font = [UIFont systemFontOfSize:14];
        [view addSubview:ThreeResultLabel];
        NSString *riskStr;
        if (MyCount<=40) {
            typeLabel.text = @"风险类型：保守型";
            oneResultLabel.text = @"-希望本金安全，能接受较小的价格波动";
            twoResultLabel.text = @"-愿意尝试得到大于定期存款的回报并承担较小风险，希望投资本金不因通货膨胀而贬值";
            ThreeResultLabel.hidden = YES;
            riskStr = @"1";
            
        }else if (MyCount>60){
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
        
         NSuserSave(riskStr, @"riskLevel");
        [[DateSource sharedInstance]requestHomeWithParameters:dic withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
            if ([[result objectForKey:@"statusCode"]integerValue]==201) {
                NSuserSave(riskStr, @"riskLevel");
                
            }
        }];
        
        
        
        
        UILabel *complyLabel = [[UILabel alloc]init];
        complyLabel.text = @"完成,谢谢参与!";
        complyLabel.textAlignment = NSTextAlignmentCenter;
        complyLabel.backgroundColor = colorWithRGB(0.95, 0.6, 0.11);
        complyLabel.textColor = [UIColor whiteColor];
        complyLabel.font = [UIFont systemFontOfSize:15];
        complyLabel.layer.masksToBounds = YES;
        complyLabel.layer.cornerRadius = 20;
        complyLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *ComPlayTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ComClick)];
        [complyLabel addGestureRecognizer:ComPlayTap];
        [view addSubview:complyLabel];
        
        
        [complyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(view.mas_centerX);
            make.bottom.mas_equalTo(view.mas_bottom).offset(-10);
            make.width.mas_equalTo(SCREEN_WIDTH - 40);
            make.height.mas_equalTo(40);
            
        }];

        NSuserSave(@"1", @"Risk");
    }
   
    
  
    
}


- (void)ComClick{
    
    
    [alertView dismissAnimated:NO];
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[SaleViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[UserViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
    
    
    
}
- (void)showResult{
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
   NSLog(@"点击%ld",indexPath.row);
    
}

#pragma mark --UICollectionViewDelegate
- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0); // 上, 左, 下, y右
}


#pragma mark --设置每个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(SCREEN_WIDTH-40 , SCREEN_HEIGHT-100);
}

//定义每个UICollectionView 的 margin
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
// 两行之间的最小间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}









#pragma mark - 字典转json
-(NSString *)changeJsonStrWith:(NSMutableArray *)hanArr{
    
    //将字典转为json格式的数据
    // NSJSONWritingPrettyPrinted 转化的json数据有换位符 /n
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:hanArr options:0 error:nil];
    NSMutableData *data = [NSMutableData dataWithData:jsonData];
    NSString *JsonStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    return JsonStr;
    
}

-(NSMutableArray *)trueAnsArr{
    if (!_trueAnsArr) {
        _trueAnsArr = [NSMutableArray array];
    }
    return _trueAnsArr;
}
-(NSMutableArray *)errorAnsArr{
    if (!_errorAnsArr) {
        _errorAnsArr = [NSMutableArray array];
    }
    return _errorAnsArr;
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
