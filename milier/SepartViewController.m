//
//  SepartViewController.m
//  milier
//
//  Created by amin on 2017/5/18.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "SepartViewController.h"
#import "AleardyBundTableViewCell.h"
#import "SepartTableViewCell.h"
#import "SepartModel.h"


@interface SepartViewController (){
    NSMutableArray *separtArray;
}

@end

@implementation SepartViewController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    separtArray  = [[NSMutableArray alloc]init];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadoconNew)];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadconMore)];
    [self getNetworkData:YES];
    
}
- (void)loadoconNew{
    [self getNetworkData:YES];
    
}
- (void)loadconMore{
    [self getNetworkData:NO];
    
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
    NSString *userID = NSuserUse(@"userId");
    NSString *tokenID = NSuserUse(@"Authorization");
    
    NSString *url;
    if (isFirstCome) {
        url = [NSString stringWithFormat:@"%@/brokers/%@/earningLogs?page=1&rows=20",HOST_URL,userID];
    }else{
        url = [NSString stringWithFormat:@"%@/brokers/%@/earningLogs?page=%d&rows=20",HOST_URL,userID,page];
        
    }
    
    [[DateSource sharedInstance]requestHtml5WithParameters:nil  withUrl:url withTokenStr:tokenID  usingBlock:^(NSDictionary *result, NSError *error) {
         NSLog(@"left result = %@",result);
        for (NSDictionary *dic in [result objectForKey:@"items"]) {
            SepartModel *model = [[SepartModel alloc]init];
            model.dataDictionary = dic;
            [separtArray addObject:model];
        }
        [self.tableView reloadData];
        [self endRefresh];
        // UserDic = [result objectForKey:@"data"];
        // [self reloadData];
    }];
}

#pragma mark - UITableViewDelegate  UITableViewDataSource

//header-height
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    return 0;
    
}
//header-secion
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return [UIView new];
}

//footer-hegiht
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

//footer-section
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [UIView new];
}


//sections-tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
//rows-section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return separtArray.count + 1;
}
//cell-height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40;
}

//cell-tableview
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"productidentifier";
    
    SepartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[SepartTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        [cell configUI:indexPath];
        
    }
    if (indexPath.row == 0) {
        cell.TitleLabel.text = @"时间";
        cell.TimeLabel.text = @"我的分成";
        cell.TypeLabel.text = @"下家存量金额";
    }else{
        if (separtArray.count) {
            SepartModel *model = [separtArray objectAtIndex:indexPath.row-1];
            cell.SepartModel = model;
        }
        
    }
    
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
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
