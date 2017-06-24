//
//  DinQiDeatilViewController.m
//  milier
//
//  Created by amin on 17/4/21.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "DinQiDeatilViewController.h"
#import "UserViewController.h"
#import "ProfilView.h"
#import "ZFChart.h"
#import "OldProfitViewController.h"
#import "AddProfitViewController.h"
#import "DinQiDetailTableViewCell.h"
#import "ChangeSailDetailViewController.h"
#import "DinQiModel.h"
#import "BundProfileViewController.h"


@interface DinQiDeatilViewController ()<UITableViewDataSource,UITableViewDelegate,ZFPieChartDelegate,ZFPieChartDataSource>{
    ProfilView *MoneyView;
    UILabel *FirstCircleLabel;
    UILabel *SecondCircleLabel;
    UILabel *ThirdCircleLabel;
    UILabel *FourCircleLabel;
    UILabel *FiveCircleLabel;
    UILabel *SixCircleLabel;
    
    NSMutableArray *MusArray;
    UILabel *OldLabel;
    UILabel *AddLabel;
    NSMutableArray *DinQiArray;
    NSDictionary *CircleDinQiDic;
    NSArray *CircleArray;
    UIButton *OldDetailLabel;
    MBProgressHUD *hud;
    
}
@property (nonatomic,strong)MyTableView *tableView;
@property (nonatomic,strong)NSArray *mysectionArray;
@property (nonatomic,strong)NSMutableArray *sectionArray;
@property (nonatomic,strong)NSMutableArray *flagArray;
@property (nonatomic,strong)NSMutableArray *MutableArray;
@property (nonatomic, strong) ZFPieChart * pieChart;

@end

@implementation DinQiDeatilViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"定期投资";
    self.view.backgroundColor = [UIColor grayColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor blackColor]}];

    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(0, 7, 18, 18);
    [leftBtn setImage:[UIImage imageNamed:@"backarrow"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(DinQiClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    DinQiArray = [[NSMutableArray alloc]init];
    MusArray = [[NSMutableArray alloc]init];
    _MutableArray = [[NSMutableArray alloc]initWithObjects:@"0", nil];
    _mysectionArray = [[NSMutableArray alloc]init];
    CircleDinQiDic = [[NSDictionary alloc]init];
    CircleArray = [[NSArray alloc]init];
    [self getNetworkData:YES];
    [self showProgress];
}
- (void)HideProgress{
    [hud hideAnimated:YES];
}
- (void)showProgress{
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
    
    // Set the label text.
    
    hud.label.text = NSLocalizedString(@"正在加载中", @"HUD loading title");
}
-(void)getNetworkData:(BOOL)isRefresh
{
    NSString *Bottomurl;
    NSString *userID = NSuserUse(@"userId");
    NSString *tokenID = NSuserUse(@"Authorization");

    //定期 0 活期 8
    if (isRefresh) {
        Bottomurl = [NSString stringWithFormat:@"%@/%@/investmentStatistics?productCategoryId=0",USER_URL,userID];
        [[DateSource sharedInstance]requestHtml5WithParameters:nil  withUrl:Bottomurl withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
            CircleDinQiDic = [result objectForKey:@"data"];
            double p2p1 = [[CircleDinQiDic objectForKey:@"p2pLoanInvestmentAmount"]doubleValue];
            double p2p2 = [[CircleDinQiDic objectForKey:@"noviceExclusiveInvestmentAmount"]doubleValue];
            double p2p3 = [[CircleDinQiDic objectForKey:@"enterpriseLoanInvestmentAmount"]doubleValue];
            double p2p4 = [[CircleDinQiDic objectForKey:@"personalLoanInvestmentAmount"]doubleValue];
            double p2p5 = [[CircleDinQiDic objectForKey:@"carLoanInvestmentAmount"]doubleValue];
            double p2p6 = [[CircleDinQiDic objectForKey:@"debentureTransferInvestmentAmount"]doubleValue];
            double value1; double value2; double value3; double value4; double value5; double value6;
            if (p2p1) {
                value1 = p2p1;
            }else{
                value1 = 0;

            }
            
            if (p2p2) {
                value2 = p2p2;
 
            }else{
                value2 =0;

            }
            if (p2p3) {
                value3 = p2p3;

            }else{
                value3 = 0;

            }
            if (p2p4) {
                value4 = p2p4;

                
            }else{
                value4 = 0;

            }
            if (p2p5) {
                value5 = p2p6;

                
            }else{
                value5 = 0;

            }
            if (p2p6) {
                value6 = p2p6;

                
            }else{
                value6 = 0;

            }
            CircleArray = [[NSArray alloc]initWithObjects:[NSString stringWithFormat:@"%.2f",value1],[NSString stringWithFormat:@"%.2f",value2],[NSString stringWithFormat:@"%.2f",value3],[NSString stringWithFormat:@"%.2f",value4],[NSString stringWithFormat:@"%.2f",value5],[NSString stringWithFormat:@"%.2f",value6], nil];
//            CircleArray = [[NSArray alloc]initWithObjects:[CircleDinQiDic objectForKey:@"p2pLoanInvestmentAmount"],[CircleDinQiDic objectForKey:@"noviceExclusiveInvestmentAmount"],[CircleDinQiDic objectForKey:@"enterpriseLoanInvestmentAmount"],[CircleDinQiDic objectForKey:@"personalLoanInvestmentAmount"],[CircleDinQiDic objectForKey:@"carLoanInvestmentAmount"],[CircleDinQiDic objectForKey:@"debentureTransferInvestmentAmount"], nil];
            [self reloadData];
            
            
            
        }];
    }
    
    
    
    NSString *url;
    if (isRefresh) {
        page = 1;
        isFirstCome = YES;
    }else{
        page++;
    }
      if (isRefresh) {
        url = [NSString stringWithFormat:@"%@?page=1&rows=5&userId=%@&productCategoryId=0",PRODUCTO_RDERS_URL,userID];

    }else{
        url = [NSString stringWithFormat:@"%@?page=%d&rows=5&userId=%@&productCategoryId=0",PRODUCTO_RDERS_URL,page,userID];

    }
    [[DateSource sharedInstance]requestHtml5WithParameters:nil  withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
        if (page == 1) {
            [DinQiArray removeAllObjects];
            [_MutableArray removeAllObjects];
            _mysectionArray = nil;
        }
        NSArray *myArray = [result objectForKey:@"items"];
            _mysectionArray = myArray;
            isJuhua = NO;
            for (NSDictionary *JinMidic in myArray) {
                
                DinQiModel *model = [[DinQiModel alloc]init];
                model.dataDictionary = JinMidic;
                [DinQiArray addObject:model];;
                int  rows = 2;
                NSArray *ChangeArray = [JinMidic objectForKey:@"InstallmentInterestList"];
                if (ChangeArray.count) {
                    rows = rows + (int)ChangeArray.count;
                }
                [_MutableArray addObject:[NSString stringWithFormat:@"%d",rows]];
                
            }
            //[self reloadData];
            
            [self makeData];
            [self HideProgress];
            [_tableView reloadData];
            [self endRefresh];
        
       

    }];
    
    
}
/**
 *  停止刷新
 */
