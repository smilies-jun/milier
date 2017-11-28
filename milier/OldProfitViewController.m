//
//  OldProfitViewController.m
//  milier
//
//  Created by amin on 17/4/24.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "OldProfitViewController.h"
#import "DinQiDeatilViewController.h"
#import "OldProfileTableViewCell.h"
#import "MJRefresh.h"
#import "ProfileModel.h"
#import "MyNewDinQiDetailViewController.h"
#import "MyNewDinQiViewController.h"
#import "DinQiMoneyViewController.h"

@interface OldProfitViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *AddArray;
    NSMutableArray *MyArray;

}
@property (nonatomic,strong)UITableView *tableView;
@end

@implementation OldProfitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"昨日收益";
    self.view.backgroundColor = [UIColor grayColor];
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(0, 7, 18, 18);
    [leftBtn setImage:[UIImage imageNamed:@"backarrow@2x.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(OldProfitClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    AddArray = [[NSMutableArray alloc]init];
    MyArray  = [[NSMutableArray alloc]init];
    [self ConfigUI];

    //[self getNetworkData:YES];

}

-(void)ConfigUI{
    
    isFirstCome = YES;
    isJuhua = NO;
    _tableView = [[MyTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    _tableView.backgroundColor = colorWithRGB(0.93, 0.93, 0.93);
    //_tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadoneNew)];
    //_tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadoneMore)];
    [self.view addSubview:_tableView];
    [self getNetworkData:YES];
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
    if (isRefresh) {
        page = 1;
        isFirstCome = YES;
    }else{
        page++;
    }
    NSString *userID = NSuserUse(@"userId");
    NSString *tokenID = NSuserUse(@"Authorization");
//        // 定期
//        if (isFirstCome) {
//            url = [NSString stringWithFormat:@"%@/users/%@/yesterdayEarnings?page=1&rows=20&userId=2&productCategoryId=0",HOST_URL,userID];
//            
//        }else{
//            url = [NSString stringWithFormat:@"%@/users/%@/yesterdayEarnings?page=%d&rows=20&userId=2&productCategoryId=0",HOST_URL,userID,page];
//            
//        }
    url = [NSString stringWithFormat:@"%@/users/%@/yesterdayEarnings?productCategoryId=0",HOST_URL,userID];

    [AddArray removeAllObjects];
    [MyArray removeAllObjects];
    [[DateSource sharedInstance]requestHtml5WithParameters:nil  withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
    
        MyArray = [result objectForKey:@"items"];
       NSLog(@"re == %@",result);
        if (MyArray.count) {
            for (NSDictionary *NewDic in MyArray) {
                ProfileModel *model = [[ProfileModel alloc]init];
                model.dataDictionary = NewDic;
                [AddArray addObject:model];
            }
            [self.tableView reloadData];

        }
        [self endRefresh];
        if ([[result objectForKey:@"items"]count]==0) {
            [self reset];
        }
       
    }];
}

- (void)reset{
    [self.tableView reloadData];
    
    // 拿到当前的上拉刷新控件，变为没有更多数据的状态
    [self.tableView.mj_footer endRefreshingWithNoMoreData];
}
//设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (AddArray.count) {
        return AddArray.count;
    }
    return  1;
}


//组头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
//cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (AddArray.count) {
        return 44;
    }
  return SCREEN_HEIGHT;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (AddArray.count) {
        static NSString *identifier = @"oldProidentifier";
        
        OldProfileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[OldProfileTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            [cell configUI:indexPath];
        }
        if (AddArray.count) {
            ProfileModel *model = [AddArray objectAtIndex:indexPath.row];
            cell.ProfileModel = model;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        return cell;
    }else{
        static NSString *identifier = @"NoWifeidentifier";
        NoDateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[NoDateTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            [cell configUI:indexPath];
            
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //cell.textLabel.text = @"11111111";
        return cell;
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //    SectionViewController *sVC = [[SectionViewController alloc] init];
    //    sVC.rowLabelText = [NSString stringWithFormat:@"第%ld组的第%ld个cell",(long)indexPath.section,(long)indexPath.row];
    //    [self presentViewController:sVC animated:YES completion:nil];
}

- (void)OldProfitClick{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[MyNewDinQiViewController   class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[DinQiMoneyViewController  class]]) {
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
