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


@interface OldProfitViewController ()<UITableViewDataSource,UITableViewDelegate>
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
    [self ConfigUI];
}

-(void)ConfigUI{
    
    page = 0;
    isFirstCome = YES;
    isJuhua = NO;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    _tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tableView];
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
    
  return 60;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"oldidentifier";
    
    OldProfileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[OldProfileTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell configUI:indexPath];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //    SectionViewController *sVC = [[SectionViewController alloc] init];
    //    sVC.rowLabelText = [NSString stringWithFormat:@"第%ld组的第%ld个cell",(long)indexPath.section,(long)indexPath.row];
    //    [self presentViewController:sVC animated:YES completion:nil];
}

- (void)OldProfitClick{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[DinQiDeatilViewController class]]) {
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
