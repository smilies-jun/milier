//
//  ConvertViewController.m
//  milier
//
//  Created by amin on 17/5/3.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "ConvertViewController.h"
#import "MyJiFenNewViewController.h"
#import "MJRefresh.h"
#import "OldProfileTableViewCell.h"
#import "ConvertTableViewCell.h"
#import "CostViewController.h"
#import "SubstanceViewController.h"
#import "giftModel.h"
#import "ConvertViewController.h"
#import "FYLCityPickView.h"
#import "ThirdViewController.h"
#import "YWDLoginViewController.h"


@interface ConvertViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *JiFenArray;
    NSString *jifenStr;
    UILabel *topView;
    NSDictionary* StaticUserDic;
    NSString *mYjifenStr;
    MBProgressHUD *hud;
    NSString *myTypeJifen;
}
@property (nonatomic,strong)UITableView *tableView;


@end

@implementation ConvertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"兑换礼品";
    self.view.backgroundColor = [UIColor grayColor];
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(0, 0, 44, 44);
    [leftBtn setImage:[UIImage imageNamed:@"backarrow"] forState:UIControlStateNormal];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0,0,0,8 *SCREEN_WIDTH/375.0)];
    [leftBtn addTarget:self action:@selector(ConvertClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    JiFenArray = [[NSMutableArray alloc]init];
    myTypeJifen = @"0";
    [self ConfigUI];
    [self showProgress];
    [self HideProgress];
}
- (void)HideProgress{
    [hud hideAnimated:YES afterDelay:1.0];
}
- (void)showProgress{
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    // Set the label text.
    
    hud.label.text = NSLocalizedString(@"正在请求中", @"HUD loading title");
}
- (void)clear{
    NSLog(@"123");
}
- (void)ConvertClick{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[MyJiFenNewViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[ThirdViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
}
-(void)ConfigUI{
    int myWidth;   int myHeight;
    if ([myTypeJifen integerValue] ==1) {
        self.view.backgroundColor = [UIColor whiteColor];
        topView = [[UILabel alloc]init];
        topView.backgroundColor = colorWithRGB(0.97, 0.93, 0.89);
        topView.frame = CGRectMake(0, 64, SCREEN_WIDTH, 40);
        topView.layer.borderWidth = 0.5;
        topView.layer.borderColor = [colorWithRGB(0.95, 0.6, 0.11) CGColor];
        topView.textAlignment = NSTextAlignmentCenter;
        topView.font = [UIFont systemFontOfSize:13];
        topView.textColor = colorWithRGB(0.95, 0.6, 0.11);
        [self.view addSubview:topView];
    if ([_Type integerValue] ==1) {
        myWidth = SCREEN_HEIGHT - 60 -40;
        myHeight = 104;
         topView.hidden = NO;
    }else{
        topView.hidden = YES;
        myWidth = SCREEN_HEIGHT;
        myHeight = 0;
       
    }
    if ([_MyType integerValue] ==2) {
        topView.hidden = YES;
        myWidth = SCREEN_HEIGHT-60;
        myHeight = 0;
    }else{
         NSString *userID = NSuserUse(@"userId");
        if ([userID integerValue]) {
            myWidth = SCREEN_HEIGHT - 60-40;
            myHeight = 104;
            topView.hidden = NO;
        }else{
            topView.hidden = YES;
            myWidth = SCREEN_HEIGHT;
            myHeight = 0;
        }
       
    }
    }else{
        if ([_MyUIType integerValue] ==1) {
            myWidth = SCREEN_HEIGHT;
            myHeight = 0;
            topView.hidden = YES;
        }else{
            myWidth = SCREEN_HEIGHT-60;
            myHeight = 0;
            topView.hidden = YES;
        }
       
    }
    
        page = 0;
        isFirstCome = YES;
        isJuhua = NO;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,myHeight, SCREEN_WIDTH, myWidth) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadoconNew)];
        self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadconMore)];
        _tableView.tableFooterView = [UIView new];
        _tableView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_tableView];
        
    [self HideProgress];
    
    
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

