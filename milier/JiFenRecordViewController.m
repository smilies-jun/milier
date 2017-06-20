//
//  JiFenRecordViewController.m
//  milier
//
//  Created by amin on 17/4/24.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "JiFenRecordViewController.h"
#import "JiFenRecordTableViewCell.h"
#import "JiFenModel.h"


@interface JiFenRecordViewController ()<UITableViewDelegate, UITableViewDataSource>{
    NSMutableArray *MyArray;
}
@property(strong, nonatomic)MyTableView *tableView;

@end

@implementation JiFenRecordViewController
static NSString * const cellId = @"cellID";

- (void)viewDidLoad{
    
    [super viewDidLoad];
    UIView *saleView = [[UIView alloc]init];
    saleView.backgroundColor = [UIColor whiteColor];
    saleView.frame = CGRectMake(0, SCREEN_HEIGHT - 64-60, SCREEN_WIDTH, 60);
    [self.view addSubview:saleView];
    MyArray = [[NSMutableArray alloc]init];
    UILabel *SaleLbel =  [[UILabel alloc]init];
    SaleLbel.text = @"兑换礼品";
    SaleLbel.userInteractionEnabled = YES;
    SaleLbel.backgroundColor = colorWithRGB(0.95, 0.60, 0.11);
    SaleLbel.textAlignment = NSTextAlignmentCenter;
    SaleLbel.textColor = [UIColor whiteColor];
    SaleLbel.layer.cornerRadius = 20;
    SaleLbel.layer.masksToBounds = YES;
    [saleView addSubview:SaleLbel];
    [SaleLbel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(saleView.mas_centerX);
        make.centerY.mas_equalTo(saleView.mas_centerY);
        make.width.mas_equalTo(SCREEN_WIDTH - 40);
        make.height.mas_equalTo(40);
    }];
    
    UITapGestureRecognizer *SaleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(JiFenBtnClick
                                                                                                          )];
    [SaleLbel addGestureRecognizer:SaleTap];

    self.tableView.noContentViewTapedBlock = ^{
        [self getNetworkData:YES];
    };

    
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

-(void)getNetworkData:(BOOL)isRefresh
{
    if (isRefresh) {
        page = 1;
        isFirstCome = YES;
    }else{
        page++;
    }
    //1. 网贷基金，2. 特色产品，3. 企业贷款、4. 个人贷款，5. 购车贷款、6. 债权转让，7. 新手专享，8. 金米宝， 0. 定期（包含1 3 4 5 6 7）
    NSString *tokenID = NSuserUse(@"Authorization");
    NSString *userID = NSuserUse(@"userId");

    NSString *url;
    if (isRefresh) {
        url = [NSString stringWithFormat:@"%@/users/%@/pointLogs?page=1&rows=20",HOST_URL,userID];
    }else{
        url = [NSString stringWithFormat:@"%@/users/%@/pointLogs?page=%d&rows=20",HOST_URL,userID,page];
        
    }
    if (page ==1) {
        [MyArray removeAllObjects];
    }
    [[DateSource sharedInstance]requestHtml5WithParameters:nil  withUrl:url withTokenStr:tokenID  usingBlock:^(NSDictionary *result, NSError *error) {
      //  NSLog(@"left result = %@",result);
        for (NSDictionary *dic in [result objectForKey:@"items"]) {
            JiFenModel *model = [[JiFenModel alloc]init];
            model.dataDictionary = dic;
            [MyArray addObject:model];
        }
        if (MyArray.count) {
            [self.tableView reloadData];
            [self endRefresh];
        }else{
            [self.tableView showEmptyViewWithType:NoContentTypeNetwork];
 
        }
       
        // UserDic = [result objectForKey:@"data"];
        // [self reloadData];
    }];
}

- (void)JiFenBtnClick{
    
}
- (void)zj_viewDidLoadForIndex:(NSInteger)index {
    
    self.tableView = [[MyTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
   // [self.tableView setTableFooterView:[UIView new]];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadoneNew)];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadoneMore)];

    [self.view addSubview:self.tableView];
}
- (void)zj_viewDidAppearForIndex:(NSInteger)index {
//    self.index = index;
//    NSLog(@"已经出现   标题: --- %@  index: -- %ld", self.title, index);
//    
//    if (index%2==0) {
//        self.view.backgroundColor = [UIColor blueColor];
//    } else {
//        self.view.backgroundColor = [UIColor greenColor];
//        
//    }
//    // 加载数据
//    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//    self.data = @[@"sfa",@"sfa",@"sfa",@"sfa",@"sfa",@"sfa",@"sfa",@"sfa",@"sfa",@"sfa",@"sfa",@"sfa",@"sfa",@"sfa",@"sfa",@"sfa",@"sfa",@"sfa"];
    [self getNetworkData:YES];
    [self.tableView reloadData];
    //    });
}
#pragma mark- ZJScrollPageViewChildVcDelegate



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return MyArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"JifenJilvTotalidentifier";
    
    JiFenRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[JiFenRecordTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        [cell configUI:indexPath];
    }
    if ([MyArray count]) {
        JiFenModel *model = [MyArray objectAtIndex:indexPath.row];
        cell.JiFenModel = model;
    }
    return cell;
}
//cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 64;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"点击了%ld行----", indexPath.row);
}

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    
//    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
//}
//
//- (void)viewWillDisappear:(BOOL)animated {
//    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
//    
//    [super viewWillDisappear:animated];
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
