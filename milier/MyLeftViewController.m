//
//  MyLeftViewController.m
//  milier
//
//  Created by amin on 17/4/24.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "MyLeftViewController.h"
#import "UserViewController.h"
#import "MJRefresh.h"
#import "MyLeftDetailTableViewCell.h"
#import "MyLeftTopViewTableViewCell.h"
#import "TouUpViewController.h"
#import "MoneyViewController.h"
#import "MyLeftModel.h"
#import "BundCardViewController.h"
#import "SalePassWordViewController.h"

@interface MyLeftViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSDictionary *MyMoneyDic;
    NSMutableArray *MyLeftArray;
    NSString *BankStatus;
    NSString *PassWordStr;
    NSString *BankIDStr;
}
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UIView *BottomView;

@end

@implementation MyLeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的余额";
    self.view.backgroundColor = colorWithRGB(0.93, 0.93, 0.93);
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(0, 0, 44, 44);
    [leftBtn setImage:[UIImage imageNamed:@"backarrow"] forState:UIControlStateNormal];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0,0,0,8 *SCREEN_WIDTH/375.0)];
    [leftBtn addTarget:self action:@selector(MyLeftClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    MyLeftArray = [[NSMutableArray alloc]init];
    self.tableView.backgroundColor = colorWithRGB(0.93, 0.93, 0.93);
    [self reloadMyMoney];
    [self reloadMyBankMoney];
    [self getNetworkData:YES];
    [self ConfigUI];

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
- (void)reloadMyMoney{
    NSString *Statisurl;
    NSString *userID = NSuserUse(@"userId");
    NSString *tokenID = NSuserUse(@"Authorization");
    Statisurl = [NSString stringWithFormat:@"%@/%@/statistics",USER_URL,userID];
    [[DateSource sharedInstance]requestHtml5WithParameters:nil  withUrl:Statisurl withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
        NSString *statusStr = [result objectForKey:@"statusCode"];
        if ([statusStr integerValue] == 200) {
            MyMoneyDic = [result objectForKey:@"data"];
            [self ConfigUI];
            [self.tableView reloadData];
            
        }
        
    }];
}
-(void)ConfigUI{
    page = 1;
    isFirstCome = YES;
    isJuhua = NO;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT- 64 -60) style:UITableViewStylePlain];
    _tableView.delegate = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadoneNew)];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadoneMore)];
    

    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    _tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tableView];
    
    _BottomView = [[UIView alloc]init];
    _BottomView.backgroundColor = [UIColor whiteColor];
    _BottomView.alpha = 0.9;
    [self.view addSubview:_BottomView];
    [_BottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    UILabel *PayLabel =[[UILabel alloc]init];
    PayLabel.text = @"充值";
    PayLabel.textColor = [UIColor whiteColor];
    PayLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *PayTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(payClick)];
    [PayLabel addGestureRecognizer:PayTap];
    PayLabel.textAlignment = NSTextAlignmentCenter;
    PayLabel.backgroundColor = [UIColor orangeColor];
    PayLabel.layer.cornerRadius = 20;
    PayLabel.layer.masksToBounds = YES;
    [_BottomView addSubview:PayLabel];
    [PayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_BottomView.mas_left).offset(10);
        make.centerY.mas_equalTo(_BottomView.mas_centerY);
        make.width.mas_equalTo(SCREEN_WIDTH/2-30);
        make.height.mas_equalTo(40);
    }];
    UILabel *CashLabel =[[UILabel alloc]init];
    CashLabel.text = @"提现";
    CashLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *CashTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cashClick)];
    [CashLabel addGestureRecognizer:CashTap];
    CashLabel.textColor = [UIColor orangeColor];
    CashLabel.textAlignment = NSTextAlignmentCenter;
    CashLabel.backgroundColor = [UIColor whiteColor];
    CashLabel.layer.cornerRadius = 20;
    CashLabel.layer.masksToBounds = YES;
    CashLabel.layer.borderWidth = 1.0;
    CashLabel.layer.borderColor = [UIColor orangeColor].CGColor;
    [_BottomView addSubview:CashLabel];
    [CashLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_BottomView.mas_right).offset(-10);
        make.centerY.mas_equalTo(_BottomView.mas_centerY);
        make.width.mas_equalTo(SCREEN_WIDTH/2-30);
        make.height.mas_equalTo(40);
    }];
}

- (void)reloadMyBankMoney{
    NSString *Statisurl;
    NSString *userID = NSuserUse(@"userId");
    NSString *tokenID = NSuserUse(@"Authorization");
    Statisurl = [NSString stringWithFormat:@"%@/%@",USER_URL,userID];
    [[DateSource sharedInstance]requestHtml5WithParameters:nil  withUrl:Statisurl withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
        NSString *statusStr = [result objectForKey:@"statusCode"];
      //  NSLog(@"re == %@",result);
        if ([statusStr integerValue] == 200) {
            BankStatus = [NSString stringWithFormat:@"%@",[[result objectForKey:@"data"]objectForKey:@"bankCardExist"]];
            PassWordStr = [NSString stringWithFormat:@"%@",[[result objectForKey:@"data"]objectForKey:@"dealPasswordExist"]];
            BankIDStr = [NSString stringWithFormat:@"%@",[[result objectForKey:@"data"]objectForKey:@"bankId"]];
            [self ConfigUI];
            [self.tableView reloadData];
        }
        
    }];
    
}

