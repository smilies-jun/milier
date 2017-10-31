//
//  UnYetDetailViewController.m
//  milier
//
//  Created by amin on 2017/8/2.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "UnYetDetailViewController.h"
#import "UnYetMoneyViewController.h"
#import "UnYetDetailTopTableViewCell.h"
#import "UnYetDetailTableViewCell.h"
#import "MoneyModel.h"
#import "YetDetailModel.h"

@interface UnYetDetailViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *YetListArray;
    NSMutableArray *YetDetailArray;
}
@property (nonatomic,strong)UITableView *tableView;

@end

@implementation UnYetDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"投资明细";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(0, 7, 18, 18);
    [leftBtn setImage:[UIImage imageNamed:@"backarrow"] forState:UIControlStateNormal];
    
    [leftBtn addTarget:self action:@selector(UnYetDetailClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    YetDetailArray = [[NSMutableArray alloc]init];
    YetListArray = [[NSMutableArray alloc]init];
    [self getNetworkData:YES];
    [self ConfigUI];
}
-(void)getNetworkData:(BOOL)isRefresh
{
    NSString *url;
    NSString *tokenID = NSuserUse(@"Authorization");
    NSString *userID = NSuserUse(@"userId");
    
    url = [NSString stringWithFormat:@"%@/productOrderRepayments/%@/details",HOST_URL,_ProDateId];
    [[DateSource sharedInstance]requestHtml5WithParameters:nil  withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {

        if ([[result objectForKey:@"statusCode"]integerValue] == 200) {
            MoneyModel *model = [[MoneyModel alloc]init];
            model.dataDictionary = [result objectForKey:@"items"];
            [YetListArray addObject:model];
        }
        [_tableView reloadData];
    }];
//
    NSString *Bottomurl;
    if (isRefresh) {
        page = 1;
        isFirstCome = YES;
    }else{
        page++;
    }

    Bottomurl = [NSString stringWithFormat:@"%@/productOrderRepayments/%@/detailsSub?page=%d&rows=20&userId=%@",HOST_URL,_ProDateId,page,userID];
    if (page == 1) {
        [YetDetailArray removeAllObjects];
    }
    [[DateSource sharedInstance]requestHtml5WithParameters:nil  withUrl:Bottomurl withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
        NSLog(@"re  == %@",result);
        if ([[result objectForKey:@"items"] count]) {
            
            for (NSDictionary *dic in [result objectForKey:@"items"]) {
                YetDetailModel *model = [[YetDetailModel alloc]init];
                model.dataDictionary = dic;
                [YetDetailArray addObject:model];
            }
            
        }
        
        [_tableView reloadData];
    }];
    
    
}

-(void)ConfigUI{
    _tableView = [[MyTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = colorWithRGB(0.93, 0.93, 0.93);
    //_tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadoneNew)];
    //_tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadoneMore)];
    [self.view addSubview:_tableView];
    
    
}
//设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [YetDetailArray count] +1;
}


//组头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
//cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 100;
    }
    return 80;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        static NSString *identifier = @"YetListlProidentifier";
        
        UnYetDetailTopTableViewCell   *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[UnYetDetailTopTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            [cell configUI:indexPath];
        }
        cell.RowImageView.hidden = YES;
        if (YetListArray.count) {
            MoneyModel *model = [YetListArray objectAtIndex:0];
            cell.LostModel = model;
        }
       
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        return cell;
    }else{
        static NSString *identifier = @"YetListDetailProidentifier";
        
        UnYetDetailTableViewCell   *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[UnYetDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            [cell configUI:indexPath];
        }
        if (YetDetailArray.count) {
            YetDetailModel *model = [YetDetailArray objectAtIndex:indexPath.row - 1];
            cell.DetailModel = model;
        }
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        return cell;
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

- (void)UnYetDetailClick{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[UnYetMoneyViewController   class]]) {
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
