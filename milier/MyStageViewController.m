//
//  MyStageViewController.m
//  milier
//
//  Created by amin on 17/4/25.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "MyStageViewController.h"
#import "SDCycleScrollView.h"
#import "YNJianShuDemoViewController.h"
#import "MJRefresh.h"
#import "UserViewController.h"
#import "QiYeViewController.h"
#import "BuyCarViewController.h"
#import "InterentViewController.h"
#import "PersonViewController.h"

@interface MyStageViewController ()<YNPageScrollViewControllerDataSource,SDCycleScrollViewDelegate,YNPageScrollViewControllerDelegate,YNPageScrollViewMenuDelegate>


@property (nonatomic, strong) UIActivityIndicatorView *loadingView;


@end

@implementation MyStageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的道具";
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
    
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(0, 7, 18, 18);
    [leftBtn setImage:[UIImage imageNamed:@"backarrow@2x.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(SatgeTap) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    [self.loadingView startAnimating];
    [self.loadingView stopAnimating];
    YNJianShuDemoViewController *viewController = [self getJianShuDemoViewController];
    [viewController addSelfToParentViewController:self isAfterLoadData:YES];
   
}
- (void)SatgeTap{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[UserViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }

}
- (YNJianShuDemoViewController *)getJianShuDemoViewController{
    //配置信息
    YNPageScrollViewMenuConfigration *configration = [[YNPageScrollViewMenuConfigration alloc]init];
    configration.scrollViewBackgroundColor = [UIColor redColor];
    configration.itemLeftAndRightMargin = 10;
    configration.itemMargin = 30;
    configration.lineColor = [UIColor orangeColor];
    configration.lineHeight = 2;
    configration.itemMaxScale = 1.2;
    configration.pageScrollViewMenuStyle = YNPageScrollViewMenuStyleSuspension;
    configration.scrollViewBackgroundColor = [UIColor whiteColor];
    configration.selectedItemColor = [UIColor redColor];
    //设置平分不滚动   默认会居中
    // configration.aligmentModeCenter = YES;
    configration.scrollMenu = YES;
    configration.showGradientColor = NO;//取消渐变
    configration.showNavigation = NO;
    configration.showTabbar = NO;//设置显示tabbar
    
    YNJianShuDemoViewController   *vc = [YNJianShuDemoViewController pageScrollViewControllerWithControllers:[self getViewController] titles:@[@"企业贷款",@"网贷基金",@"购车贷款",@"个人贷款"] Configration:configration];
    vc.dataSource = self;
    vc.IsTab = YES;
    return vc;
}



#pragma mark - YNPageScrollViewControllerDataSource
- (UITableView *)pageScrollViewController:(YNPageScrollViewController *)pageScrollViewController scrollViewForIndex:(NSInteger)index{
    
    YNTestBaseViewController *VC= pageScrollViewController.viewControllers[index];
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


- (NSArray *)getViewController{
    
    QiYeViewController *one = [[QiYeViewController alloc]init];
    
    BuyCarViewController *three = [[BuyCarViewController alloc]init];
    
    InterentViewController *two = [[InterentViewController alloc]init];
    
    PersonViewController *four = [[PersonViewController alloc]init];
    
    return @[one,two,three,four];
}


#pragma mark - lazy

- (UIActivityIndicatorView *)loadingView{
    
    if (!_loadingView) {
        
        _loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _loadingView.hidesWhenStopped = YES;
        _loadingView.center = self.view.center;
        [self.view addSubview:_loadingView];
    }
    
    return _loadingView;
}
-(UIImage*) createImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
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
