//
//  ConvertViewController.m
//  milier
//
//  Created by amin on 17/5/3.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "ConvertViewController.h"
#import "MyJiFenViewController.h"
#import "MJRefresh.h"
#import "OldProfileTableViewCell.h"
#import "ConvertTableViewCell.h"
#import "CostViewController.h"
#import "SubstanceViewController.h"
#import "giftModel.h"


@interface ConvertViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *JiFenArray;
}
@property (nonatomic,strong)UITableView *tableView;


@end

@implementation ConvertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"兑换礼品";
    self.view.backgroundColor = [UIColor grayColor];
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(0, 7, 18, 18);
    [leftBtn setImage:[UIImage imageNamed:@"backarrow@2x.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(ConvertClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    JiFenArray = [[NSMutableArray alloc]init];
    [self getNetworkData:YES];
    [self ConfigUI];
}
- (void)ConvertClick{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[MyJiFenViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
}
-(void)ConfigUI{
    
    page = 0;
    isFirstCome = YES;
    isJuhua = NO;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadoconNew)];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadconMore)];
    _tableView.tableFooterView = [UIView new];
    _tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tableView];
}
- (void)loadoconNew{
    [self getNetworkData:YES];
    
}
- (void)loadconMore{
    [self getNetworkData:NO];
    
}
/**
 *  停止刷新
 */
-(void)endRefresh{
    
    if (page == 0) {
        [self.tableView.mj_header endRefreshing];
    }
    [self.tableView.mj_footer endRefreshing];
}


-(void)getNetworkData:(BOOL)isRefresh
{
    if (isRefresh) {
        page = 0;
        isFirstCome = YES;
    }else{
        page++;
    }
    //1. 网贷基金，2. 特色产品，3. 企业贷款、4. 个人贷款，5. 购车贷款、6. 债权转让，7. 新手专享，8. 金米宝， 0. 定期（包含1 3 4 5 6 7）
    NSString *tokenID = NSuserUse(@"Authorization");
    //  NSString *userID = NSuserUse(@"userId");
    
    NSString *url;
    if (isFirstCome) {
        url = [NSString stringWithFormat:@"%@/commodities?page=1&rows=20",HOST_URL];
    }else{
        url = [NSString stringWithFormat:@"%@/commodities?page=%d&rows=20",HOST_URL,page];
        
    }
    [[DateSource sharedInstance]requestHtml5WithParameters:nil  withUrl:url withTokenStr:tokenID  usingBlock:^(NSDictionary *result, NSError *error) {
        for (NSDictionary *dic  in [result objectForKey:@"items"]) {
            giftModel *model = [[giftModel alloc]init];
            model.dataDictionary = dic;
            [JiFenArray addObject:model];
        }
        
        [self.tableView reloadData];
        
        [self endRefresh];
       
    }];
    
    
}
//设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  [JiFenArray count];
}


//组头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
//cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"Convertidentifier";
    
    ConvertTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[ConvertTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell configUI:indexPath];
    }
    if (JiFenArray.count) {
        giftModel *model = [JiFenArray objectAtIndex:indexPath.row];
        cell.GiftModel = model;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    giftModel *model = [JiFenArray objectAtIndex:indexPath.row];
    if ([model.type integerValue] == 1) {
        CostViewController *vc = [[CostViewController alloc]init];
        vc.NameStr = model.name;
        vc.ProductID = model.oid;
        vc.ScoreStr = [NSString stringWithFormat:@"%@",model.score];
        [self.navigationController   pushViewController:vc animated:NO];
    }else{
        SubstanceViewController *vc = [[SubstanceViewController alloc]init];
        vc.NameStr = model.name;
        vc.ProductID = model.oid;
        vc.ScoreStr = [NSString stringWithFormat:@"%@",model.score];
        [self.navigationController   pushViewController:vc animated:NO];

    }
    

    
    //    SectionViewController *sVC = [[SectionViewController alloc] init];
    //    sVC.rowLabelText = [NSString stringWithFormat:@"第%ld组的第%ld个cell",(long)indexPath.section,(long)indexPath.row];
    //    [self presentViewController:sVC animated:YES completion:nil];
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
