//
//  BuyCarViewController.m
//  milier
//
//  Created by amin on 17/4/25.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "BuyCarViewController.h"
#import "StageTableViewCell.h"
#import "StageTotalTableViewCell.h"
#import "StageModel.h"


@interface BuyCarViewController (){
    NSMutableArray *DataArray;
}


@end

@implementation BuyCarViewController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    DataArray = [[NSMutableArray alloc]init];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadoneNew)];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadoneMore)];

    [self getNetworkData:YES];

    self.tableView.backgroundColor = colorWithRGB(0.97, 0.97, 0.97);
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];

    
    
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
    NSString *url;
    if (isFirstCome) {
        url = [NSString stringWithFormat:@"%@/props?page=1&rows=20&productCategoryId=3&receiveState=1",HOST_URL];
    }else{
        url = [NSString stringWithFormat:@"%@/props?page=%d&rows=20&productCategoryId=3&receiveState=1",HOST_URL,page];
        
    }
    
    [[DateSource sharedInstance]requestHtml5WithParameters:nil  withUrl:url withTokenStr:tokenID  usingBlock:^(NSDictionary *result, NSError *error) {
        for (NSDictionary *dic in [result objectForKey:@"items"]) {
            StageModel *model = [[StageModel alloc]init];
            model.dataDictionary = dic;
            [DataArray addObject:model];
        }
        [self.tableView reloadData];
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
    
    return [DataArray count];
}
//cell-height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return 25;
    }
    return 150;

}

//cell-tableview
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        static NSString *identifier = @"StageTotalidentifier";
        
        StageTotalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[StageTotalTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
            [cell configUI:indexPath];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell;
        
    }else{
        static NSString *identifier = @"Stageidentifier";
        
        StageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[StageTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
            [cell configUI:indexPath];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        if ([DataArray count]) {
            StageModel *model = [DataArray objectAtIndex:indexPath.row -1];
            cell.stageModel = model;
        }
        if ([cell.stageModel.state integerValue] == 2) {
            cell.RightImageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *qiyeTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(QiYeClick)];
            [cell.RightImageView addGestureRecognizer:qiyeTap];
            
        }
        cell.RightImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *qiyeTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(QiYeClick)];
        [cell.RightImageView addGestureRecognizer:qiyeTap];
        return cell;
        
    }

    
}

- (void)QiYeClick{
    
    NSuserSave(@"3", @"qiye");
    
    [self.navigationController popToRootViewControllerAnimated:NO];
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