-(void)endRefresh{
    
    if (page == 1) {
        [self.tableView.mj_header endRefreshing];
    }
    [self.tableView.mj_footer endRefreshing];
}
- (void)reloadData{
    [self ConfigUI];
}
//:@"yyyy-MM-dd HH:mm:ss.SSS"
- (void)ConfigUI{
    [self makeData];
    _tableView = [[MyTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadoneNew)];
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadoneMore)];
    [self.view addSubview:_tableView];
    [self.view addSubview:_tableView];
    



}
- (void)loadoneNew{
    [self getNetworkData:YES];
    
}
- (void)loadoneMore{
    [self getNetworkData:NO];
    
}

- (void)DinQiClick{
    [self HideProgress];
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[UserViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }}

/**
 *  处理数据  _sectionArray里面存储数组
 */
- (void)makeData{
    
  
    //有利息＋1  利息计算＋1
    //_MutableArray = [[NSMutableArray alloc]initWithObjects:@"2",@"1",@"5",@"2", nil];
    _sectionArray = [NSMutableArray array];
    _flagArray  = [NSMutableArray array];
    NSInteger num = [_MutableArray count];
    for (int i = 0; i < num+1; i ++) {
        NSMutableArray *rowArray = [NSMutableArray array];
        for (int j = 0; j < 1; j ++) {
            [rowArray addObject:[NSString stringWithFormat:@"%d",j]];
        }
        [_sectionArray addObject:rowArray];
        [_flagArray addObject:@"0"];
    }
    


}
//设置组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_MutableArray.count) {
        return _sectionArray.count;
  
    }
    return 2;
}
//设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_MutableArray.count) {
        NSArray *arr = _sectionArray[section];
        return arr.count;
    }
    return 1;
   
}
//组头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 280;
    }else{
        if (_MutableArray.count) {
            return 88;
        }
        return SCREEN_HEIGHT-280;
  
    }
}
//cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (DinQiArray.count) {
        if (_flagArray.count == _MutableArray.count+1) {
            if ([_flagArray[indexPath.section] isEqualToString:@"0"])
                return 0;
            else
                NSLog(@"self = %@",[_MutableArray objectAtIndex:indexPath.section-1]);
            
            CGFloat statuesFloat = [DinQiDetailTableViewCell tableView:tableView rowHeightForObject:[_MutableArray objectAtIndex:indexPath.section-1]];
            
            return statuesFloat;
        }else{
            return SCREEN_HEIGHT-64-44-200;
        }
        
 
    }
   
    return 0;
       
}
//组头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIView *topView = [[UIView alloc]init];
        topView.backgroundColor = [UIColor whiteColor];
        topView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 250);
        topView.userInteractionEnabled = YES;
        if (SCREEN_WIDTH == 320) {
            self.pieChart = [[ZFPieChart alloc] initWithFrame:CGRectMake(20, 30, 100, 100)];
            self.pieChart.userInteractionEnabled = NO;
            self.pieChart.dataSource= self;
            self.pieChart.delegate = self;
        }else{
            self.pieChart = [[ZFPieChart alloc] initWithFrame:CGRectMake(40, 20, 120, 120)];
            self.pieChart.userInteractionEnabled = NO;
            self.pieChart.dataSource= self;
            self.pieChart.delegate = self;
        }
   
        
        self.pieChart.piePatternType = kPieChartPatternTypeForCirque;
        //    self.pieChart.percentType = kPercentTypeInteger;
          self.pieChart.isShadow = NO;
        //    self.pieChart.isAnimated = NO;
        self.pieChart.isShowPercent = NO;
        [self.pieChart strokePath];
        [topView  addSubview:self.pieChart];
        UILabel *TitleLabel = [[UILabel alloc]init];
        TitleLabel.textAlignment = NSTextAlignmentCenter;
        TitleLabel.text = @"在投资产";
        TitleLabel.font = [UIFont systemFontOfSize:15];
        TitleLabel.textColor = colorWithRGB(0.53, 0.53, 0.53);
        [self.pieChart addSubview:TitleLabel];
        [TitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.pieChart.mas_centerX);
            make.top.mas_equalTo(topView.mas_top).offset(60);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(15);
        }];
        
        UILabel *MoneyLabel = [[UILabel alloc]init];
        if ([[CircleDinQiDic objectForKey:@"investmentAmount"]doubleValue]) {
            MoneyLabel.text = [NSString stringWithFormat:@"%@",[CircleDinQiDic objectForKey:@"investmentAmount"]];

        }else{
            MoneyLabel.text = [NSString stringWithFormat:@"0"];

        }
        MoneyLabel.textAlignment = NSTextAlignmentCenter;
        MoneyLabel.font = [UIFont systemFontOfSize:16];
        [self.pieChart addSubview:MoneyLabel];
        [MoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(TitleLabel.mas_centerX);
            make.top.mas_equalTo(TitleLabel.mas_bottom).offset(5);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(20);
        }];
        
        UIImageView *FirstImageView = [[UIImageView alloc]init];
        FirstImageView.layer.cornerRadius = 5;
        FirstImageView.clipsToBounds = YES;
        FirstImageView.backgroundColor = colorWithRGB(0.62, 0.80, 0.09);
        [topView addSubview:FirstImageView];
        [FirstImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(topView.mas_right).offset(-170);
            make.top.mas_equalTo(topView.mas_top).offset(40);
            make.width.mas_equalTo(10);
            make.height.mas_equalTo(10);
        }];
        FirstCircleLabel = [[UILabel alloc]init];
        FirstCircleLabel.textColor = colorWithRGB(0.53, 0.53, 0.53);
        if ([[CircleDinQiDic objectForKey:@"p2pLoanInvestmentAmount"]doubleValue]) {
            FirstCircleLabel.text =[NSString stringWithFormat:@"网贷基金   %@",[CircleDinQiDic objectForKey:@"p2pLoanInvestmentAmount"]];
  
        }else{
            FirstCircleLabel.text =[NSString stringWithFormat:@"网贷基金   0"];

        }
        FirstCircleLabel.textAlignment = NSTextAlignmentLeft;
        FirstCircleLabel.font = [UIFont systemFontOfSize:12];
        [topView addSubview:FirstCircleLabel];
        [FirstCircleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(FirstImageView.mas_centerY);
            make.left.mas_equalTo(FirstImageView.mas_right).offset(5);
            make.width.mas_equalTo(130);
            make.height.mas_equalTo(20);
        }];
        
        UIImageView *SecondImageView = [[UIImageView alloc]init];
        SecondImageView.layer.cornerRadius = 5;
        SecondImageView.clipsToBounds = YES;

        SecondImageView.backgroundColor = colorWithRGB(0.99, 0.79, 0.09);
        [topView addSubview:SecondImageView];
        [SecondImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(FirstImageView.mas_centerX);
            make.top.mas_equalTo(FirstImageView.mas_bottom).offset(5);
            make.width.mas_equalTo(10);
            make.height.mas_equalTo(10);
        }];
        SecondCircleLabel = [[UILabel alloc]init];
        SecondCircleLabel.textColor = colorWithRGB(0.53, 0.53, 0.53);
        if ([[CircleDinQiDic objectForKey:@"noviceExclusiveInvestmentAmount"]doubleValue]) {
            SecondCircleLabel.text = [NSString stringWithFormat:@"新手专享   %@",[CircleDinQiDic objectForKey:@"noviceExclusiveInvestmentAmount"]];

        }else{
            SecondCircleLabel.text = [NSString stringWithFormat:@"新手专享   0"];

        }
        SecondCircleLabel.textAlignment = NSTextAlignmentLeft;
        SecondCircleLabel.font = [UIFont systemFontOfSize:12];
        [topView addSubview:SecondCircleLabel];
        [SecondCircleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(SecondImageView.mas_centerY);
            make.left.mas_equalTo(SecondImageView.mas_right).offset(5);
            make.width.mas_equalTo(130);
            make.height.mas_equalTo(20);
        }];
        
        UIImageView *ThirdImageView = [[UIImageView alloc]init];
        ThirdImageView.layer.cornerRadius = 5;
        ThirdImageView.clipsToBounds = YES;

        ThirdImageView.backgroundColor = colorWithRGB(0.99, 0.52, 0.18);
        [topView addSubview:ThirdImageView];
        [ThirdImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(topView.mas_right).offset(-170);
            make.top.mas_equalTo(SecondImageView.mas_bottom).offset(5);
            make.width.mas_equalTo(10);
            make.height.mas_equalTo(10);
        }];
        ThirdCircleLabel = [[UILabel alloc]init];
        ThirdCircleLabel.textColor = colorWithRGB(0.53, 0.53, 0.53);
        if ([[CircleDinQiDic objectForKey:@"enterpriseLoanInvestmentAmount"]doubleValue]) {
            ThirdCircleLabel.text = [NSString stringWithFormat:@"企业贷款   %@",[CircleDinQiDic objectForKey:@"enterpriseLoanInvestmentAmount"]];

        }else{
            ThirdCircleLabel.text = [NSString stringWithFormat:@"企业贷款   0"];

            
        }
        ThirdCircleLabel.textAlignment = NSTextAlignmentLeft;
        ThirdCircleLabel.font = [UIFont systemFontOfSize:12];
        [topView addSubview:ThirdCircleLabel];
        [ThirdCircleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(ThirdImageView.mas_centerY);
            make.left.mas_equalTo(ThirdImageView.mas_right).offset(5);
            make.width.mas_equalTo(130);
            make.height.mas_equalTo(20);
        }];
        
        
        UIImageView *FourImageView = [[UIImageView alloc]init];
        FourImageView.layer.cornerRadius = 5;
        FourImageView.clipsToBounds = YES;

        FourImageView.backgroundColor = colorWithRGB(0.27, 0.78, 0.96);
        [topView addSubview:FourImageView];
        [FourImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(topView.mas_right).offset(-170);
            make.top.mas_equalTo(ThirdImageView.mas_bottom).offset(5);
            make.width.mas_equalTo(10);
            make.height.mas_equalTo(10);
        }];
        FourCircleLabel = [[UILabel alloc]init];
        FourCircleLabel.textColor = colorWithRGB(0.53, 0.53, 0.53);
        if ([[CircleDinQiDic objectForKey:@"personalLoanInvestmentAmount"]doubleValue]) {
            FourCircleLabel.text = [NSString stringWithFormat:@"个人贷款   %@",[CircleDinQiDic objectForKey:@"personalLoanInvestmentAmount"]];

        }else{
            FourCircleLabel.text = [NSString stringWithFormat:@"个人贷款   0"];

        }
        FourCircleLabel.textAlignment = NSTextAlignmentLeft;
        FourCircleLabel.font = [UIFont systemFontOfSize:12];
        [topView addSubview:FourCircleLabel];
        [FourCircleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(FourImageView.mas_centerY);
            make.left.mas_equalTo(FourImageView.mas_right).offset(5);
            make.width.mas_equalTo(130);
            make.height.mas_equalTo(20);
        }];
        
        UIImageView *FiveImageView = [[UIImageView alloc]init];
        FiveImageView.layer.cornerRadius = 5;
        FiveImageView.clipsToBounds = YES;

        FiveImageView.backgroundColor = colorWithRGB(0.31, 0.69, 0.10);
        [topView addSubview:FiveImageView];
        [FiveImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(topView.mas_right).offset(-170);
            make.top.mas_equalTo(FourImageView.mas_bottom).offset(5);
            make.width.mas_equalTo(10);
            make.height.mas_equalTo(10);
        }];
        FiveCircleLabel = [[UILabel alloc]init];
        FiveCircleLabel.textColor = colorWithRGB(0.53, 0.53, 0.53);
        if ([[CircleDinQiDic objectForKey:@"carLoanInvestmentAmount"]doubleValue]) {
            FiveCircleLabel.text = [NSString stringWithFormat:@"购车贷款   %@",[CircleDinQiDic objectForKey:@"carLoanInvestmentAmount"]];
 
        }else{
            FiveCircleLabel.text = [NSString stringWithFormat:@"购车贷款   0"];
 
        }
        FiveCircleLabel.textAlignment = NSTextAlignmentLeft;
        FiveCircleLabel.font = [UIFont systemFontOfSize:12];
        [topView addSubview:FiveCircleLabel];
        [FiveCircleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(FiveImageView.mas_centerY);
            make.left.mas_equalTo(FiveImageView.mas_right).offset(5);
            make.width.mas_equalTo(130);
            make.height.mas_equalTo(20);
        }];
        
        
        UIImageView *SixImageView = [[UIImageView alloc]init];
        SixImageView.layer.cornerRadius = 5;
        SixImageView.clipsToBounds = YES;
        SixImageView.backgroundColor = colorWithRGB(0.19, 0.39, 0.9);
        [topView addSubview:SixImageView];
        [SixImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(topView.mas_right).offset(-170);
            make.top.mas_equalTo(FiveImageView.mas_bottom).offset(5);
            make.width.mas_equalTo(10);
            make.height.mas_equalTo(10);
        }];
        SixCircleLabel = [[UILabel alloc]init];
        SixCircleLabel.textColor = colorWithRGB(0.53, 0.53, 0.53);
        if ([[CircleDinQiDic objectForKey:@"debentureTransferInvestmentAmount"]doubleValue]) {
            SixCircleLabel.text =[NSString stringWithFormat:@"债权转让   %@",[CircleDinQiDic objectForKey:@"debentureTransferInvestmentAmount"]];
 
        }else{
            SixCircleLabel.text =[NSString stringWithFormat:@"债权转让   0"];

        }
        SixCircleLabel.textAlignment = NSTextAlignmentLeft;
        SixCircleLabel.font = [UIFont systemFontOfSize:12];
        [topView addSubview:SixCircleLabel];
        [SixCircleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(SixImageView.mas_centerY);
            make.left.mas_equalTo(SixImageView.mas_right).offset(5);
            make.width.mas_equalTo(130);
            make.height.mas_equalTo(20);
        }];
        UIView *ImageLineView  = [[UIView alloc]init];
        ImageLineView.backgroundColor = [UIColor whiteColor];
        [topView addSubview:ImageLineView];
        [ImageLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(topView.mas_left);
            make.top.mas_equalTo(SixCircleLabel.mas_bottom).offset(40);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(1);
        }];
        //昨日收益
        UIView *OldView = [[UIView alloc]init];
        OldView.userInteractionEnabled = YES;
        UITapGestureRecognizer *OldTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(OldTap)];
        [OldView addGestureRecognizer:OldTap];
        OldView.backgroundColor = [UIColor whiteColor];
        [topView addSubview:OldView];
        [OldView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(topView.mas_left);
            make.top.mas_equalTo(ImageLineView.mas_bottom).offset(0.5);
            make.width.mas_equalTo(SCREEN_WIDTH/2);
            make.height.mas_equalTo(60);
        }];
        UIView *segeLineView = [[UIView alloc]init];
        segeLineView.backgroundColor = [UIColor whiteColor];
        [topView addSubview:segeLineView];
        [segeLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(OldView.mas_right);
            make.centerY.mas_equalTo(OldView.mas_centerY);
            make.width.mas_equalTo(1);
            make.height.mas_equalTo(50);
        }];
        UILabel *OldNamelabel = [[UILabel alloc]init];
        OldNamelabel.text = @"昨日收益";
        OldNamelabel.textAlignment = NSTextAlignmentCenter;
        OldNamelabel.font = [UIFont systemFontOfSize:12];
        OldNamelabel.textColor = colorWithRGB(0.61, 0.61, 0.61);
        [OldView addSubview:OldNamelabel];
        [OldNamelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(OldView.mas_left);
            make.top.mas_equalTo(ImageLineView.mas_bottom).offset(5);
            make.width.mas_equalTo(SCREEN_WIDTH/2);
            make.height.mas_equalTo(20);
        }];
        OldLabel = [[UILabel alloc]init];
        if ([[CircleDinQiDic objectForKey:@"yesterdayEarnings"]doubleValue]) {
            OldLabel.text = [NSString stringWithFormat:@"¥%@",[CircleDinQiDic objectForKey:@"yesterdayEarnings"]];
 
        }else{
            OldLabel.text = [NSString stringWithFormat:@"¥0"];

        }
        
        OldLabel.textAlignment = NSTextAlignmentCenter;
        OldLabel.textColor = [UIColor orangeColor];
        OldLabel.font = [UIFont systemFontOfSize:14];
        [OldView addSubview:OldLabel];
        [OldLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(OldNamelabel.mas_left);
            make.top.mas_equalTo(OldNamelabel.mas_bottom);
            make.width.mas_equalTo(SCREEN_WIDTH/2);
            make.height.mas_equalTo(30);
        }];
        OldDetailLabel = [UIButton buttonWithType:UIButtonTypeCustom];
        [OldDetailLabel setTitle:@"详情" forState:UIControlStateNormal];
        [OldDetailLabel addTarget:self action:@selector(OldTapClick) forControlEvents:UIControlEventTouchUpInside];
        OldDetailLabel.layer.borderColor = colorWithRGB(0.95, 0.6, 0.11).CGColor;
        OldDetailLabel.layer.borderWidth = 0.5f;
        OldDetailLabel.layer.masksToBounds = YES;
        OldDetailLabel.layer.cornerRadius = 10;
        [OldDetailLabel setTitleColor:colorWithRGB(0.95, 0.6, 0.11) forState:UIControlStateNormal];
        OldDetailLabel.titleLabel.font = [UIFont systemFontOfSize:14];
        [topView addSubview:OldDetailLabel];
        [OldDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(OldLabel.mas_centerX);
            make.top.mas_equalTo(OldLabel.mas_bottom);
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(20);
        }];

        UIView *AddView = [[UIView alloc]init];
        AddView.userInteractionEnabled = YES;
        UITapGestureRecognizer *AddTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(AddTap)];
        [AddView addGestureRecognizer:AddTap];
        AddView.backgroundColor = [UIColor whiteColor];
        [topView addSubview:AddView];
        [AddView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(topView.mas_right);
            make.top.mas_equalTo(ImageLineView.mas_bottom).offset(0.5);
            make.width.mas_equalTo(SCREEN_WIDTH/2);
            make.height.mas_equalTo(60);
        }];
        UILabel *AddNamelabel = [[UILabel alloc]init];
        AddNamelabel.textAlignment = NSTextAlignmentCenter;
        AddNamelabel.text = @"累计收益";
        AddNamelabel.font = [UIFont systemFontOfSize:12];
        AddNamelabel.textColor = colorWithRGB(0.61, 0.61, 0.61);
        [AddView addSubview:AddNamelabel];
        [AddNamelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(AddView.mas_left);
            make.top.mas_equalTo(ImageLineView.mas_bottom).offset(5);
            make.width.mas_equalTo(SCREEN_WIDTH/2);
            make.height.mas_equalTo(20);
        }];
        AddLabel = [[UILabel alloc]init];
        AddLabel.textAlignment = NSTextAlignmentCenter;
        if ([[CircleDinQiDic objectForKey:@"accumulatedEarnings"] doubleValue]) {
            AddLabel.text =[NSString stringWithFormat:@"¥%.2f",[[CircleDinQiDic objectForKey:@"accumulatedEarnings"] doubleValue]];

        }else{
            AddLabel.text =[NSString stringWithFormat:@"¥0"];
 
        }
        AddLabel.textColor = [UIColor orangeColor];
        AddLabel.font = [UIFont systemFontOfSize:14];
        [AddView addSubview:AddLabel];
        [AddLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(AddView.mas_left);
            make.top.mas_equalTo(AddNamelabel.mas_bottom);
            make.width.mas_equalTo(SCREEN_WIDTH/2);
            make.height.mas_equalTo(30);
        }];
        UILabel *AddDetailLabel = [[UILabel alloc]init];
        AddDetailLabel.text = @"详情";
        AddDetailLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *AddDetailLabelTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(AddTapDetail)];
        [AddDetailLabel addGestureRecognizer:AddDetailLabelTap];
        AddDetailLabel.layer.borderColor = ZFOrange.CGColor;
        AddDetailLabel.layer.borderWidth = 0.5f;
        AddDetailLabel.layer.masksToBounds = YES;
        AddDetailLabel.layer.cornerRadius = 10;
        AddDetailLabel.textAlignment = NSTextAlignmentCenter;
        AddDetailLabel.textColor = [UIColor orangeColor];
        AddDetailLabel.font = [UIFont systemFontOfSize:14];
        [topView  addSubview:AddDetailLabel];
        [AddDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(AddLabel.mas_centerX);
            make.top.mas_equalTo(AddLabel.mas_bottom);
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(20);
        }];

        
        UIView *SegeteLineView  = [[UIView alloc]init];
        SegeteLineView.backgroundColor = colorWithRGB(0.97, 0.97, 0.97);
        [topView addSubview:SegeteLineView];
        [SegeteLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(topView.mas_left);
            make.top.mas_equalTo(ImageLineView.mas_bottom).offset(100);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(10);
        }];
 
        
        return topView;
    }else{
        if (DinQiArray.count) {
            UIView *HeaderView = [[UIView alloc]init];
            HeaderView.backgroundColor = [UIColor whiteColor];
            HeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 444);
            HeaderView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ImageClick:)];
            [HeaderView addGestureRecognizer:tap];
            HeaderView.tag = 100 + section;
            
            UIView *SpaceView = [[UIView alloc]init];
            SpaceView.backgroundColor = colorWithRGB(0.97, 0.97, 0.97);
            [HeaderView addSubview:SpaceView];
            [SpaceView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(HeaderView.mas_left);
                make.top.mas_equalTo(HeaderView.mas_top);
                make.width.mas_equalTo(SCREEN_WIDTH);
                make.height.mas_equalTo(10);
            }];
            
            UIView *ImageView = [[UIView alloc]init];
            ImageView.backgroundColor = [UIColor orangeColor];
            ImageView.frame = CGRectMake(0, 10, 2, 60);
            [HeaderView addSubview:ImageView];
            
            UILabel *DinQiLabel = [[UILabel alloc]init];
            DinQiLabel.text = @"";
            DinQiLabel.font = [UIFont systemFontOfSize:14];
            DinQiLabel.frame = CGRectMake(10, 15, SCREEN_WIDTH-20, 20);
            [HeaderView addSubview:DinQiLabel];
            
            UILabel *DinQiDetailLabel = [[UILabel alloc]init];
            DinQiDetailLabel.text = @"";
            DinQiDetailLabel.textColor = colorWithRGB(0.27, 0.27, 0.27);
            DinQiDetailLabel.font = [UIFont systemFontOfSize:12];
            DinQiDetailLabel.frame = CGRectMake(10, 35, SCREEN_WIDTH-20, 18);
            [HeaderView addSubview:DinQiDetailLabel];
            
            UILabel *DinQiNameLabel = [[UILabel alloc]init];
            DinQiNameLabel.text = @"当前资产";
            DinQiNameLabel.font = [UIFont systemFontOfSize:12];
            DinQiNameLabel.frame = CGRectMake(10, 55, 200, 18);
            [HeaderView addSubview:DinQiNameLabel];
            if (SCREEN_WIDTH == 320) {
                UILabel *DinQiNnumberLabel = [[UILabel alloc]init];
                DinQiNnumberLabel.text = @"";
                DinQiNnumberLabel.textColor = colorWithRGB(0.96, 0.6, 0.11);
                DinQiNnumberLabel.textAlignment = NSTextAlignmentRight;
                DinQiNnumberLabel.font = [UIFont systemFontOfSize:12];
                DinQiNnumberLabel.frame = CGRectMake(150, 55, 100, 18);
                [HeaderView addSubview:DinQiNnumberLabel];
                
                UILabel *DinQiTotalNnumberLabel = [[UILabel alloc]init];
                DinQiTotalNnumberLabel.text = @"";
                DinQiTotalNnumberLabel.textColor = [UIColor blackColor];
                DinQiTotalNnumberLabel.textAlignment = NSTextAlignmentLeft;
                DinQiTotalNnumberLabel.font = [UIFont systemFontOfSize:12];
                DinQiTotalNnumberLabel.frame = CGRectMake(250, 55, 100, 18);
                [HeaderView addSubview:DinQiTotalNnumberLabel];
                if (DinQiArray.count) {
                    DinQiModel   *model = [DinQiArray objectAtIndex:section-1];
                    
                    DinQiNnumberLabel.text = [NSString stringWithFormat:@"%@",model.cci];
                    DinQiTotalNnumberLabel.text =[NSString stringWithFormat:@"/%@",model.ci];
                }
               
            }else{
                UILabel *DinQiNnumberLabel = [[UILabel alloc]init];
                DinQiNnumberLabel.text = @"";
                DinQiNnumberLabel.textColor = colorWithRGB(0.96, 0.6, 0.11);
                DinQiNnumberLabel.textAlignment = NSTextAlignmentRight;
                DinQiNnumberLabel.font = [UIFont systemFontOfSize:12];
                DinQiNnumberLabel.frame = CGRectMake(200, 55, 100, 18);
                [HeaderView addSubview:DinQiNnumberLabel];
                
                UILabel *DinQiTotalNnumberLabel = [[UILabel alloc]init];
                DinQiTotalNnumberLabel.text = @"";
                DinQiTotalNnumberLabel.textColor = [UIColor blackColor];
                DinQiTotalNnumberLabel.textAlignment = NSTextAlignmentLeft;
                DinQiTotalNnumberLabel.font = [UIFont systemFontOfSize:12];
                DinQiTotalNnumberLabel.frame = CGRectMake(300, 55, 100, 18);
                [HeaderView addSubview:DinQiTotalNnumberLabel];
                if (DinQiArray.count) {
                    DinQiModel   *model = [DinQiArray objectAtIndex:section-1];
                    
                    DinQiNnumberLabel.text = [NSString stringWithFormat:@"%@",model.cci];
                    DinQiTotalNnumberLabel.text =[NSString stringWithFormat:@"/%.2f",[model.ci doubleValue]];
  
                }
                
            }
            
            
            
            UIImageView *StateImageView = [[UIImageView alloc]init];
            StateImageView.image = [UIImage imageNamed:@"assignment"];
            StateImageView.frame = CGRectMake(SCREEN_WIDTH - 40, 10, 40, 40);
            [HeaderView addSubview:StateImageView];
            
            UIImageView *RowImageView = [[UIImageView alloc]init];
            RowImageView.image = [UIImage imageNamed:@"down_arrow_gray"];
            RowImageView.frame = CGRectMake(SCREEN_WIDTH - 60, 30, 18, 18);
            [HeaderView addSubview:RowImageView];
            
            
            UIProgressView *processView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
            processView.frame = CGRectMake(10, 77,SCREEN_WIDTH-20, 4);
            processView.transform = CGAffineTransformMakeScale(1.0f, 2.0f);
            processView.progressTintColor = colorWithRGB(0.96, 0.6, 0.12);
            
            [processView setProgress:0.5 animated:YES];
            processView.trackTintColor = colorWithRGB(0.93, 0.93, 0.93);
            [HeaderView addSubview:processView];
            
            
            if (DinQiArray.count) {
                DinQiModel   *model = [DinQiArray objectAtIndex:section-1];
                switch ([model.productCategoryId integerValue]) {
                    case 1:
                        ImageView.backgroundColor =  colorWithRGB(0.62, 0.80, 0.09);
                        
                        break;
                    case 2:
                        ImageView.backgroundColor = colorWithRGB(0.99, 0.79, 0.09);
                        
                        break;
                    case 3:
                        ImageView.backgroundColor =  colorWithRGB(0.99, 0.52, 0.18);
                        
                        break;
                    case 4:
                        ImageView.backgroundColor =colorWithRGB(0.27, 0.78, 0.96);
                        
                        break;
                    case 5:
                        ImageView.backgroundColor = colorWithRGB(0.31, 0.69, 0.10);
                        
                        break;
                    case 6:
                        ImageView.backgroundColor = colorWithRGB(0.19, 0.39, 0.9);
                        break;
                        
                    default:
                        break;
                }
                
                
                DinQiLabel.text = [NSString stringWithFormat:@"%@(%@)",model.name,model.nameSuffix];
                DinQiDetailLabel.text =  [NSString stringWithFormat:@"预计年化收益 %@",model.subname];
                [processView setProgress:[model.progress doubleValue]/10000 animated:YES];
                
            
                switch ([model.state integerValue]) {
                    case 1:
                        StateImageView.image = [UIImage imageNamed:@"raise"];//募集
                        
                        break;
                    case 2:
                        StateImageView.image = [UIImage imageNamed:@"interest"];//计息
                        
                        break;
                    case 3:
                        StateImageView.image = [UIImage imageNamed:@"repayment"];//一到期
                        
                        break;
                    case 4:
                        // StateImageView.image = [UIImage imageNamed:@"repayment"];//已还款
                        
                        break;
                    case 5:
                        StateImageView.image = [UIImage imageNamed:@"assignment"];//转让
                        
                        break;
                    default:
                        StateImageView.image = [UIImage imageNamed:@"repayment"];//已到期
                        
                        break;
                }
            }
            return HeaderView;
        }else{
            UIView *HeaderView = [[UIView alloc]init];
            HeaderView.backgroundColor = [UIColor whiteColor];
            HeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-280);
            
            UIImageView *imageView = [[UIImageView alloc]init];
            imageView.image = [UIImage imageNamed:@"nonedata"];
            imageView.frame = CGRectMake((SCREEN_WIDTH-172)/2, 50, 172, 114);
            [HeaderView addSubview:imageView];
            UILabel *label = [[UILabel alloc]init];
            label.text = @"暂无数据";
            label.frame = CGRectMake(0, 174, SCREEN_WIDTH, 20);
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = colorWithRGB(0.27, 0.27, 0.27);
            [HeaderView addSubview:label];
            
            
            return HeaderView;
        }
        
    }
    
}

