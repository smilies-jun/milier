//
//  FourViewController.m
//  milier
//
//  Created by amin on 17/2/21.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "FourViewController.h"
#import "MessageTableViewCell.h"



@interface FourViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)NSMutableArray *sectionArray;
@property (nonatomic,strong)NSMutableArray *flagArray;

@property (nonatomic, assign) CGFloat rowHeight;
@property (nonatomic,strong)NSArray *MessageArray;


@end

@implementation FourViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"消息";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(0, 7, 18, 18);
    [leftBtn setImage:[UIImage imageNamed:@"backarrow@2x.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(HistoryOnTap) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    _MessageArray = [[NSArray alloc]init];
     [self getNetworkData:YES];
    [self makeData];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView setTableFooterView:[UIView new]];
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadoneNew)];
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadoneMore)];
    _tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tableView];
}
-(void)getNetworkData:(BOOL)isRefresh
{

    NSString *url;
    if (isRefresh) {
        page = 1;
        isFirstCome = YES;
    }else{
        page++;
    }
    isJuhua = NO;
    [self endRefresh];

    if (isJuhua) {
        [self endRefresh];
    }
    NSString *tokenID = NSuserUse(@"Authorization");
    if (isFirstCome) {
        url = [NSString stringWithFormat:@"%@/messages?page=1&rows=10",HOST_URL];
        
    }else{
        url = [NSString stringWithFormat:@"%@/messages?page=%d&rows=10",HOST_URL ,page];
        
    }
    
    
    [[DateSource sharedInstance]requestHtml5WithParameters:nil  withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
        _MessageArray = [result objectForKey:@"items"];
        [self makeData];
        [_tableView reloadData];
        isFirstCome = NO;
        
    }];
    
    
}
- (void)loadoneNew{
    [self getNetworkData:YES];
    
}
- (void)loadoneMore{
    [self getNetworkData:NO];
    
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

- (void)HistoryOnTap{
    [self.navigationController   popToRootViewControllerAnimated:NO];
}
/**
 *  处理数据  _sectionArray里面存储数组
 */
- (void)makeData{
    _sectionArray = [NSMutableArray array];
    _flagArray  = [NSMutableArray array];
    NSInteger num = _MessageArray.count;
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
    return 44;
}
//cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_flagArray[indexPath.section] isEqualToString:@"0"])
        return 0;
    else
         return self.rowHeight;;
}
//组头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *sectionLabel = [[UIView alloc] init];
    sectionLabel.frame = CGRectMake(0, 0, self.view.frame.size.width, 42);
    //sectionLabel.textColor = [UIColor orangeColor];
    //sectionLabel.text = [NSString stringWithFormat:@"组%ld",(long)section];
    //sectionLabel.textAlignment = NSTextAlignmentCenter;
    sectionLabel.tag = 100 + section;
    sectionLabel.userInteractionEnabled = YES;
    sectionLabel.backgroundColor = [UIColor whiteColor];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sectionClick:)];
    [sectionLabel addGestureRecognizer:tap];
    
    UIImageView *leftView = [[UIImageView alloc]init];
    leftView.image = [UIImage imageNamed:@"circle"];
    NSString *checkStr = [[_MessageArray objectAtIndex:section]objectForKey:@"checked"];
    if ([checkStr integerValue] == 1) {
        leftView.hidden = YES;
    }else{
        leftView.hidden = NO;
    }
    leftView.frame = CGRectMake(15, 15, 8, 8);
    [sectionLabel addSubview:leftView];
    UILabel *NameLabel = [[UILabel alloc]init];
    NameLabel.text = [[_MessageArray objectAtIndex:section]objectForKey:@"title"];
    NameLabel.textAlignment = NSTextAlignmentLeft;
    NameLabel.font = [UIFont systemFontOfSize:13];
    [sectionLabel addSubview:NameLabel];
    [NameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leftView.mas_right);
        make.top.mas_equalTo(sectionLabel.mas_top).offset(10);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(15);
    }];
    UILabel *timeLabel = [[UILabel alloc]init];
    NSString *timeStr = [self getTimeStr:[[_MessageArray objectAtIndex:section]objectForKey:@"createTime"] withForMat:@"yyyy-MM-dd´"];

    timeLabel.text = timeStr;
    timeLabel.textColor = colorWithRGB(0.94, 0.94, 0.94);
    timeLabel.font = [UIFont systemFontOfSize:12];
    [sectionLabel addSubview:timeLabel];
    [timeLabel   mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leftView.mas_right);
        make.top.mas_equalTo(NameLabel.mas_bottom);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(15);    }];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = colorWithRGB(0.83, 0.83, 0.83);
    lineView.frame = CGRectMake(0, 43, SCREEN_WIDTH, 0.5);
    [sectionLabel addSubview:lineView];
 
    return sectionLabel;
}

- (NSString *)getTimeStr:(NSString *)MyTimeStr withForMat:(NSString *)formatStr{
    NSTimeInterval interval=[MyTimeStr doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:formatStr];
    NSString * timeStr = [NSString stringWithFormat:@"%@",[objDateformat stringFromDate: date]];
    return timeStr;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"Cell";
    MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[MessageTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identify];
        [cell configUI:indexPath];
    }
    cell.Messagelabel.text = [[_MessageArray objectAtIndex:indexPath.section]objectForKey:@"content"];
  
    self.rowHeight = cell.rowHeight;
    cell.clipsToBounds = YES;//这句话很重要 不信你就试试
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (void)sectionClick:(UITapGestureRecognizer *)tap{
    int index = tap.view.tag % 100;
    
    NSString *oidStr = [[_MessageArray objectAtIndex:index]objectForKey:@"oid"];
    NSString *url;
    NSString *tokenID = NSuserUse(@"Authorization");
    url = [NSString stringWithFormat:@"%@/messages/%@/markAsRead",HOST_URL,oidStr];
    [[DateSource sharedInstance]requestHomeWithParameters:nil withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
        [_tableView reloadData];
    }];

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
    [_tableView reloadData];
    //	NSRange range = NSMakeRange(index, 1);
    //	NSIndexSet *sectionToReload = [NSIndexSet indexSetWithIndexesInRange:range];
    //	[_tableView reloadSections:sectionToReload withRowAnimation:UITableViewRowAnimationAutomatic];
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
