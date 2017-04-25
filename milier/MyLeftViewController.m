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
    CashLabel.text = @"体现";
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
    if (isFirstCome) {
        //url = [NSString stringWithFormat:MissBaisiImageUrl,@"",page];
    }else{
        //url = [NSString stringWithFormat:MissBaisiImageUrl,self.maxtime,page];
    }
    //    [HYBNetworking cacheGetRequest:YES shoulCachePost:YES];
    //    [HYBNetworking getWithUrl:url refreshCache:NO params:nil progress:^(int64_t bytesRead, int64_t totalBytesRead) {
    //
    //    } success:^(id response) {
    //        PPLog(@"请求成功---%@",response);
    //        [self endRefresh];
    //        isJuhua = NO; //数据获取成功后，设置为NO
    //
    //        NSDictionary *dict = (NSDictionary *)response;
    //        NSDictionary *infoDict = [dict objectForKey:@"info"];
    //        totalPage = (int)[infoDict objectForKey:@"page"];
    //        self.maxtime = [infoDict objectForKey:@"maxtime"];
    //
    //        if (page == 0) {
    //            [_pictures removeAllObjects];
    //        }
    //        //判断是否有菊花正在加载，如果有，判断当前页数是不是大于最大页数，是的话就不让加载，直接return；（因为下拉的当前页永远是最小的，所以直接return）
    //        if (isJuhua) {
    //            if (page >= totalPage) {
    //                [self endRefresh];
    //            }
    //            return ;
    //        }
    //        //没有菊花正在加载，所以设置yes
    //        isJuhua = YES;
    //        //显然下面的方法适用于上拉加载更多
    //        if (page >= totalPage) {
    //            [self endRefresh];
    //            return;
    //        }
    //        //获取模型数组
    //        NSArray *pictureArr = [dict objectForKey:@"list"];
    //        for (NSDictionary *dic in pictureArr) {
    //            MJPicture *picture = [[MJPicture alloc]init];
    //            [picture setValuesForKeysWithDictionary:dic];
    //            [self.pictures addObject:picture];
    //        }
    //        [self.tableView reloadData];
    //        //获取成功一次就判断
    //        isFirstCome = NO;
    //
    //
    //    } fail:^(NSError *error) {
    //        PPLog(@"请求失败---%@",error);
    //    }];
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