- (void)OldTapClick{
    OldProfitViewController * oldVC  = [[OldProfitViewController alloc]init];
    [self.navigationController pushViewController:oldVC animated:NO];
}
- (void)AddTapDetail{
    AddProfitViewController * oldVC  = [[AddProfitViewController alloc]init];
    [self.navigationController pushViewController:oldVC animated:NO];
}
//昨日收益
- (void)OldTap{
    OldProfitViewController * oldVC  = [[OldProfitViewController alloc]init];
    [self.navigationController pushViewController:oldVC animated:NO];
}
//累计收益
- (void)AddTap{
    AddProfitViewController * oldVC  = [[AddProfitViewController alloc]init];
    [self.navigationController pushViewController:oldVC animated:NO];

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_MutableArray.count) {
        static NSString *identify = @"DinQiLiCaiCell";
        DinQiDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
        if (!cell) {
            cell = [[DinQiDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identify];
            [cell configUI:indexPath];
            
            
        }
        
        
        if (DinQiArray.count) {
            if (indexPath.section-1 >= 0) {
                DinQiModel *model = [DinQiArray objectAtIndex:indexPath.section-1];
                cell.DinQiModel = model;
            }
        }
        
        [cell.LookSailLabel addTarget:self action:@selector(LookClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.LookLimitLabel addTarget:self action:@selector(LimitClick:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // cell.textLabel.text= [NSString stringWithFormat:@"第%ld组的第%ld个cell",(long)indexPath.section,(long)indexPath.row];
        cell.clipsToBounds = YES;//这句话很重要 不信你就试试
        return cell;

    }else{
        static NSString *identify = @"NodateDinQiLiCaiCell";
        NoDateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
        if (!cell) {
            cell = [[NoDateTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identify];
            [cell configUI:indexPath];
        }
    
        cell.clipsToBounds = YES;//这句话很重要 不信你就试试
        return cell;

    }
    
    }
//债券转让
- (void)LimitClick:(UIButton *)btn{
    if ([btn.titleLabel.text isEqualToString:@"债权转让>>"]) {
        ChangeSailDetailViewController *ChangeVC = [[ChangeSailDetailViewController alloc]init];
        DinQiModel *model = [DinQiArray objectAtIndex:btn.tag - 100];
        ChangeVC.TitleName = [NSString stringWithFormat:@"%@",model.name];
        ChangeVC.MoneyName = [NSString stringWithFormat:@"%@",model.ci];
        ChangeVC.TimeName = [NSString stringWithFormat:@"%@",model.InterestBearingEndTime];
        ChangeVC.OrderNumber = [NSString stringWithFormat:@"%@",model.orderNo];
        [self.navigationController pushViewController:ChangeVC animated:NO];
    }else{
        NSString *Statisurl;
        NSString *tokenID = NSuserUse(@"Authorization");
        Statisurl = [NSString stringWithFormat:@"%@/products/action/deleteDebentureTransferProduct",HOST_URL];
        DinQiModel *model = [DinQiArray objectAtIndex:btn.tag - 100];

        NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithObjectsAndKeys:model.orderNo,@"orderNo", nil];;
        [[DateSource sharedInstance]requestHomeWithParameters:dic withUrl:Statisurl withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
            NSString *state = [result objectForKey:@"statusCode"];
            if ([state integerValue]  == 201) {
                [self getNetworkData:YES];
            }else{
                NSString *message = [result objectForKey:@"message"];
                normal_alert(@"提示", message, @"确定");
            }
        }];
    }
    
}
- (void)LookClick:(UIButton *)btn{
    DinQiModel *model = [DinQiArray objectAtIndex:btn.tag - 200];
    BundProfileViewController *vc= [[BundProfileViewController alloc]init];
    vc.TitleStr = @"米粒儿金融借款协议";
    vc.WebStr = [NSString stringWithFormat:@"http://weixin.milibanking.com/weixin/weixin/user/toProtocol?productinfoOrderId=%@&stp=app",model.oid];
    [self.navigationController pushViewController:vc animated:NO];

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //    SectionViewController *sVC = [[SectionViewController alloc] init];
    //    sVC.rowLabelText = [NSString stringWithFormat:@"第%ld组的第%ld个cell",(long)indexPath.section,(long)indexPath.row];
    //    [self presentViewController:sVC animated:YES completion:nil];
}
- (void)ImageClick:(UITapGestureRecognizer *)tap{
    int index = tap.view.tag % 100;
    
    NSMutableArray *indexArray = [[NSMutableArray alloc]init];
    NSArray *arr = _sectionArray[index];
    for (int i = 0; i < arr.count; i ++) {
        NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:index];
        [indexArray addObject:path];
    }
    //展开
    if ([_flagArray[index] isEqualToString:@"0"]) {
        _flagArray[index] = @"1";
        [_tableView reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationBottom];  //使用下面注释的方法就 注释掉这一句
    } else { //收起
        _flagArray[index] = @"0";
        [_tableView reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationTop]; //使用下面注释的方法就 注释掉这一句
    }
    //	NSRange range = NSMakeRange(index, 1);
    //	NSIndexSet *sectionToReload = [NSIndexSet indexSetWithIndexesInRange:range];
    //	[_tableView reloadSections:sectionToReload withRowAnimation:UITableViewRowAnimationAutomatic];
}
#pragma mark - ZFPieChartDataSource

- (NSArray *)valueArrayInPieChart:(ZFPieChart *)chart{
    
    if (CircleArray.count) {
        if ([[CircleArray objectAtIndex:0]integerValue]==0 && [[CircleArray objectAtIndex:1]integerValue]==0 && [[CircleArray objectAtIndex:2]integerValue]==0 && [[CircleArray objectAtIndex:3]integerValue]==0 &&[[CircleArray objectAtIndex:4]integerValue]==0 &&[[CircleArray objectAtIndex:5]integerValue]==0) {

            return @[@"100"];
        }else{
            return CircleArray;
            
        }
    }else{

        return @[@"100"];
    }
    
    
//      if (CircleArray.count) {
//        NSLog(@"1 = %@",CircleArray);
//    }else{
//        NSLog(@"3");
//
//        return @[@"100", @"100", @"100", @"100", @"100", @"100"];
//
//    }
}

- (NSArray *)colorArrayInPieChart:(ZFPieChart *)chart{
    if ([[CircleArray objectAtIndex:0]integerValue]==0 && [[CircleArray objectAtIndex:1]integerValue]==0 && [[CircleArray objectAtIndex:2]integerValue]==0 && [[CircleArray objectAtIndex:3]integerValue]==0 &&[[CircleArray objectAtIndex:4]integerValue]==0 &&[[CircleArray objectAtIndex:5]integerValue]==0) {
         return @[colorWithRGB(0.83, 0.83, 0.83)];
    }else{
         return @[colorWithRGB(0.62, 0.80, 0.09),colorWithRGB(0.99, 0.79, 0.09), colorWithRGB(0.99, 0.52, 0.18), colorWithRGB(0.27, 0.78, 0.96), colorWithRGB(0.31, 0.69, 1), colorWithRGB(0.19, 0.39, 0.9)];
    }
    
}

#pragma mark - ZFPieChartDelegate

- (void)pieChart:(ZFPieChart *)pieChart didSelectPathAtIndex:(NSInteger)index{
    NSLog(@"第%ld个",(long)index);
}

- (CGFloat)allowToShowMinLimitPercent:(ZFPieChart *)pieChart{
    return 5.f;
}

- (CGFloat)radiusForPieChart:(ZFPieChart *)pieChart{
    return 80.f;
}

/** 此方法只对圆环类型(kPieChartPatternTypeForCirque)有效 */
- (CGFloat)radiusAverageNumberOfSegments:(ZFPieChart *)pieChart{
    return 2.f;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getNetworkData:YES];
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
