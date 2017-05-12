//
//  YNTestOneViewController.m
//  YNPageScrollViewController
//
//  Created by ZYN on 16/7/19.
//  Copyright © 2016年 Yongneng Zheng. All rights reserved.
//

#import "YNTestOneViewController.h"
#import "ProductDetailNewViewController.h"

#import "SecondTableViewCell.h"
#import "ProuctModel.h"

@interface YNTestOneViewController (){
    NSMutableArray *dataArray;
}
@end

@implementation YNTestOneViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self.tableView setSeparatorColor:colorWithRGB(0.87, 0.87, 0.87)];
    dataArray = [[NSMutableArray alloc]init];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadoneNew)];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadoneMore)];
    [self getNetworkData:YES];
}
- (void)loadoneNew{
    [self getNetworkData:YES];
    
}
- (void)loadoneMore{
    NSLog(@"more");
    [self getNetworkData:NO];
    
}

-(void)getNetworkData:(BOOL)isRefresh
{
    if (isRefresh) {
        page = 0;
        isFirstCome = YES;
    }else{
        page++;
    }
    
    NSString *url;
    if (isFirstCome) {
        url = [NSString stringWithFormat:@"%@?page=1&rows=20&productCategoryId=1",PRODUCTS_URL];
    }else{
        url = [NSString stringWithFormat:@"%@?page=%d&rows=20&productCategoryId=1",PRODUCTS_URL,page];
        
    }
    [[DateSource sharedInstance]requestHtml5WithParameters:nil  withUrl:url usingBlock:^(NSDictionary *result, NSError *error) {
        isJuhua = NO;
        [self endRefresh];
        if (page == 0) {
            [dataArray removeAllObjects];
        }
//        if (isJuhua) {
//            [self endRefresh];
//        }
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
    
    
    return 5;
    
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
    return 4;
}
//rows-section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [dataArray count];
}
//cell-height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 120;
}


//cell-tableview
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"identifier";
    
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
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ProductDetailNewViewController *vc = [[ProductDetailNewViewController alloc]init];
    ProuctModel *model = [dataArray objectAtIndex:indexPath.row];
    vc.productID = [model.productId intValue];
    [self.navigationController pushViewController:vc animated:NO];
}


@end
