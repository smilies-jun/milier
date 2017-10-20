//
//  UnYetMoneyViewController.m
//  milier
//
//  Created by amin on 2017/8/1.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "UnYetMoneyViewController.h"
#import "UserViewController.h"
#import "UnYetTopTableViewCell.h"
#import "UnYetListTableViewCell.h"
#import "MoneyModel.h"
#import "UnYetDetailViewController.h"

@interface UnYetMoneyViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *MoneyArray;
    NSDictionary *TopMoneyArray;
}
@property (nonatomic,strong)UITableView *tableView;

@end

@implementation UnYetMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的待收";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(0, 7, 18, 18);
    [leftBtn setImage:[UIImage imageNamed:@"backarrow"] forState:UIControlStateNormal];
    
    [leftBtn addTarget:self action:@selector(UnYetClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    MoneyArray = [[NSMutableArray alloc]init];
    TopMoneyArray = [[NSDictionary alloc]init];
    [self getNetworkData:YES];
    [self ConfigUI];

}
- (void)loadoneNew{
    [self getNetworkData:YES];
    
}
- (void)loadoneMore{
    [self getNetworkData:NO];
    
}
-(void)getNetworkData:(BOOL)isRefresh
{
    NSString *url;
    NSString *tokenID = NSuserUse(@"Authorization");
    NSString *userID = NSuserUse(@"userId");

    url = [NSString stringWithFormat:@"%@/users/%@/repaymentStatistics",HOST_URL,userID];
    [[DateSource sharedInstance]requestHtml5WithParameters:nil  withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
        TopMoneyArray = [result objectForKey:@"data"];
        [_tableView reloadData];
    }];
    
    NSString *Bottomurl;
    if (isRefresh) {
        page = 1;
        isFirstCome = YES;
    }else{
        page++;
    }
    Bottomurl = [NSString stringWithFormat:@"%@/productOrderRepayments?page=%d&rows=20&userId=%@",HOST_URL,page,userID];
    if (page == 1) {
        [MoneyArray removeAllObjects];
    }
    [[DateSource sharedInstance]requestHtml5WithParameters:nil  withUrl:Bottomurl withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
        if ([[result objectForKey:@"items"] count]) {
            for (NSDictionary *dic in [result objectForKey:@"items"]) {
                MoneyModel *model = [[MoneyModel alloc]init];
                model.dataDictionary = dic;
                [MoneyArray addObject:model];
            }
            
        }
        [self endRefresh];
    [_tableView reloadData];
    }];
    

}
-(void)endRefresh{
    
    if (page == 1) {
        [self.tableView.mj_header endRefreshing];
    }
    [self.tableView.mj_footer endRefreshing];
}
-(void)ConfigUI{
    _tableView = [[MyTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = colorWithRGB(0.93, 0.93, 0.93);
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadoneNew)];
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadoneMore)];
    [self.view addSubview:_tableView];

    
}
//设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [MoneyArray count] +1;
}


//组头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
//cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 210;
    }
    return 120;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        static NSString *identifier = @"YetTopProidentifier";
        
        UnYetTopTableViewCell   *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[UnYetTopTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            [cell configUI:indexPath];
        }
        cell.TopMoneyLabel.text = [NSString stringWithFormat:@"¥%@",[TopMoneyArray objectForKey:@"repaymentTotal"]];
        cell.LostMoneyNumberLabel.text = [NSString stringWithFormat:@"¥%@",[TopMoneyArray objectForKey:@"overTotal"]];
         cell.BackMoneyNumberLabel.text = [NSString stringWithFormat:@"¥%@",[TopMoneyArray objectForKey:@"badTotal"]];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        return cell;
    }else{
        static NSString *identifier = @"YetListlProidentifier";
        
        UnYetListTableViewCell   *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[UnYetListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            [cell configUI:indexPath];
        }
        
        if (MoneyArray.count) {
            MoneyModel *model = [MoneyArray objectAtIndex:indexPath.row-1];
            cell.LostModel = model;
        }
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        return cell;
    }
    
    
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row > 0) {
        MoneyModel *model = [MoneyArray objectAtIndex:indexPath.row-1];
        UnYetDetailViewController *vc = [[UnYetDetailViewController alloc]init];
        vc.ProDateId = model.oid;
        [self.navigationController pushViewController:vc animated:YES];
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
- (void)UnYetClick{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[UserViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
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
