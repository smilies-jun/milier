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
#import "DetailTypeTableViewCell.h"

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
    self.tableView.backgroundColor = colorWithRGB(0.93, 0.93, 0.93);
    page =1;
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
    NSString *userID = NSuserUse(@"userId");
    NSString *tokenID = NSuserUse(@"Authorization");
    
    NSString *url;
    if (isRefresh) {
        url = [NSString stringWithFormat:@"%@/brokers/%@/earningLogs?page=1&rows=20",HOST_URL,userID];
    }else{
        url = [NSString stringWithFormat:@"%@/brokers/%@/earningLogs?page=%d&rows=20",HOST_URL,userID,page];
        
    }
    if (page == 1) {
        [separtArray removeAllObjects];
    }
    [[DateSource sharedInstance]requestHtml5WithParameters:nil  withUrl:url withTokenStr:tokenID  usingBlock:^(NSDictionary *result, NSError *error) {
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
    if (separtArray.count) {
        return separtArray.count + 1;
  
    }
    return 1;
}
//cell-height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (separtArray.count) {
        return 44;
  
    }
    return 344;
}

//cell-tableview
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (separtArray.count) {
        if (indexPath.row == 0) {
            static NSString *identifier = @"productTypeidentifier";
            
            DetailTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell) {
                cell = [[DetailTypeTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
                [cell configUI:indexPath];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
            
        }else{
            static NSString *identifier = @"productidentifier";
            
            SepartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell) {
                cell = [[SepartTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
                [cell configUI:indexPath];
                
            }
            
            if (separtArray.count) {
                SepartModel *model = [separtArray objectAtIndex:indexPath.row - 1];
                cell.SepartModel = model;
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
            
        }
 
    }else{
        static NSString *identifier = @"SepDaentifier";
        
        NoDateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[NoDateTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
            [cell configUI:indexPath];
            
        }
        
               cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
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
