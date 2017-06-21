//
//  ChangeSailViewController.m
//  milier
//
//  Created by amin on 17/4/24.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "ChangeSailViewController.h"
#import "UserViewController.h"
#import "MJRefresh.h"
#import "ChangeTableViewCell.h"
#import "MyChangeModel.h"


@interface ChangeSailViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *MyChangeArray;
}
@property (nonatomic,strong)MyTableView *tableView;
@property (nonatomic,strong)UIView *BottomView;

@end

@implementation ChangeSailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"债权转让";
    self.view.backgroundColor = colorWithRGB(0.56, 0.56, 0.56);
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(0, 7, 18, 18);
    [leftBtn setImage:[UIImage imageNamed:@"backarrow@2x.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(MyChangeClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    MyChangeArray = [[NSMutableArray alloc]init];
   // [self getNetworkData:YES];
    [self ConfigUI];
    
}
-(void)ConfigUI{
    page = 1;
    isFirstCome = YES;
    isJuhua = NO;

    _tableView = [[MyTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT- 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    _tableView.tableHeaderView = [UIView new];
    _tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadoneNew)];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadoneMore)];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    self.tableView.noContentViewTapedBlock = ^{
        [self getNetworkData:YES];
    };
    
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

- (void)loadoneNew{
    [self getNetworkData:YES];
    
}
- (void)loadoneMore{
    [self getNetworkData:NO];
    
}
- (void)MyChangeClick{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[UserViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
}


-(void)getNetworkData:(BOOL)isRefresh
{
   
    if (isRefresh) {
        page = 1;
        [MyChangeArray removeAllObjects];
    }else{
        page++;
    }
    //1. 网贷基金，2. 特色产品，3. 企业贷款、4. 个人贷款，5. 购车贷款、6. 债权转让，7. 新手专享，8. 金米宝， 0. 定期（包含1 3 4 5 6 7）
    NSString *tokenID = NSuserUse(@"Authorization");
    NSString *userID = NSuserUse(@"userId");
    NSString *url;
    if (isRefresh) {
        url = [NSString stringWithFormat:@"%@/products?page=1&rows=20&productCategoryId=6&userId=%@",HOST_URL,userID];
    }else{
        url = [NSString stringWithFormat:@"%@/products?page=%d&rows=20&productCategoryId=6&userId=%@",HOST_URL,page,userID];
        
    }
    [[DateSource sharedInstance]requestHtml5WithParameters:nil  withUrl:url withTokenStr:tokenID  usingBlock:^(NSDictionary *result, NSError *error) {
        NSArray *array = [result objectForKey:@"items"];
        if (page == 1) {
            [MyChangeArray removeAllObjects];
        }
        for (NSDictionary *dic in array) {
            MyChangeModel *model = [[MyChangeModel alloc]init];
            model.dataDictionary = dic;
            [MyChangeArray addObject:model];
            
        }
        if (MyChangeArray.count) {
            [self.tableView reloadData];
            [self endRefresh];
        }else{
            [self.tableView showEmptyViewWithType:NoContentTypeNetwork];
 
        }
        
     

        // UserDic = [result objectForKey:@"data"];
        // [self reloadData];
    }];



}

//设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  MyChangeArray.count;
}


//组头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
//cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 140;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    

        static NSString *identifier = @"changedetailidentifier";
        
        ChangeTableViewCell    *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[ChangeTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
            [cell configUI:indexPath];
             cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if (MyChangeArray.count) {
            MyChangeModel *model = [MyChangeArray objectAtIndex:indexPath.row];
            cell.changeModel = model;
        }
    
    [cell.IsOrNoLabel addTarget:self action:@selector(CancelClick:) forControlEvents:UIControlEventTouchUpInside];
    return cell;

    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyChangeModel *model = [MyChangeArray objectAtIndex:indexPath.row];
    if ([model.state integerValue] == 2) {
        
    }
    //    SectionViewController *sVC = [[SectionViewController alloc] init];
    //    sVC.rowLabelText = [NSString stringWithFormat:@"第%ld组的第%ld个cell",(long)indexPath.section,(long)indexPath.row];
    //    [self presentViewController:sVC animated:YES completion:nil];
}
- (void)CancelClick:(UIButton *)btn{
    MyChangeModel *model = [MyChangeArray objectAtIndex:btn.tag - 100];
    NSString *url;
    NSString *tokenID = NSuserUse(@"Authorization");
    //url = [NSString stringWithFormat:@"%@/%@/password",USER_URL,userID];
    url = [NSString stringWithFormat:@"%@/products/%@",HOST_URL,model.oid];
   [[DateSource sharedInstance]requestDeleteWithParameters:nil withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary * dic, NSError *error) {
       NSString *stateStr = [dic objectForKey:@"statusCode"];
       if ([stateStr integerValue] == 201) {
           [self getNetworkData:YES];
       }else{
           NSString *message = [dic objectForKey:@"message"];
           normal_alert(@"提示", message, @"确定");
       }
   }];

}
- (void)OldProfitClick{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[UserViewController class]]) {
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
