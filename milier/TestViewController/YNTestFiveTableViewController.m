//
//  YNTestFiveTableViewController.m
//  milier
//
//  Created by amin on 17/5/2.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "YNTestFiveTableViewController.h"
#import "SecondTableViewCell.h"
#import "ProductDetailNewViewController.h"
#import "ProuctModel.h"
#import "DeveloperTableViewCell.h"

@interface YNTestFiveTableViewController (){
    NSMutableArray *dataArray;
}


@end

@implementation YNTestFiveTableViewController


- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    NSLog(@"two - viewDidLoad");
    dataArray = [[NSMutableArray alloc]init];
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 150-100);
    self.tableView.backgroundColor = colorWithRGB(0.93, 0.93, 0.93);
    NSuserSave(@"3", @"qiye");
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadoneNew)];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadoneMore)];
    [self getNetworkData:YES];
 
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSuserSave(@"3", @"qiye");
    
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
        page = 1;
        isFirstCome = YES;
    }else{
        page++;
    }
    
    NSString *url;
    if (isRefresh) {
        url = [NSString stringWithFormat:@"%@?page=1&rows=20&productCategoryId=5",PRODUCTS_URL];
    }else{
        url = [NSString stringWithFormat:@"%@?page=%d&rows=20&productCategoryId=5",PRODUCTS_URL,page];
        
    }
    [[DateSource sharedInstance]requestHtml5WithParameters:nil  withUrl:url withTokenStr:@"" usingBlock:^(NSDictionary *result, NSError *error) {
        isJuhua = NO;
        [self endRefresh];

        if (page == 1) {
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
    if (dataArray.count) {
        return [dataArray count];

    }else{
        return 1;
 
    }
}
//cell-height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (dataArray.count) {
        return 120;
 
    }
    return 300;
}


//cell-tableview
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (dataArray.count) {
        static NSString *identifier = @"identifier";
        
        SecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[SecondTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            [cell configUI:indexPath];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (dataArray.count) {
            ProuctModel *model  = [dataArray objectAtIndex:indexPath.row];
            cell.productMoel = model;
        }
        //cell.textLabel.text = @"11111111";
        return cell;
    }else{
        static NSString *identifier = @"NoDataeidentifier";
        
        DeveloperTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[DeveloperTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            [cell configUI:indexPath];
        }
    
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell;
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (dataArray.count) {
        ProductDetailNewViewController *vc = [[ProductDetailNewViewController alloc]init];
        ProuctModel *model = [dataArray objectAtIndex:indexPath.row];
        vc.productID = [model.oid intValue];
        vc.productCateID = 5;
        vc.State = model.state;
        
        [self.navigationController pushViewController:vc animated:NO];
    }
   
}



/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