- (void)payClick{
    if ([BankStatus integerValue] ==1) {
        if ([PassWordStr integerValue] ==1) {
            TouUpViewController *vc = [[TouUpViewController alloc]init];
            vc.bankID = BankIDStr;
            [self.navigationController pushViewController:vc animated:NO];
        }else{
            SalePassWordViewController *vc = [[SalePassWordViewController alloc]init];
            [self.navigationController pushViewController:vc animated:NO];
  
        }
    }else{
        BundCardViewController *vc = [[BundCardViewController alloc]init];
        vc.MoneyType = @"1";
        [self.navigationController pushViewController:vc animated:NO];
    }
    
  
}
- (void)cashClick{
    if ([BankStatus integerValue] ==1) {
        if ([PassWordStr integerValue] ==1) {
            MoneyViewController *vc = [[MoneyViewController alloc]init];
            vc.moneyStr = [MyMoneyDic objectForKey:@"assets"];
            [self.navigationController pushViewController:vc animated:NO];
        }else{
            SalePassWordViewController *vc = [[SalePassWordViewController alloc]init];
            [self.navigationController pushViewController:vc animated:NO];
 
        }
    }else{
        BundCardViewController *vc = [[BundCardViewController alloc]init];
        vc.MoneyType = @"1";
        [self.navigationController pushViewController:vc animated:NO];
    }


    
 
}
- (void)MyLeftClick{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[UserViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
}
/**
 *  停止刷新
 */

-(void)getNetworkData:(BOOL)isRefresh
{
    if (isRefresh) {
        page = 1;
    }else{
        page++;
    }
    
    NSString *url;
    NSString *userID = NSuserUse(@"userId");
    NSString *tokenID = NSuserUse(@"Authorization");
    if (isRefresh) {
        url = [NSString stringWithFormat:@"%@/users/%@/traces?page=1&rows=20",HOST_URL,userID];
 
    }else{
        url = [NSString stringWithFormat:@"%@/users/%@/traces?page=%d&rows=20",HOST_URL,userID,page];

    }
    if (page ==1) {
        [MyLeftArray removeAllObjects];
    }
    [[DateSource sharedInstance]requestHtml5WithParameters:nil  withUrl:url withTokenStr:tokenID  usingBlock:^(NSDictionary *result, NSError *error) {
        NSArray *array = [result objectForKey:@"items"];
        for (NSDictionary *dic in array) {
            MyLeftModel *model = [[MyLeftModel alloc]init];
            model.dataDictionary = dic;
            [MyLeftArray addObject:model];
            
        }
        [self.tableView reloadData];
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
    if (MyLeftArray.count) {
        return  MyLeftArray.count + 1;
  
    }
    return  1 + 1;
}


//组头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
//cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 120;
    }
    if (MyLeftArray.count) {
        return 80;
 
    }
    return SCREEN_HEIGHT-64-150;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        static NSString *identifier = @"mylefttopidentifier";
        
        MyLeftTopViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[MyLeftTopViewTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            [cell configUI:indexPath];
        }
        if (MyLeftArray.count) {
            cell.NameLabel.text = [NSString stringWithFormat:@"¥%.2f",[[MyMoneyDic objectForKey:@"assets"]doubleValue]];;

        }else{
            cell.NameLabel.text= @"¥0";
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        return cell;
    }else{
        if (MyLeftArray.count) {
            static NSString *identifier = @"myleftdetailidentifier";
            
            MyLeftDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell) {
                cell = [[MyLeftDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                [cell configUI:indexPath];
            }
            if (MyLeftArray.count) {
                MyLeftModel *model = [MyLeftArray objectAtIndex:indexPath.row-1];
                cell.LeftModel = model;
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
            return cell;
        }else{
            static NSString *identifier = @"myleftNodetailidentifier";
            
            NoDateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell) {
                cell = [[NoDateTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                [cell configUI:indexPath];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
            return cell;
        }
        
       
    }
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //    SectionViewController *sVC = [[SectionViewController alloc] init];
    //    sVC.rowLabelText = [NSString stringWithFormat:@"第%ld组的第%ld个cell",(long)indexPath.section,(long)indexPath.row];
    //    [self presentViewController:sVC animated:YES completion:nil];
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
    [self reloadMyMoney];
    [self reloadMyBankMoney];
    [self getNetworkData:YES];
    [self ConfigUI];
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
