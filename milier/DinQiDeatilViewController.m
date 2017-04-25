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
#import "ChangeSailDetailViewController.m"


@interface DinQiDeatilViewController ()<UITableViewDataSource,UITableViewDelegate,ZFPieChartDelegate,ZFPieChartDataSource>{
    ProfilView *MoneyView;
    UILabel *FirstCircleLabel;
    UILabel *SecondCircleLabel;
    UILabel *ThirdCircleLabel;
    UILabel *FourCircleLabel;
    UILabel *FiveCircleLabel;
    UILabel *SixCircleLabel;
    
    
    UILabel *OldLabel;
    UILabel *AddLabel;
}
@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)NSMutableArray *sectionArray;
@property (nonatomic,strong)NSMutableArray *flagArray;
@property (nonatomic, strong) ZFPieChart * pieChart;

@end

@implementation DinQiDeatilViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"定期投资";
    self.view.backgroundColor = [UIColor grayColor];
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(0, 7, 18, 18);
    [leftBtn setImage:[UIImage imageNamed:@"backarrow@2x.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(DinQiClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    [self ConfigUI];
}
- (void)ConfigUI{
    [self makeData];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tableView];
    



}
- (void)DinQiClick{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[UserViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }}

/**
 *  处理数据  _sectionArray里面存储数组
 */
