//
//  AddProfitViewController.m
//  milier
//
//  Created by amin on 17/4/24.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "AddProfitViewController.h"
#import "DinQiDeatilViewController.h"
#import "AddaProfileTableViewCell.h"
#import "MJRefresh.h"
#import "JinMiDetdailViewController.h"
#import "ProfileModel.h"
#import "AddOneDayViewController.h"
#import "UIView+frameAdjust.h"
#import "MyNewDinQiDetailViewController.h"
@interface AddProfitViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *AddArray;
}
@property (nonatomic,strong)MyTableView *tableView;


@end

@implementation AddProfitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"累计收益";
    self.view.backgroundColor = [UIColor grayColor];
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(0, 7, 18, 18);
    [leftBtn setImage:[UIImage imageNamed:@"backarrow.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(AddProfitClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    AddArray = [[NSMutableArray alloc]init];
   
    [self getNetworkData:YES];
    [self ConfigUI];
    [self loadoneNew];


}
-(void)ConfigUI{
    page = 1;
    isFirstCome = YES;
    isJuhua = NO;
    _tableView = [[MyTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadoneNew)];
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadoneMore)];
    [self.view addSubview:_tableView];
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
    NSString *url;
    if (isRefresh) {
        page = 1;
        isFirstCome = YES;
    }else{
        page++;
    }
    NSString *userID = NSuserUse(@"userId");
    NSString *tokenID = NSuserUse(@"Authorization");
    if (_ProductType == 1) {
        //活期
        if (isRefresh) {
            url = [NSString stringWithFormat:@"%@/earnings?page=1&rows=20&userId=%@&productCategoryId=8",HOST_URL,userID];
 
        }else{
            url = [NSString stringWithFormat:@"%@/earnings?page=%d&rows=20&userId=%@&productCategoryId=8",HOST_URL,page,userID];
  
        }
    }else{
         // 定期
        if (isRefresh) {
            url = [NSString stringWithFormat:@"%@/earnings?page=1&rows=20&userId=%@&productCategoryId=0",HOST_URL,userID];
            
        }else{
            url = [NSString stringWithFormat:@"%@/earnings?page=%d&rows=20&userId=%@&productCategoryId=0",HOST_URL,page,userID];
            
        }
        
    }
    [[DateSource sharedInstance]requestHtml5WithParameters:nil  withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
        NSArray *myArray = [result objectForKey:@"items"];
        isJuhua = NO;
        [self endRefresh];
        if (page == 1) {
            [AddArray removeAllObjects];
        }
                if (isJuhua) {
                    [self endRefresh];
                }

        if (myArray.count) {
            for (NSDictionary *NewDic in myArray) {
                ProfileModel *model = [[ProfileModel alloc]init];
                model.dataDictionary = NewDic;
                [AddArray addObject:model];
            }
            [self endRefresh];
            [self.tableView reloadData];
            isFirstCome = NO;
        }
        
    }];
    


}
//设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (AddArray.count) {
        return  [AddArray count];
 
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
    return SCREEN_HEIGHT-64;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (AddArray.count) {
        static NSString *identifier = @"Addidentifier";
        
        AddaProfileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[AddaProfileTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            [cell configUI:indexPath];
        }
        
        if (AddArray.count) {
            ProfileModel *model = [AddArray objectAtIndex:indexPath.row];
            cell.ProfileModel = model;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        return cell;
    }else{
        static NSString *identifier = @"NodateAddidentifier";
        
        NoDateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[NoDateTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            [cell configUI:indexPath];
        }
        
              cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        return cell;
    }
   
}
- (NSString *)getTimeStr:(NSString *)MyTimeStr withForMat:(NSString *)formatStr{
    NSTimeInterval interval=[MyTimeStr doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:formatStr];
    NSString * timeStr = [NSString stringWithFormat:@"%@",[objDateformat stringFromDate: date]];
    return timeStr;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (AddArray.count) {
        AddOneDayViewController *VC = [[AddOneDayViewController alloc]init];
        ProfileModel *model = [AddArray objectAtIndex:indexPath.row];
        NSString *timeStr = [self getTimeStr:model.createTime withForMat:@"yyyy-MM-dd"];
        VC.OidStr = [NSString stringWithFormat:@"%@",timeStr];

        VC.TitleStr = [NSString stringWithFormat:@"%@收益(元)",timeStr];
        [self.navigationController pushViewController:VC animated:NO];
    }
    //    SectionViewController *sVC = [[SectionViewController alloc] init];
    //    sVC.rowLabelText = [NSString stringWithFormat:@"第%ld组的第%ld个cell",(long)indexPath.section,(long)indexPath.row];
    //    [self presentViewController:sVC animated:YES completion:nil];
   
    
    
}

- (void)AddProfitClick{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[MyNewDinQiDetailViewController     class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[JinMiDetdailViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 马上进入刷新状态
    //[self.tableView.mj_header beginRefreshing];
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
