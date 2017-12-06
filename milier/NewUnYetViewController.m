//
//  NewUnYetViewController.m
//  milier
//
//  Created by amin on 2017/11/22.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "NewUnYetViewController.h"
#import "YNPageScrollViewController.h"
#import "YNTestBaseViewController.h"
#import "YNJianShuDemoViewController.h"
#import <AwAlertViewlib/AwAlertViewlib.h>
#import "SDCycleScrollView.h"
#import "allUnYetViewController.h"
#import "oneYetViewController.h"
#import "TwoYetViewController.h"
#import "ThreeYetViewController.h"
#import "FourYetViewController.h"
#import "UserViewController.h"

@interface NewUnYetViewController ()<YNPageScrollViewControllerDataSource,SDCycleScrollViewDelegate,YNPageScrollViewControllerDelegate,YNPageScrollViewMenuDelegate>{
      YNJianShuDemoViewController *vc;
     AwAlertView *alertView;
     NSDictionary *TopMoneyArray;
    MBProgressHUD *hud;
}

@end

@implementation NewUnYetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的待收";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(0, 0, 44, 44);
    [leftBtn setImage:[UIImage imageNamed:@"backarrow"] forState:UIControlStateNormal];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0,0,0,8 *SCREEN_WIDTH/375.0)];
    
    [leftBtn addTarget:self action:@selector(UnYetClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    [self getNetworkData:YES];
   
}
- (void)HideProgress{
    [hud hideAnimated:YES afterDelay:1.5];
}
- (void)showProgress{
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    // Set the label text.
    
    hud.label.text = NSLocalizedString(@"正在请求中", @"HUD loading title");
}
-(void)getNetworkData:(BOOL)isRefresh
{
    NSString *url;
    NSString *tokenID = NSuserUse(@"Authorization");
    NSString *userID = NSuserUse(@"userId");
    
    url = [NSString stringWithFormat:@"%@/users/%@/repaymentStatistics",HOST_URL,userID];
    [[DateSource sharedInstance]requestHtml5WithParameters:nil  withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
        TopMoneyArray = [result objectForKey:@"data"];
         [self CreateUI];
        [self showProgress];
        [self HideProgress];
    }];
    

    
    
}
- (void)CreateUI{
    YNJianShuDemoViewController *viewController = [self getJianShuDemoViewController];
    [viewController addSelfToParentViewController:self isAfterLoadData:YES];
}
- (YNJianShuDemoViewController *)getJianShuDemoViewController{
    
    allUnYetViewController *one = [[allUnYetViewController alloc]init];
    
    oneYetViewController *two = [[oneYetViewController alloc]init];
    
    TwoYetViewController *three = [[TwoYetViewController alloc]init];
    
    ThreeYetViewController *four = [[ThreeYetViewController alloc]init];
    
     FourYetViewController  *five = [[FourYetViewController alloc]init];
    
    //配置信息
    YNPageScrollViewMenuConfigration *configration = [[YNPageScrollViewMenuConfigration alloc]init];
    configration.scrollViewBackgroundColor = [UIColor whiteColor];
    configration.itemLeftAndRightMargin = 0;
    configration.lineColor = colorWithRGB(0.96, 0.6, 0.11);
    configration.lineHeight = 2;
    configration.itemFont = [UIFont systemFontOfSize:15];
    configration.selectedItemColor = colorWithRGB(0.96, 0.6, 0.11);
    configration.aligmentModeCenter = YES;
    configration.showConver = NO;
    configration.showNavigation = YES;
    configration.showAddButton = NO;
    //configration.addButtonHightImageName = @"menu@2x";
    configration.addButtonNormalImageName = @"menu@2x";
    configration.itemMaxScale = 1.05;
    configration.lineBottomMargin = 0;
    configration.pageScrollViewMenuStyle = YNPageScrollViewMenuStyleSuspension;
    configration.aligmentModeCenter = YES;
    configration.scrollMenu = YES;
    configration.showGradientColor = NO;//取消渐变
    configration.showNavigation = YES;
    configration.showTabbar = NO;//设置显示tabbar
    configration.showPersonTab = NO;
    vc = [YNJianShuDemoViewController pageScrollViewControllerWithControllers:@[one,two,three,four,five] titles:@[@"全部  ",@"计息中  ",@"逾期  ",@"坏账  ",@"已还款  "] Configration:configration];
    vc.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 44);
    vc.dataSource = self;
    vc.delegate = self;
    
    //按钮点击
    vc.addButtonAtion = ^(UIButton *btn, YNPageScrollViewController *vc) {
        // NSLog(@"%f",btn.frame.size.height);
        
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        view.backgroundColor=[UIColor whiteColor];
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = 5.0f;
        view.alpha = 0.9;
        
        UIImageView *  CancelImageView = [[UIImageView alloc]init];
        
        CancelImageView.image = [UIImage imageNamed:@"close"];
        CancelImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *CancelTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(CancelClick)];
        [CancelImageView addGestureRecognizer:CancelTap];
        CancelImageView.frame = CGRectMake(SCREEN_WIDTH - 30, 30, 20, 20);
        [view addSubview:CancelImageView];
        
  
        
        alertView=[[AwAlertView alloc]initWithContentView:view];
        alertView.isUseHidden=YES;
        [alertView showAnimated:YES];
        // alertView.closeImage=[UIImage imageNamed:@"AwAlertViewlib.bundle/btn_navigation_close"];
        //alertView.closeImage_hl=[UIImage imageNamed:@"AwAlertViewlib.bundle/btn_navigation_close_hl"];
        
        
    };
    
    
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0)];
    footerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    vc.placeHoderView = footerView;
    
    //头部headerView
    UIView *headerView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, 375/2+20)];
    headerView2.backgroundColor = [UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"待收金额";
    titleLabel.textColor = colorWithRGB(0.97, 0.6, 0.11);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:28];
    [headerView2 addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(headerView2.mas_centerX);
        make.top.mas_equalTo(headerView2.mas_top).offset(20);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(20);
    }];
    
    
    _TopMoneyLabel = [[UILabel alloc]init];
    _TopMoneyLabel.text = @"$123124";
    _TopMoneyLabel.textColor = colorWithRGB(0.97, 0.6, 0.11);
    _TopMoneyLabel.textAlignment = NSTextAlignmentCenter;
    _TopMoneyLabel.font = [UIFont systemFontOfSize:28];
    [headerView2 addSubview:_TopMoneyLabel];
    [_TopMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(headerView2.mas_centerX);
        make.top.mas_equalTo(titleLabel.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    _LostMoneyLabel = [[UILabel alloc]init];
    _LostMoneyLabel.text = @"逾期利息";
    _LostMoneyLabel.textColor = colorWithRGB(0.56, 0.56, 0.56);
    _LostMoneyLabel.font =[UIFont systemFontOfSize:15];
    _LostMoneyLabel.textAlignment = NSTextAlignmentCenter;
    [headerView2 addSubview:_LostMoneyLabel];
    [_LostMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headerView2.mas_left);
        make.top.mas_equalTo(_TopMoneyLabel.mas_bottom).offset(40);
        make.width.mas_equalTo(SCREEN_WIDTH/2);
        make.height.mas_equalTo(20);
    }];
    
    UIImageView *rorrowImage = [[UIImageView alloc]init];
    rorrowImage.image = [UIImage imageNamed:@"xsarrow"];
    [headerView2 addSubview:rorrowImage];
    [rorrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_LostMoneyLabel.mas_right).offset(-40);
        make.top.mas_equalTo(_LostMoneyLabel.mas_bottom).offset(20);
        make.width.mas_equalTo(7);
        make.height.mas_equalTo(7);
    }];
    
    _LostMoneyNumberLabel = [[UILabel alloc]init];
    _LostMoneyNumberLabel.text = @"$123214";
    _LostMoneyNumberLabel.textColor = colorWithRGB(0.97, 0.6, 0.11);
    
    _LostMoneyNumberLabel.font =[UIFont systemFontOfSize:15];
    _LostMoneyNumberLabel.textAlignment = NSTextAlignmentCenter;
    [headerView2 addSubview:_LostMoneyNumberLabel];
    [_LostMoneyNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headerView2.mas_left);
        make.top.mas_equalTo(_LostMoneyLabel.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH/2);
        make.height.mas_equalTo(20);
    }];
    
    _BackMoneyLabel = [[UILabel alloc]init];
    _BackMoneyLabel.text = @"坏账待还";
    _BackMoneyLabel.textColor = colorWithRGB(0.56, 0.56, 0.56);
    
    _BackMoneyLabel.font =[UIFont systemFontOfSize:15];
    _BackMoneyLabel.textAlignment = NSTextAlignmentCenter;
    [headerView2 addSubview:_BackMoneyLabel];
    [_BackMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(headerView2.mas_right);
        make.top.mas_equalTo(_TopMoneyLabel.mas_bottom).offset(40);
        make.width.mas_equalTo(SCREEN_WIDTH/2);
        make.height.mas_equalTo(20);
    }];
    UIImageView *rorrowImage2 = [[UIImageView alloc]init];
    rorrowImage2.image = [UIImage imageNamed:@"xsarrow"];
    [headerView2 addSubview:rorrowImage2];
    [rorrowImage2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_BackMoneyLabel.mas_right).offset(-40);
        make.top.mas_equalTo(_BackMoneyLabel.mas_bottom).offset(20);
        make.width.mas_equalTo(7);
        make.height.mas_equalTo(7);
    }];
    
    _BackMoneyNumberLabel = [[UILabel alloc]init];
    _BackMoneyNumberLabel.text = @"$123214";
    _BackMoneyNumberLabel.textColor = colorWithRGB(0.97, 0.6, 0.11);
    
    _BackMoneyNumberLabel.font =[UIFont systemFontOfSize:15];
    _BackMoneyNumberLabel.textAlignment = NSTextAlignmentCenter;
    [headerView2 addSubview:_BackMoneyNumberLabel];
    [_BackMoneyNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(headerView2.mas_right);
        make.top.mas_equalTo(_BackMoneyLabel.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH/2);
        make.height.mas_equalTo(20);
    }];
    _TopMoneyLabel.text = [NSString stringWithFormat:@"¥%.2f",[[TopMoneyArray objectForKey:@"repaymentTotal"]doubleValue]];
    _LostMoneyNumberLabel.text = [NSString stringWithFormat:@"¥%.2f",[[TopMoneyArray objectForKey:@"overTotal"]doubleValue]];
    _BackMoneyNumberLabel.text = [NSString stringWithFormat:@"¥%.2f",[[TopMoneyArray objectForKey:@"badTotal"]doubleValue]];
    vc.headerView = headerView2;
    
    return vc;
}
#pragma mark - YNPageScrollViewControllerDataSource
- (UITableView *)pageScrollViewController:(YNPageScrollViewController *)pageScrollViewController scrollViewForIndex:(NSInteger)index{
    
    YNTestBaseViewController *VC= pageScrollViewController.viewControllers[index];
    NSLog(@"index%ld",(long)index);
    return [VC tableView];
    
};

