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

@interface MyLeftViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UIView *BottomView;

@end

@implementation MyLeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的余额";
    self.view.backgroundColor = [UIColor grayColor];
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(0, 7, 18, 18);
    [leftBtn setImage:[UIImage imageNamed:@"backarrow@2x.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(MyLeftClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    [self getNetworkData:YES];
    [self ConfigUI];

}
-(void)ConfigUI{
    page = 0;
    isFirstCome = YES;
    isJuhua = NO;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT- 64 -44) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    _tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tableView];
    
    _BottomView = [[UIView alloc]init];
    _BottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_BottomView];
    [_BottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(44);
    }];
    UILabel *PayLabel =[[UILabel alloc]init];
    PayLabel.text = @"充值";
    PayLabel.textColor = [UIColor whiteColor];
    PayLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *PayTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(payClick)];
    [PayLabel addGestureRecognizer:PayTap];
    PayLabel.textAlignment = NSTextAlignmentCenter;
    PayLabel.backgroundColor = [UIColor orangeColor];
    PayLabel.layer.cornerRadius = 10;
    PayLabel.layer.masksToBounds = YES;
    [self.view addSubview:PayLabel];
    [PayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_BottomView.mas_left).offset(10);
        make.centerY.mas_equalTo(_BottomView.mas_centerY);
        make.width.mas_equalTo(SCREEN_WIDTH/2-30);
        make.height.mas_equalTo(30);
    }];
    UILabel *CashLabel =[[UILabel alloc]init];
    CashLabel.text = @"提现";
    CashLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *CashTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cashClick)];
    [CashLabel addGestureRecognizer:CashTap];
    CashLabel.textColor = [UIColor whiteColor];
    CashLabel.textAlignment = NSTextAlignmentCenter;
    CashLabel.backgroundColor = [UIColor orangeColor];
    CashLabel.layer.cornerRadius = 10;
    CashLabel.layer.masksToBounds = YES;
    [self.view addSubview:CashLabel];
    [CashLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_BottomView.mas_right).offset(-10);
        make.centerY.mas_equalTo(_BottomView.mas_centerY);
        make.width.mas_equalTo(SCREEN_WIDTH/2-30);
        make.height.mas_equalTo(30);
    }];
}
- (void)payClick{
    TouUpViewController *vc = [[TouUpViewController alloc]init];
    [self.navigationController pushViewController:vc animated:NO];
}
- (void)cashClick{
    MoneyViewController *vc = [[MoneyViewController alloc]init];
    [self.navigationController pushViewController:vc animated:NO];
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
    
    NSString *url;
    NSString *userID = NSuserUse(@"userId");
    NSString *tokenID = NSuserUse(@"Authorization");
    
    url = [NSString stringWithFormat:@"%@/%@/traces",USER_URL,userID];
    NSLog(@"url = %@",url);
    [[DateSource sharedInstance]requestHtml5WithParameters:nil  withUrl:url withTokenStr:tokenID  usingBlock:^(NSDictionary *result, NSError *error) {
        NSLog(@"left result = %@",result);
       // UserDic = [result objectForKey:@"data"];
       // [self reloadData];
    }];
}
//设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  30;
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
    return 70;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        static NSString *identifier = @"mylefttopidentifier";
        
        MyLeftTopViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[MyLeftTopViewTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            [cell configUI:indexPath];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        return cell;
    }else{
        static NSString *identifier = @"myleftdetailidentifier";
        
        MyLeftDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[MyLeftDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            [cell configUI:indexPath];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
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
