//
//  BoundViewController.m
//  milier
//
//  Created by amin on 17/4/26.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "BoundViewController.h"
#import "BoundTableViewCell.h"
#import "ShareModel.h"


@interface BoundViewController (){
    NSMutableArray *dataArray;
}



@end

@implementation BoundViewController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    dataArray = [[NSMutableArray alloc]init];
    self.tableView.backgroundColor = colorWithRGB(1, 0.94, 0.72);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadoneNew)];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadoneMore)];
    self.tableView.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64-60);

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
        url = [NSString stringWithFormat:@"%@/users/%@/customers?page=1&rows=20&bankCardExist=0",HOST_URL,userID];
    }else{
        url = [NSString stringWithFormat:@"%@/users/%@/customers?page=%d&rows=20&bankCardExist=0",HOST_URL,userID,page];
        
    }
    if (page==1) {
        [dataArray removeAllObjects];
    }
    NSLog(@"url =%@",url);
    [[DateSource sharedInstance]requestHtml5WithParameters:nil  withUrl:url withTokenStr:tokenID  usingBlock:^(NSDictionary *result, NSError *error) {
        NSLog(@"re = %@",result);
        for (NSDictionary *dic in [result objectForKey:@"items"]) {
            
            ShareModel *model = [[ShareModel alloc]init];
            model.dataDictionary = dic;
            [dataArray addObject:model];
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
    if (dataArray.count) {
        return [dataArray count];
 
    }else{
        return 1;
 
    }
}
//cell-height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (dataArray.count) {
         return 80;
    }
    return SCREEN_HEIGHT-64-44;
}

//cell-tableview
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (dataArray.count) {
        static NSString *identifier = @"productidentifier";
        
        BoundTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[BoundTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
            [cell configUI:indexPath];
            cell.backgroundColor = colorWithRGB(1, 0.89, 0.53);
            
        }
        if (dataArray.count) {
            ShareModel *model = [dataArray objectAtIndex:indexPath.row];
            cell.ShareModel = model;
        }
        [cell.AlertBtn addTarget:self action:@selector(AlertClick:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else{
        static NSString *identifier = @"Nodataproductidentifier";
        
        NoDateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[NoDateTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
            [cell configUI:indexPath];
            cell.backgroundColor = colorWithRGB(1, 0.94, 0.72);
            cell.ImageView.image = [UIImage imageNamed:@"nodatas@2x"];

        }

        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
    
}

- (void)AlertClick:(UIButton *)btn{
    ShareModel *model = [dataArray objectAtIndex:btn.tag - 100];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提醒好友绑卡"
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleActionSheet];
    //取消:style:UIAlertActionStyleCancel
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    //了解更多:style:UIAlertActionStyleDestructive
    UIAlertAction *moreAction = [UIAlertAction actionWithTitle:@"电话" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self sendPhone:model.phoneNumber];
    }];
    [alertController addAction:moreAction];
    //原来如此:style:UIAlertActionStyleDefault
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"短信" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self sendMessage:model.phoneNumber];
    }];
    [alertController addAction:OKAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)sendPhone:(NSString *)phoneStr{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phoneStr]]];
    

}

- (void)sendMessage:(NSString *)MessageStr{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"sms://%@",MessageStr]]];

}
@end
