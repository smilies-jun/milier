//
//  MyNewDinQiViewController.m
//  milier
//
//  Created by amin on 2017/7/24.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "MyNewDinQiViewController.h"
#import "UserViewController.h"
#import "DinQiTopTableViewCell.h"
#import "DinQiListTableViewCell.h"
#import "OldProfitViewController.h"
#import "AddProfitViewController.h"
#import "MyNewDinQiDetailViewController.h"
#import "DinQiTopModel.h"
#import "DinQiModel.h"

@interface MyNewDinQiViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *DinQiTopArray;
    NSMutableArray *DinQiDetailArray;
}

@property (nonatomic,strong)UITableView *tableView;

@end

@implementation MyNewDinQiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"定期投资";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(0, 7, 18, 18);
    [leftBtn setImage:[UIImage imageNamed:@"backarrow"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(DinQiClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    DinQiTopArray  =  [[NSMutableArray alloc]init];
    DinQiDetailArray = [[NSMutableArray alloc]init];
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
    NSString *Bottomurl;
    NSString *userID = NSuserUse(@"userId");
    NSString *tokenID = NSuserUse(@"Authorization");
    
    //定期 0 活期 8
    if (isRefresh) {
        page = 1;
        isFirstCome = YES;
    }else{
        page++;
    }
    　if (page == 1) {
        [DinQiDetailArray removeAllObjects];
        [DinQiTopArray removeAllObjects];
    }
    Bottomurl = [NSString stringWithFormat:@"%@/%@/investmentStatistics?productCategoryId=0",USER_URL,userID];


    [[DateSource sharedInstance]requestHtml5WithParameters:nil  withUrl:Bottomurl withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
        // CircleDinQiDic = [result objectForKey:@"data"];
        DinQiTopModel *model = [[DinQiTopModel alloc]init];
        model.dataDictionary = [result objectForKey:@"data"];
        [DinQiTopArray addObject:model];
         [_tableView reloadData];

//        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
//        [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    }];
        NSString *url;
    
        if (isRefresh) {
            url = [NSString stringWithFormat:@"%@?page=1&rows=20&userId=%@&productCategoryId=0",PRODUCTO_RDERS_URL,userID];
    
        }else{
            url = [NSString stringWithFormat:@"%@?page=%d&rows=20&userId=%@&productCategoryId=0",PRODUCTO_RDERS_URL,page,userID];
    
        }
   
        [[DateSource sharedInstance]requestHtml5WithParameters:nil  withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {

            NSArray *myArray = [result objectForKey:@"items"];
            for (NSDictionary *JinMidic in myArray) {
    
                DinQiModel *model = [[DinQiModel alloc]init];
                model.dataDictionary = JinMidic;
                [DinQiDetailArray addObject:model];
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
    return  1+[DinQiDetailArray count];
}


//组头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
//cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 290;
    }
    return 150;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        static NSString *identifier = @"DinQiProidentifier";
        
        DinQiTopTableViewCell   *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[DinQiTopTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            [cell configUI:indexPath];
        }
        if (DinQiTopArray.count) {
            DinQiTopModel *model = [DinQiTopArray objectAtIndex:0];
            cell.topModel = model;
        }
        [cell.OldDetailLabel addTarget:self action:@selector(OldTapClick) forControlEvents:UIControlEventTouchUpInside];
        UITapGestureRecognizer *AddDetailLabelTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(AddTapDetail)];
        [cell.AddDetailLabel addGestureRecognizer:AddDetailLabelTap];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        return cell;
    }else{
        static NSString *identifier = @"DinQiListProidentifier";
        
        DinQiListTableViewCell   *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[DinQiListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            [cell configUI:indexPath];
        }
        if (DinQiDetailArray.count) {
            DinQiModel *model = [DinQiDetailArray objectAtIndex:indexPath.row -1];
            cell.DinqiModel = model;
        }
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        return cell;
    }
    
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row > 0) {
        MyNewDinQiDetailViewController *sVC = [[MyNewDinQiDetailViewController alloc] init];
        DinQiModel *model = [DinQiDetailArray objectAtIndex:indexPath.row - 1];
        sVC.oid = model.oid;
        sVC.Type = model.transferable;
        sVC.State = model.state;
        [self.navigationController pushViewController:sVC animated:NO];
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
- (void)DinQiClick{
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
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //[self getNetworkData:YES];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
    [super viewWillDisappear:animated];
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