- (void)requestUSer{
        NSString *url;
        NSString *tokenID = NSuserUse(@"Authorization");
        url = [NSString stringWithFormat:@"%@/commodities/expire",HOST_URL];
        [[DateSource sharedInstance]requestHtml5WithParameters:nil  withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
            if ([[result objectForKey:@"statusCode"]integerValue] == 200) {
                if ([[result objectForKey:@"state"]integerValue] == 1) {
                    jifenStr = [result objectForKey:@"introduction"];
                    mYjifenStr = @"1";
                    [self ConfigUI];
                }else{
                    mYjifenStr = @"0";
                    [self ConfigUI];
                }
                
            }
            
        }];
        NSString *Statisurl;
        NSString *userID = NSuserUse(@"userId");
        if ([userID integerValue]) {
            Statisurl = [NSString stringWithFormat:@"%@/%@/statistics",USER_URL,userID];
            [[DateSource sharedInstance]requestHtml5WithParameters:nil  withUrl:Statisurl withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
               StaticUserDic = [result objectForKey:@"data"];
                
                [self requestHead];
            }];
        }
        
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
    //  NSString *userID = NSuserUse(@"userId");
    
    NSString *url;
    if (isRefresh) {
        url = [NSString stringWithFormat:@"%@/commodities?page=1&rows=20",HOST_URL];
    }else{
        url = [NSString stringWithFormat:@"%@/commodities?page=%d&rows=20",HOST_URL,page];
        
    }
    if (page == 1) {
        [JiFenArray removeAllObjects];
    }
    NSString *Statisurl;
    NSString *userID = NSuserUse(@"userId");
    if ([userID integerValue]) {
        Statisurl = [NSString stringWithFormat:@"%@/%@/statistics",USER_URL,userID];
        [[DateSource sharedInstance]requestHtml5WithParameters:nil  withUrl:Statisurl withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
            StaticUserDic = [result objectForKey:@"data"];
            mYjifenStr = [StaticUserDic objectForKey:@"points"];
        }];
    }
    [[DateSource sharedInstance]requestHtml5WithParameters:nil  withUrl:url withTokenStr:tokenID  usingBlock:^(NSDictionary *result, NSError *error) {
        for (NSDictionary *dic  in [result objectForKey:@"items"]) {
            
            giftModel *model = [[giftModel alloc]init];
            model.dataDictionary = dic;
            [JiFenArray addObject:model];
        }
        
        [self.tableView reloadData];
        
        [self endRefresh];
        if ([[result objectForKey:@"items"]count]==0    ) {
            [self reset];
        }
    }];
    
   
    
  
    
    
}
- (void)requestHead{
    
    if ([myTypeJifen integerValue] ==1) {
        if ([_Type integerValue]== 1) {
            UIView * viewBackInNavi=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 90, 30)];
            viewBackInNavi.backgroundColor=[UIColor clearColor];
            viewBackInNavi.userInteractionEnabled=YES;
            //重做按钮
            UIButton *myRightRePaintBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 18, 30)];
            [myRightRePaintBtn addTarget:self action:@selector(clear) forControlEvents:UIControlEventTouchUpInside];
            [myRightRePaintBtn setBackgroundColor:[UIColor whiteColor]];
            [myRightRePaintBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
            [myRightRePaintBtn setImage:[UIImage imageNamed:@"sstar"] forState:UIControlStateNormal];
            [myRightRePaintBtn setTitle:[NSString stringWithFormat:@" %@",NSLocalizedString(@"local_paintAgain", nil)] forState:UIControlStateNormal];
            myRightRePaintBtn.titleLabel.adjustsFontSizeToFitWidth=YES;
            [viewBackInNavi addSubview:myRightRePaintBtn];
            
            //提交按钮
            UILabel *myRightSubmitBtn=[[UILabel alloc]initWithFrame:CGRectMake(18, 0, 90-18, 30)];
            myRightSubmitBtn.text = [NSString stringWithFormat:@"%@",[StaticUserDic objectForKey:@"points"]];
            myRightSubmitBtn.userInteractionEnabled = YES;
            UITapGestureRecognizer *mtTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clear)];
            [myRightSubmitBtn addGestureRecognizer:mtTap];
            myRightSubmitBtn.backgroundColor = [UIColor whiteColor ];
            myRightSubmitBtn.textColor = colorWithRGB(0.95, 0.6, 0.0);
            myRightSubmitBtn.textAlignment = NSTextAlignmentLeft;
            
            [viewBackInNavi addSubview:myRightSubmitBtn];
            
            
            UIBarButtonItem * right=[[UIBarButtonItem alloc]initWithCustomView:viewBackInNavi];
            //将整个viewBackInNavi右移10
            UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]   initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace   target:nil action:nil];
            //negativeSpacer.width =-10;//负数为右移，正数为左移
            self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer,right, nil];
            
            
        }else{
            if ([_MyType integerValue] == 0) {
                NSString *userID = NSuserUse(@"userId");
                if ([userID integerValue]) {
                    UIView * viewBackInNavi=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 90, 30)];
                    viewBackInNavi.backgroundColor=[UIColor clearColor];
                    viewBackInNavi.userInteractionEnabled=YES;
                    //重做按钮
                    UIButton *myRightRePaintBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 18, 30)];
                    [myRightRePaintBtn addTarget:self action:@selector(clear) forControlEvents:UIControlEventTouchUpInside];
                    [myRightRePaintBtn setBackgroundColor:[UIColor whiteColor]];
                    [myRightRePaintBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
                    [myRightRePaintBtn setImage:[UIImage imageNamed:@"sstar"] forState:UIControlStateNormal];
                    [myRightRePaintBtn setTitle:[NSString stringWithFormat:@" %@",NSLocalizedString(@"local_paintAgain", nil)] forState:UIControlStateNormal];
                    myRightRePaintBtn.titleLabel.adjustsFontSizeToFitWidth=YES;
                    [viewBackInNavi addSubview:myRightRePaintBtn];
                    
                    //提交按钮
                    UILabel *myRightSubmitBtn=[[UILabel alloc]initWithFrame:CGRectMake(18, 0, 90-18, 30)];
                    myRightSubmitBtn.text = [NSString stringWithFormat:@"%@",[StaticUserDic objectForKey:@"points"]];
                    myRightSubmitBtn.userInteractionEnabled = YES;
                    UITapGestureRecognizer *mtTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clear)];
                    [myRightSubmitBtn addGestureRecognizer:mtTap];
                    myRightSubmitBtn.backgroundColor = [UIColor whiteColor ];
                    myRightSubmitBtn.textColor = colorWithRGB(0.95, 0.6, 0.0);
                    myRightSubmitBtn.textAlignment = NSTextAlignmentLeft;
                    
                    [viewBackInNavi addSubview:myRightSubmitBtn];
                    
                    
                    UIBarButtonItem * right=[[UIBarButtonItem alloc]initWithCustomView:viewBackInNavi];
                    //将整个viewBackInNavi右移10
                    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]   initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace   target:nil action:nil];
                    //negativeSpacer.width =-10;//负数为右移，正数为左移
                    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer,right, nil];
                }
                
            }
            
        }
    }else {
        
    }
    
}
- (void)reset{
    [self.tableView reloadData];
    
    // 拿到当前的上拉刷新控件，变为没有更多数据的状态
    [self.tableView.mj_footer endRefreshingWithNoMoreData];
}
//设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  [JiFenArray count];
}


