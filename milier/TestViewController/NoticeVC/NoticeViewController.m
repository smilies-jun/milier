//
//  NoticeViewController.m
//  milier
//
//  Created by amin on 2018/3/29.
//  Copyright © 2018年 yj. All rights reserved.
//

#import "NoticeViewController.h"
#import "NoticeTableViewCell.h"
#import "NoticeModel.h"
#import "MoreMoreHelpViewController.h"

@interface NoticeViewController (){
    NSMutableArray *DataArray;
    MBProgressHUD *hud;
    
}

@end

@implementation NoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    DataArray = [[NSMutableArray alloc]init];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadoneNew)];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadoneMore)];
    
    page =1;
    DataArray = [[NSMutableArray alloc]init];
    self.tableView.backgroundColor = colorWithRGB(0.97, 0.97, 0.97);
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
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
- (void)HideProgress{
     [hud hideAnimated:YES afterDelay:1.0];
}
- (void)showProgress{
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = NSLocalizedString(@"正在请求中", @"HUD loading title");
}

-(void)getNetworkData:(BOOL)isRefresh
{
    if (isRefresh) {
        page = 1;
        isFirstCome = YES;
    }else{
        page++;
    }
    if (page ==1) {
        [DataArray removeAllObjects];
    }
    [self showProgress];
    //1. 网贷基金，2. 特色产品，3. 企业贷款、4. 个人贷款，5. 购车贷款、6. 债权转让，7. 新手专享，8. 金米宝， 0. 定期（包含1 3 4 5 6 7）
    NSString *url;
    if (isRefresh) {
        url = [NSString stringWithFormat:@"%@/notices?page=1&rows=10&categoryId=3",HOST_URL];
    }else{
        url = [NSString stringWithFormat:@"%@/notices?page=%d&rows=10&categoryId=3",HOST_URL,page];
        
    }
    [self HideProgress];
    [[DateSource sharedInstance]requestHtml5WithParameters:nil  withUrl:url withTokenStr:nil  usingBlock:^(NSDictionary *result, NSError *error) {
        if (page ==1) {
            [DataArray removeAllObjects];
        }
        for (NSDictionary *dic in [result objectForKey:@"items"]) {
            NoticeModel *model = [[NoticeModel alloc]init];
            model.dataDictionary = dic;
            [DataArray addObject:model];
        }
         [self HideProgress];
        if (DataArray.count) {
            [self endRefresh];
            
            [self.tableView reloadData];
            
        }
       
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
    
    if (DataArray.count) {
        return [DataArray count];
    }
    return 1;
}
//cell-height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (DataArray.count) {
        return 60;
    }
    return SCREEN_HEIGHT-64-40;
    
}

//cell-tableview
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (DataArray.count) {

            static NSString *identifier = @"noticeStageidentifier";                           
            NoticeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell) {
                cell = [[NoticeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                [cell configUI:indexPath];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            if ([DataArray count]) {
               NoticeModel *model = [DataArray objectAtIndex:indexPath.row];
              cell.noticelModel = model;
            }
        
            
            return cell;
            
        
        
        
    }else{
        static NSString *identifier = @"noticeNodetailidentifier";
        
        NoDateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[NoDateTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            [cell configUI:indexPath];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        return cell;
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NoticeModel *model = [DataArray objectAtIndex:indexPath.row];
        MoreMoreHelpViewController *vc= [[MoreMoreHelpViewController alloc]init];
        vc.TitleStr =[NSString stringWithFormat:@"%@",model.title];
        vc.WebStr = [NSString stringWithFormat:@"%@/%@",HOST_URL,model.url];
        [self.navigationController pushViewController:vc animated:NO];
}
- (void)QiYeClick{
    

    
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