- (void)makeData{
    _sectionArray = [NSMutableArray array];
    _flagArray  = [NSMutableArray array];
    NSInteger num = 10;
    for (int i = 0; i < num; i ++) {
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
    return _sectionArray.count;
}
//设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr = _sectionArray[section];
    return arr.count;
}
//组头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 305;
    }else{
        return 65;
  
    }
}
//cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_flagArray[indexPath.section] isEqualToString:@"0"])
        return 0;
    else
        return 44;
}
//组头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIView *topView = [[UIView alloc]init];
        topView.backgroundColor = [UIColor whiteColor];
        topView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 250);
        
        MoneyView = [[ProfilView alloc]init];
        MoneyView.GorrowView.hidden = YES;
        [topView addSubview:MoneyView];
        [MoneyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(topView.mas_left);
            make.top.mas_equalTo(topView.mas_top).offset(10);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(40);
        }];
        
        UIView *LineView  = [[UIView alloc]init];
        LineView.backgroundColor = [UIColor grayColor];
        [topView addSubview:LineView];
        [LineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(topView.mas_left);
            make.top.mas_equalTo(MoneyView.mas_bottom).offset(1);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(1);
        }];
        
        self.pieChart = [[ZFPieChart alloc] initWithFrame:CGRectMake(40, 90, 120, 120)];
        self.pieChart.dataSource= self;
        self.pieChart.delegate = self;
        //    self.pieChart.piePatternType = kPieChartPatternTypeForCircle;
        //    self.pieChart.percentType = kPercentTypeInteger;
          self.pieChart.isShadow = NO;
        //    self.pieChart.isAnimated = NO;
        self.pieChart.isShowPercent = NO;
        [self.pieChart strokePath];
        [topView  addSubview:self.pieChart];
        UIImageView *FirstImageView = [[UIImageView alloc]init];
        FirstImageView.backgroundColor = [UIColor orangeColor];
        [topView addSubview:FirstImageView];
        [FirstImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(topView.mas_right).offset(-170);
            make.top.mas_equalTo(MoneyView.mas_bottom).offset(60);
            make.width.mas_equalTo(10);
            make.height.mas_equalTo(10);
        }];
        FirstCircleLabel = [[UILabel alloc]init];
        FirstCircleLabel.text = @"网贷基金：23232322";
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
        SecondImageView.backgroundColor = [UIColor orangeColor];
        [topView addSubview:SecondImageView];
        [SecondImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(FirstImageView.mas_centerX);
            make.top.mas_equalTo(FirstImageView.mas_bottom).offset(5);
            make.width.mas_equalTo(10);
            make.height.mas_equalTo(10);
        }];
        SecondCircleLabel = [[UILabel alloc]init];
        SecondCircleLabel.text = @"网贷基金：2222222";
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
        ThirdImageView.backgroundColor = [UIColor orangeColor];
        [topView addSubview:ThirdImageView];
        [ThirdImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(topView.mas_right).offset(-170);
            make.top.mas_equalTo(SecondImageView.mas_bottom).offset(5);
            make.width.mas_equalTo(10);
            make.height.mas_equalTo(10);
        }];
        ThirdCircleLabel = [[UILabel alloc]init];
        ThirdCircleLabel.text = @"网贷基金：23333333";
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
        FourImageView.backgroundColor = [UIColor orangeColor];
        [topView addSubview:FourImageView];
        [FourImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(topView.mas_right).offset(-170);
            make.top.mas_equalTo(ThirdImageView.mas_bottom).offset(5);
            make.width.mas_equalTo(10);
            make.height.mas_equalTo(10);
        }];
        FourCircleLabel = [[UILabel alloc]init];
        FourCircleLabel.text = @"网贷基金：4444444";
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
        FiveImageView.backgroundColor = [UIColor orangeColor];
        [topView addSubview:FiveImageView];
        [FiveImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(topView.mas_right).offset(-170);
            make.top.mas_equalTo(FourImageView.mas_bottom).offset(5);
            make.width.mas_equalTo(10);
            make.height.mas_equalTo(10);
        }];
        FiveCircleLabel = [[UILabel alloc]init];
        FiveCircleLabel.text = @"网贷基金：555555";
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
        SixImageView.backgroundColor = [UIColor orangeColor];
        [topView addSubview:SixImageView];
        [SixImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(topView.mas_right).offset(-170);
            make.top.mas_equalTo(FiveImageView.mas_bottom).offset(5);
            make.width.mas_equalTo(10);
            make.height.mas_equalTo(10);
        }];
        SixCircleLabel = [[UILabel alloc]init];
        SixCircleLabel.text = @"网贷基金：66666";
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
        ImageLineView.backgroundColor = [UIColor grayColor];
        [topView addSubview:ImageLineView];
        [ImageLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(topView.mas_left);
            make.top.mas_equalTo(SixCircleLabel.mas_bottom).offset(40);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(1);
        }];
        
        UIView *OldView = [[UIView alloc]init];
        OldView.userInteractionEnabled = YES;
        UITapGestureRecognizer *OldTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(OldTap)];
        [OldView addGestureRecognizer:OldTap];
        OldView.backgroundColor = [UIColor whiteColor];
        [topView addSubview:OldView];
        [OldView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(topView.mas_left);
            make.top.mas_equalTo(ImageLineView.mas_bottom).offset(0.5);
            make.width.mas_equalTo(SCREEN_WIDTH/2-1);
            make.height.mas_equalTo(58);
        }];
        UIView *segeLineView = [[UIView alloc]init];
        segeLineView.backgroundColor = [UIColor grayColor];
        [topView addSubview:segeLineView];
        [segeLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(OldView.mas_right);
            make.centerY.mas_equalTo(OldView.mas_centerY);
            make.width.mas_equalTo(1);
            make.height.mas_equalTo(50);
        }];
        UILabel *OldNamelabel = [[UILabel alloc]init];
        OldNamelabel.text = @"昨日收益";
        OldNamelabel.font = [UIFont systemFontOfSize:12];
        OldNamelabel.textColor = [UIColor blackColor];
        [OldView addSubview:OldNamelabel];
        [OldNamelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(OldView.mas_left).offset(20);
            make.top.mas_equalTo(ImageLineView.mas_bottom).offset(5);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(20);
        }];
        OldLabel = [[UILabel alloc]init];
        OldLabel.text = @"20000";
        OldLabel.textColor = [UIColor orangeColor];
        OldLabel.font = [UIFont systemFontOfSize:14];
        [OldView addSubview:OldLabel];
        [OldLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(OldNamelabel.mas_left);
            make.top.mas_equalTo(OldNamelabel.mas_bottom);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(30);
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
            make.width.mas_equalTo(SCREEN_WIDTH/2-1);
            make.height.mas_equalTo(58);
        }];
        UILabel *AddNamelabel = [[UILabel alloc]init];
        AddNamelabel.text = @"累计收益";
        AddNamelabel.font = [UIFont systemFontOfSize:12];
        AddNamelabel.textColor = [UIColor blackColor];
        [AddView addSubview:AddNamelabel];
        [AddNamelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(AddView.mas_left).offset(20);
            make.top.mas_equalTo(ImageLineView.mas_bottom).offset(5);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(20);
        }];
        AddLabel = [[UILabel alloc]init];
        AddLabel.text = @"20000";
        AddLabel.textColor = [UIColor orangeColor];
        AddLabel.font = [UIFont systemFontOfSize:14];
        [AddView addSubview:AddLabel];
        [AddLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(AddView.mas_left).offset(20);
            make.top.mas_equalTo(AddNamelabel.mas_bottom);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(30);
        }];

        
        UIView *SegeteLineView  = [[UIView alloc]init];
        SegeteLineView.backgroundColor = [UIColor grayColor];
        [topView addSubview:SegeteLineView];
        [SegeteLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(topView.mas_left);
            make.top.mas_equalTo(ImageLineView.mas_bottom).offset(60);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(1);
        }];
        
        
        return topView;
    }else{
        
        UIView *HeaderView = [[UIView alloc]init];
        HeaderView.backgroundColor = [UIColor whiteColor];
        HeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 444);
        HeaderView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ImageClick:)];
        [HeaderView addGestureRecognizer:tap];
        HeaderView.tag = 100 + section;

        
        UIView *ImageView = [[UIView alloc]init];
        ImageView.backgroundColor = [UIColor orangeColor];
        ImageView.frame = CGRectMake(0, 5, 2, 50);
        [HeaderView addSubview:ImageView];

        UILabel *DinQiLabel = [[UILabel alloc]init];
        DinQiLabel.text = @"投米宝－优选中期（100000元＋100元小米卷）";
        DinQiLabel.font = [UIFont systemFontOfSize:13];
        DinQiLabel.frame = CGRectMake(20, 5, 300, 20);
        [HeaderView addSubview:DinQiLabel];
        
        UILabel *DinQiDetailLabel = [[UILabel alloc]init];
        DinQiDetailLabel.text = @"预计年化收益";
        DinQiDetailLabel.font = [UIFont systemFontOfSize:11];
        DinQiDetailLabel.frame = CGRectMake(20, 25, 300, 20);
        [HeaderView addSubview:DinQiDetailLabel];
        
        UILabel *DinQiNameLabel = [[UILabel alloc]init];
        DinQiNameLabel.text = @"当前收益";
        DinQiNameLabel.font = [UIFont systemFontOfSize:10];
        DinQiNameLabel.frame = CGRectMake(20, 45, 200, 15);
        [HeaderView addSubview:DinQiNameLabel];
        
        UILabel *DinQiNnumberLabel = [[UILabel alloc]init];
        DinQiNnumberLabel.text = @"200000/222222";
        DinQiNnumberLabel.textAlignment = NSTextAlignmentLeft;
        DinQiNnumberLabel.font = [UIFont systemFontOfSize:10];
        DinQiNnumberLabel.frame = CGRectMake(260, 45, 280, 15);
        [HeaderView addSubview:DinQiNnumberLabel];
        
        
        UIImageView *StateImageView = [[UIImageView alloc]init];
        StateImageView.image = [UIImage imageNamed:@"assignment"];
        StateImageView.frame = CGRectMake(SCREEN_WIDTH - 40, -4, 40, 40);
        [HeaderView addSubview:StateImageView];
        
        UIImageView *RowImageView = [[UIImageView alloc]init];
        RowImageView.image = [UIImage imageNamed:@"goarrow"];
        RowImageView.frame = CGRectMake(SCREEN_WIDTH - 60, 20, 10, 10);
        [HeaderView addSubview:RowImageView];
        
        
        UIProgressView *processView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
        processView.frame = CGRectMake(0, 58,SCREEN_WIDTH, 2);
        processView.progressTintColor = [UIColor greenColor];
        [processView setProgress:0.5 animated:YES];
        processView.trackTintColor = [UIColor grayColor];
        [HeaderView addSubview:processView];

        
        return HeaderView;
    }
    
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
    static NSString *identify = @"Cell";
    DinQiDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[DinQiDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identify];
        [cell configUI:indexPath];
        cell.LookSailLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *LoolTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(LookClick)];
        [cell.LookSailLabel addGestureRecognizer:LoolTap];
        
        cell.LookLimitLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *LimitTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(LimitClick)];
        [cell.LookLimitLabel addGestureRecognizer:LimitTap];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

   // cell.textLabel.text= [NSString stringWithFormat:@"第%ld组的第%ld个cell",(long)indexPath.section,(long)indexPath.row];
    cell.clipsToBounds = YES;//这句话很重要 不信你就试试
    return cell;
}
//债务转让
- (void)LimitClick{
    ChangeSailDetailViewController *DetailVC = [[ChangeSailDetailViewController alloc]init];
    [self.navigationController  pushViewController:DetailVC animated:NO];
}
//查看协议
- (void)LookClick{
    NSLog(@"1212");
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
    return @[@"50", @"256", @"300", @"283", @"490", @"236"];
}

- (NSArray *)colorArrayInPieChart:(ZFPieChart *)chart{
    return @[ZFColor(71, 204, 255, 1), ZFColor(253, 203, 76, 1), ZFColor(214, 205, 153, 1), ZFColor(78, 250, 188, 1), ZFColor(16, 140, 39, 1), ZFColor(45, 92, 34, 1)];
}

#pragma mark - ZFPieChartDelegate

- (void)pieChart:(ZFPieChart *)pieChart didSelectPathAtIndex:(NSInteger)index{
    NSLog(@"第%ld个",(long)index);
}

- (CGFloat)allowToShowMinLimitPercent:(ZFPieChart *)pieChart{
    return 5.f;
}

- (CGFloat)radiusForPieChart:(ZFPieChart *)pieChart{
    return 60.f;
}

/** 此方法只对圆环类型(kPieChartPatternTypeForCirque)有效 */
- (CGFloat)radiusAverageNumberOfSegments:(ZFPieChart *)pieChart{
    return 2.f;
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