//组头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
//cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"Convertidentifier";
    
    ConvertTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[ConvertTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell configUI:indexPath];
    }
    if (JiFenArray.count) {
        giftModel *model = [JiFenArray objectAtIndex:indexPath.row];
        cell.GiftModel = model;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   NSString *userID = NSuserUse(@"userId");
    if ([userID integerValue]) {
        giftModel *model = [JiFenArray objectAtIndex:indexPath.row];
        if ([mYjifenStr integerValue]<[model.score integerValue]) {
            normal_alert(@"提示", @"您的积分不足", @"确定");
        }else{
            if ([model.type integerValue] == 1) {
                CostViewController *vc = [[CostViewController alloc]init];
                vc.NameStr = model.name;
                vc.TypeUI = _MyUIType;
                vc.TypeStr = model.type;
                vc.ProductID = model.oid;
                vc.ScoreStr = [NSString stringWithFormat:@"%@",model.score];
                [self.navigationController   pushViewController:vc animated:NO];
            }else if([model.type integerValue] == 3)  {
                SubstanceViewController *vc = [[SubstanceViewController alloc]init];
                vc.NameStr = model.name;
                vc.TypeUI = _MyUIType;
                vc.ProductID = model.oid;
                vc.ScoreStr = [NSString stringWithFormat:@"%@",model.score];
                [self.navigationController   pushViewController:vc animated:NO];
                
            }else{
                CostViewController *vc = [[CostViewController alloc]init];
                vc.NameStr = model.name;
                vc.TypeUI = _MyUIType;
                vc.TypeStr = model.type;
                vc.ProductID = model.oid;
                vc.ScoreStr = [NSString stringWithFormat:@"%@",model.score];
                [self.navigationController   pushViewController:vc animated:NO];
            }
        }
        
    }else{
        YWDLoginViewController *loginVC = [[YWDLoginViewController alloc] init];
        UINavigationController *loginNagition = [[UINavigationController alloc]initWithRootViewController:loginVC];
        loginNagition.navigationBarHidden = YES;
        [self presentViewController:loginNagition animated:NO completion:nil];
    }
   
   
    
   
    
    //    SectionViewController *sVC = [[SectionViewController alloc] init];
    //    sVC.rowLabelText = [NSString stringWithFormat:@"第%ld组的第%ld个cell",(long)indexPath.section,(long)indexPath.row];
    //    [self presentViewController:sVC animated:YES completion:nil];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self requestHead];
    [self requestUSer];
    [self getNetworkData:YES];
   
    // 马上进入刷新状态
   //[self.tableView.mj_header beginRefreshing];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    isFirstCome = YES;
    
    [super viewWillDisappear:animated];
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
