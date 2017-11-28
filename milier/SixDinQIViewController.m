//
//  SixDinQIViewController.m
//  milier
//
//  Created by amin on 2017/11/22.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "SixDinQIViewController.h"
#import "ProductDetailNewViewController.h"
#import "YNPageScrollViewController.h"
#import "SecondTableViewCell.h"
#import "ProuctModel.h"
#import "UserViewController.h"
#import "DinQiTopTableViewCell.h"
#import "DinQiListTableViewCell.h"
#import "OldProfitViewController.h"
#import "AddProfitViewController.h"
#import "MyNewDinQiDetailViewController.h"
#import "DinQiTopModel.h"
#import "DinQiModel.h"
#import "SecondTableViewCell.h"
#import "ProuctModel.h"
@interface SixDinQIViewController (){
    NSMutableArray *dataArray;
    NSString *state;
    NSString *increase_type;
    NSString *percent;
}

@end

@implementation SixDinQIViewController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    dataArray = [[NSMutableArray alloc]init];
    self.tableView.backgroundColor = colorWithRGB(0.93, 0.93, 0.93);
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadoneNew)];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadoneMore)];
    
  //  [self getNetworkData:YES];
    
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getNetworkData:YES];
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
        [dataArray removeAllObjects];
    }
    
    NSString *url;
    
    if (isRefresh) {
        url = [NSString stringWithFormat:@"%@?page=1&rows=20&userId=%@&productCategoryId=0&state=9",PRODUCTO_RDERS_URL,userID];
        
    }else{
        url = [NSString stringWithFormat:@"%@?page=%d&rows=20&userId=%@&productCategoryId=0&state=9",PRODUCTO_RDERS_URL,page,userID];
        
    }
    
    [[DateSource sharedInstance]requestHtml5WithParameters:nil  withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
        
        NSArray *myArray = [result objectForKey:@"items"];
        for (NSDictionary *JinMidic in myArray) {
            
            DinQiModel *model = [[DinQiModel alloc]init];
            model.dataDictionary = JinMidic;
            [dataArray addObject:model];
        }
        [self endRefresh];
        [self.tableView reloadData];
        
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
- (void)endRefresh{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    
}

//rows-section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (dataArray.count) {
        return dataArray.count;
    }
    return 1;
}
//cell-height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (dataArray.count) {
        return 140;
    }
    return 320;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     if (dataArray.count) {
    static NSString *identifier = @"DinQiListProidentifier";
    
    DinQiListTableViewCell   *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[DinQiListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell configUI:indexPath];
    }
    if (dataArray.count) {
        DinQiModel *model = [dataArray objectAtIndex:indexPath.row];
        cell.DinqiModel = model;
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
    
}else{
    static NSString *identifier = @"Nodateidentifier";
    
    NoDateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[NoDateTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell configUI:indexPath];
    }
    //cell.textLabel.text = @"11111111";
    return cell;
}
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (dataArray.count) {
        MyNewDinQiDetailViewController *sVC = [[MyNewDinQiDetailViewController alloc] init];
        DinQiModel *model = [dataArray objectAtIndex:indexPath.row];
        sVC.oid = model.oid;
        sVC.Type = model.transferable;
        sVC.State = model.state;
        [self.navigationController pushViewController:sVC animated:NO];
    }
    
    
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