- (BOOL)pageScrollViewController:(YNPageScrollViewController *)pageScrollViewController headerViewIsRefreshingForIndex:(NSInteger)index{
    
    YNTestBaseViewController *VC= pageScrollViewController.viewControllers[index];
    return [[[VC tableView] mj_header] isRefreshing];
}

- (void)pageScrollViewController:(YNPageScrollViewController *)pageScrollViewController scrollViewHeaderAndFooterEndRefreshForIndex:(NSInteger)index{
    
    YNTestBaseViewController *VC= pageScrollViewController.viewControllers[index];
    [[[VC tableView] mj_header] endRefreshing];
    [[[VC tableView] mj_footer] endRefreshing];
}


//- (void)pageScrollViewController:(YNPageScrollViewController *)pageScrollViewController scrollViewHeaderScaleContentOffset:(CGFloat)contentOffset{
//    NSLog(@"====%f",contentOffset);
//}
- (void)pageScrollViewController:(YNPageScrollViewController *)pageScrollViewController tableViewScrollViewContentOffset:(CGFloat)contentOffset progress:(CGFloat)progress{
    // NSLog(@"位置====%f",contentOffset);
    if (contentOffset >= 0 && contentOffset <= 150) {
        // NSLog(@" 调整弹出视图的位置");
    }
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
    [super viewWillDisappear:animated];
}
- (void)UnYetClick{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[UserViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
}
- (void)CancelClick{
    [alertView dismissAnimated:YES];
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
