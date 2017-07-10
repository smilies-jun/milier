//
//  AddOneDayViewController.m
//  milier
//
//  Created by amin on 2017/6/5.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "AddOneDayViewController.h"
#import "DinQiDeatilViewController.h"
#import "MJRefresh.h"
#import "JinMiDetdailViewController.h"
#import "AddProfitViewController.h"

#import "AddProfileModel.h"
#import "AddOneDayTableViewCell.h"

@interface AddOneDayViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *AddArray;
}
@property (nonatomic,strong)UITableView *tableView;

@end

@implementation AddOneDayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = _TitleStr;
    self.view.backgroundColor = [UIColor grayColor];
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(0, 7, 18, 18);
    [leftBtn setImage:[UIImage imageNamed:@"backarrow.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(AddProfitClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    AddArray = [[NSMutableArray alloc]init];
    
    [self getNetworkData:YES];
    [self ConfigUI];
    
}
-(void)ConfigUI{
    page = 0;
    isFirstCome = YES;
    isJuhua = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadoneNew)];
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadoneMore)];
    [self.view addSubview:_tableView];
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
    

    [self.tableView.mj_header endRefreshing];
 
    [self.tableView.mj_footer endRefreshing];
}

-(void)getNetworkData:(BOOL)isRefresh
{
    NSString *url;

    NSString *tokenID = NSuserUse(@"Authorization");
   
        
    url = [NSString stringWithFormat:@"%@/earningDetails?productCategoryId=0&date=%@",HOST_URL,_OidStr];
    NSLog(@" === %@",url);
    [[DateSource sharedInstance]requestHtml5WithParameters:nil  withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
        NSArray *myArray = [result objectForKey:@"items"];
        isJuhua = NO;
        [self endRefresh];
        [AddArray removeAllObjects];

        
        
        for (NSDictionary *NewDic in myArray) {
            AddProfileModel *model = [[AddProfileModel alloc]init];
            model.dataDictionary = NewDic;
            [AddArray addObject:model];
        }
        [self endRefresh];
        [self.tableView reloadData];
        isFirstCome = NO;
    }];
    
    
    
}
//设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  [AddArray count];
}


//组头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
//cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"AddOnedentifier";
    
    AddOneDayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[AddOneDayTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell configUI:indexPath];
    }
    
    if (AddArray.count) {
        AddProfileModel *model = [AddArray objectAtIndex:indexPath.row];
        cell.AddModel = model;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //    SectionViewController *sVC = [[SectionViewController alloc] init];
    //    sVC.rowLabelText = [NSString stringWithFormat:@"第%ld组的第%ld个cell",(long)indexPath.section,(long)indexPath.row];
    //    [self presentViewController:sVC animated:YES completion:nil];
}

- (void)AddProfitClick{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[AddProfitViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 马上进入刷新状态
    [self.tableView.mj_header beginRefreshing];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    isFirstCome = YES;
    
    [super viewWillDisappear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
