//
//  FirstViewController.m
//  milier
//
//  Created by amin on 17/2/21.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "FirstViewController.h"
#import "ActivityTableViewCell.h"
#import "MJRefresh.h"
#import "ActivityModel.h"
#import "ActivityDetailViewController.h"



@interface FirstViewController ()<UITableViewDataSource,UITableViewDelegate>{
    ActivityModel *Model;
    NSMutableArray *DataArray;
    NSString *MyType;
}
@property (nonatomic,strong)UITableView *tableView;


@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"活动列表";
    
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];

    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setBarTintColor:[UIColor blackColor]];
    // 导航栏标题字体颜色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor blackColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    self.view.backgroundColor = colorWithRGB(0.94, 0.94, 0.94);
    DataArray = [[NSMutableArray alloc]init];
//    if ([self checkCardNo:@"9558881202000216808"]) {
//        NSLog(@"22");
//    }
   //  NSString *userID = NSuserUse(@"userId");
//    NSString *CarouselsUrl = [NSString stringWithFormat:@"%@/versions/latest?type=2",HOST_URL];
//    [[DateSource sharedInstance]requestHtml5WithParameters:nil  withUrl:CarouselsUrl withTokenStr:@"" usingBlock:^(NSDictionary *result, NSError *error) {
//        NSString *VersionNumber = [[result objectForKey:@"data"]objectForKey:@"versionNumber"];
//        NSString *updateStatus = [[result objectForKey:@"data"]objectForKey:@"updateStatus"];
//        if ([VersionNumber isEqualToString:@"1.0"]) {
//
//            if ([updateStatus integerValue]==2) {
//                MyType = @"1";
//            }else{
//                MyType = @"0";
//            }
//            [self getNetworkData:YES];
//            [self ConfigUI];
//
//
//        }
//
//    }];
  
   
    [self getNetworkData:YES];
    [self ConfigUI];

}

- (BOOL) checkCardNo:(NSString*) cardNo{
    int oddsum = 0;     //奇数求和
    int evensum = 0;    //偶数求和
    int allsum = 0;
    int cardNoLength = (int)[cardNo length];
    int lastNum = [[cardNo substringFromIndex:cardNoLength-1] intValue];
    
    cardNo = [cardNo substringToIndex:cardNoLength - 1];
    for (int i = cardNoLength -1 ; i>=1;i--) {
        NSString *tmpString = [cardNo substringWithRange:NSMakeRange(i-1, 1)];
        int tmpVal = [tmpString intValue];
        if (cardNoLength % 2 ==1 ) {
            if((i % 2) == 0){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }else{
            if((i % 2) == 1){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }
    }
    
    allsum = oddsum + evensum;
    allsum += lastNum;
    if((allsum % 10) == 0)
        return YES;
    else
        return NO;
}


- (void)ConfigUI{
    page = 0;
    isFirstCome = YES;
    isJuhua = NO;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-44) style:UITableViewStylePlain];
    _tableView.backgroundColor = colorWithRGB(0.93, 0.93, 0.93);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNew)];
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    [self.view addSubview:_tableView];
  
}

- (void)loadNew{
    [self getNetworkData:YES];
}

- (void)loadMore{
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
    
    NSString *url;
    if (isFirstCome) {
        url = [NSString stringWithFormat:@"%@?page=%d&rows=10",ACTIVITIES_URL,page];
    }else{
        url = [NSString stringWithFormat:@"%@?page=%d&rows=10",ACTIVITIES_URL,page];

    }
    if (page == 1) {
        [DataArray removeAllObjects];
    }
    
    [[DateSource sharedInstance]requestHtml5WithParameters:nil  withUrl:url withTokenStr:nil usingBlock:^(NSDictionary *result, NSError *error) {
        [self endRefresh];
        isJuhua = NO;
               if (page == 1) {
            [DataArray removeAllObjects];
        }
        if (isJuhua) {
            [self endRefresh];
        }
            NSArray *myArray = [result objectForKey:@"items"];
        for (NSDictionary *NewArray in myArray) {
            Model = [[ActivityModel alloc]init];
            Model.dataDictionary = NewArray;
            [DataArray addObject:Model];
        }
         NSString *userID = NSuserUse(@"userId");
        if ([userID integerValue] == 49389) {
             [DataArray removeAllObjects];
        }
        if ([MyType integerValue] == 1 ) {
             [DataArray removeAllObjects];
        }
        [_tableView reloadData];
        isFirstCome = NO;
    }];
 
}
//设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (DataArray.count) {
        return DataArray.count;
    }
    return 1;
}


//组头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
//cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    return 330;

    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (DataArray.count) {
        static NSString *identifier = @"Activityidentifier";
        
        ActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[ActivityTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            [cell configUI:indexPath];
            cell.backgroundColor = colorWithRGB(0.93, 0.93, 0.93);
        }
        
        if ([DataArray count]) {
            ActivityModel *NewModel = [DataArray objectAtIndex: indexPath.row];
            cell.ActivityModel = NewModel;
        }
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
    if (DataArray.count) {
        ActivityDetailViewController *vc = [[ActivityDetailViewController alloc]init];
        ActivityModel *model = [DataArray objectAtIndex:indexPath.row];
        vc.WebStr = model.url;
        vc.Type = @"1";
        
        vc.activioid = model.oid;
        //vc.activioid = @"29";
      
        vc.TitleStr = model.name;
        [self.navigationController   pushViewController:vc animated:NO];
    }
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
