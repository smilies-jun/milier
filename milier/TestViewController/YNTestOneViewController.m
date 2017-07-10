//
//  YNTestOneViewController.m
//  YNPageScrollViewController
//
//  Created by ZYN on 16/7/19.
//  Copyright © 2016年 Yongneng Zheng. All rights reserved.
//

#import "YNTestOneViewController.h"
#import "ProductDetailNewViewController.h"
#import "YNPageScrollViewController.h"

#import "SecondTableViewCell.h"
#import "ProuctModel.h"

@interface YNTestOneViewController (){
    NSMutableArray *dataArray;
    int type;
}
@end

@implementation YNTestOneViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self.tableView setSeparatorColor:colorWithRGB(0.87, 0.87, 0.87)];
    dataArray = [[NSMutableArray alloc]init];
    self.tableView.backgroundColor = colorWithRGB(0.93, 0.93, 0.93);
    type = 0;
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT -64-49);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadoneNew)];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadoneMore)];
    [self getNetworkData:YES];

    NSString *wifeStr = NSuserUse(@"Net");
    switch ([wifeStr integerValue]) {
        case 0:
            type = 1;
            [self.tableView reloadData];
            break;
        default:
            type = 0;
            
            break;
    }
    //   __weak typeof (YNTestBaseViewController *)weakself = self;
    
    NSLog(@"wife = %@",wifeStr);
     NSuserSave(@"2", @"qiye");
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSuserSave(@"2", @"qiye");
    
    
}
- (void)loadoneNew{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeWife" object:nil userInfo:nil];

    [self getNetworkData:YES];

}
- (void)loadoneMore{
    [self getNetworkData:NO];
    
}

-(void)getNetworkData:(BOOL)isRefresh
{
    if (isRefresh) {
        page = 1;
        isFirstCome = YES;
    }else{
        page++;
    }
    
    NSString *url;
    if (isRefresh) {
        url = [NSString stringWithFormat:@"%@?page=1&rows=20&productCategoryId=1",PRODUCTS_URL];
    }else{
        url = [NSString stringWithFormat:@"%@?page=%d&rows=20&productCategoryId=1",PRODUCTS_URL,page];
        
    }
    
    [[DateSource sharedInstance]requestHtml5WithParameters:nil  withUrl:url withTokenStr:@"" usingBlock:^(NSDictionary *result, NSError *error) {
        isJuhua = NO;
        [self endRefresh];
        NSLog(@"re == %@",result);
        if (page == 1) {
            [dataArray removeAllObjects];
        }
        if (isJuhua) {
            [self endRefresh];
        }

        NSArray *myArray = [result objectForKey:@"items"];
        for (NSDictionary *NewDic in myArray) {
            ProuctModel *model = [[ProuctModel alloc]init];
            model.dataDictionary = NewDic;
            [dataArray addObject:model];
        }
        [self.tableView reloadData];
        isFirstCome = NO;
    }];
    
}
- (void)endRefresh{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    
}

#pragma mark - UITableViewDelegate  UITableViewDataSource

//header-height
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    return 2;
    
}
//header-secion
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return [UIView new];
}

//footer-hegiht
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001;
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
    NSLog(@"a = %lu",(unsigned long)dataArray.count);
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
    return 300;
}


//cell-tableview
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (dataArray.count) {
        static NSString *identifier = @"oneidentifier";
        SecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[SecondTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            [cell configUI:indexPath];
        }
        if (dataArray.count) {
            ProuctModel *model  = [dataArray objectAtIndex:indexPath.row];
            cell.productMoel = model;
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //cell.textLabel.text = @"11111111";
        return cell;
 
    }else{

        static NSString *identifier = @"NoWifeidentifier";
        NoDateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[NoDateTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            [cell configUI:indexPath];
            
        }
       
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //cell.textLabel.text = @"11111111";
        return cell;
 
    }
}
#pragma mark  - 滑到最底部
- (void)scrollTableToFoot:(BOOL)animated
{
    NSInteger s = [self.tableView numberOfSections];  //有多少组
    if (s<1) return;  //无数据时不执行 要不会crash
    NSInteger r = [self.tableView numberOfRowsInSection:s-1]; //最后一组有多少行
    if (r<1) return;
    NSIndexPath *ip = [NSIndexPath indexPathForRow:r-1 inSection:s-1];  //取最后一行数据
    [self.tableView scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionBottom animated:animated]; //滚动到最后一行
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (dataArray.count) {
        ProductDetailNewViewController *vc = [[ProductDetailNewViewController alloc]init];
        ProuctModel *model = [dataArray objectAtIndex:indexPath.row];
        vc.productID = [model.oid intValue];
        vc.productCateID = 1;
        vc.State = model.state;
        [self.navigationController pushViewController:vc animated:NO];
    }
   
}


@end
