//
//  AleardyBoundViewController.m
//  milier
//
//  Created by amin on 17/4/26.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "AleardyBoundViewController.h"
#import "NoDateTableViewCell.h"
#import "AleardyBundTableViewCell.h"
#import "ShareModel.h"


@interface AleardyBoundViewController (){
    NSMutableArray *dataArray;
}

@end

@implementation AleardyBoundViewController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    dataArray = [[NSMutableArray alloc]init];

    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadoneNew)];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadoneMore)];
    self.tableView.backgroundColor = colorWithRGB(1, 0.94, 0.72);
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-60);

    [self getNetworkData:YES];
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
        url = [NSString stringWithFormat:@"%@/users/%@/customers?page=1&rows=20&bankCardExist=1",HOST_URL,userID];
    }else{
        url = [NSString stringWithFormat:@"%@/users/%@/customers?page=%d&rows=20&bankCardExist=1",HOST_URL,userID,page];
        
    }
    if (page ==1) {
        [dataArray removeAllObjects];
    }
    
    [[DateSource sharedInstance]requestHtml5WithParameters:nil  withUrl:url withTokenStr:tokenID  usingBlock:^(NSDictionary *result, NSError *error) {
        for (NSDictionary *dic in [result objectForKey:@"items"]) {
            
            ShareModel *model = [[ShareModel alloc]init];
            model.dataDictionary = dic;
            [dataArray addObject:model];
        }
            [self.tableView reloadData];
                [self endRefresh];
        if ([[result objectForKey:@"items"]count]==0) {
            [self reset];
        }
        // UserDic = [result objectForKey:@"data"];
        // [self reloadData];
    }];
}
- (void)reset{
    [self.tableView reloadData];
    
    // 拿到当前的上拉刷新控件，变为没有更多数据的状态
    [self.tableView.mj_footer endRefreshingWithNoMoreData];
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
    if (dataArray.count) {
        return [dataArray count];
  
    }else{
        return 1;
  
    }
}
//cell-height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (dataArray.count) {
        return 60;
    }
    return SCREEN_HEIGHT-64-60;
}

//cell-tableview
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (dataArray.count) {
        static NSString *identifier = @"productidentifier";
        
        AleardyBundTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[AleardyBundTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
            [cell configUI:indexPath];
            cell.backgroundColor = colorWithRGB(1, 0.89, 0.53);
            
        }
        if (dataArray.count) {
            ShareModel *model = [dataArray objectAtIndex:indexPath.row];
            cell.ShareModel = model;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
 
    }else{
        static NSString *identifier = @"NodatBundproductidentifier";
        
        NoDateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[NoDateTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
            [cell configUI:indexPath];
            cell.backgroundColor = colorWithRGB(1, 0.94, 0.72);
            cell.ImageView.image = [UIImage imageNamed:@"nodatas@2x"];
            [cell.ImageView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(57);
                make.height.mas_equalTo(51);
            }];
           // cell.backgroundColor = colorWithRGB(0.93, 0.93, 0.93);
            
        }
        
        //  cell.ImageView.image = [UIImage imageNamed:@"nodatas@2x"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;

    }
    
}




@end
