//
//  MyJiFenViewController.m
//  milier
//
//  Created by amin on 17/4/24.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "MyJiFenViewController.h"
#import "JiFenRecordViewController.h"
#import "JiFenConvertViewController.h"
#import "SDCycleScrollView.h"
#import "YNJianShuDemoViewController.h"
#import "MJRefresh.h"
#import "UserViewController.h"

@interface MyJiFenViewController ()<YNPageScrollViewControllerDataSource,SDCycleScrollViewDelegate,YNPageScrollViewControllerDelegate,YNPageScrollViewMenuDelegate>


@property (nonatomic, strong) UIActivityIndicatorView *loadingView;

@end

@implementation MyJiFenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的积分";
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
    
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(0, 7, 18, 18);
    [leftBtn setImage:[UIImage imageNamed:@"backarrow@2x.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(JifenTap) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    [self.loadingView startAnimating];
    [self.loadingView stopAnimating];
    YNJianShuDemoViewController *viewController = [self getJianShuDemoViewController];
    [viewController addSelfToParentViewController:self isAfterLoadData:YES];
    
    UIView *saleView = [[UIView alloc]init];
    saleView.backgroundColor = [UIColor whiteColor];
    saleView.frame = CGRectMake(0, SCREEN_HEIGHT - 64-44, SCREEN_WIDTH, 44);
    [self.view addSubview:saleView];
    
    UILabel *SaleLbel =  [[UILabel alloc]init];
    SaleLbel.text = @"兑换礼品";
    SaleLbel.userInteractionEnabled = YES;
    SaleLbel.backgroundColor = [UIColor greenColor];
    SaleLbel.textAlignment = NSTextAlignmentCenter;
    SaleLbel.textColor = [UIColor whiteColor];
    SaleLbel.layer.cornerRadius = 10;
    SaleLbel.layer.masksToBounds = YES;
    [saleView addSubview:SaleLbel];
    [SaleLbel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(saleView.mas_centerX);
        make.centerY.mas_equalTo(saleView.mas_centerY);
        make.width.mas_equalTo(SCREEN_WIDTH - 80);
        make.height.mas_equalTo(30);
    }];
    
    UITapGestureRecognizer *SaleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(JiFenBtnClick
                                                                                                          )];
    [SaleLbel addGestureRecognizer:SaleTap];
}
//简书Demo
- (YNJianShuDemoViewController *)getJianShuDemoViewController{
    //配置信息
    YNPageScrollViewMenuConfigration *configration = [[YNPageScrollViewMenuConfigration alloc]init];
    configration.scrollViewBackgroundColor = [UIColor redColor];
    configration.itemLeftAndRightMargin = 30;
    configration.itemMargin = 60;
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
    configration.showNavigation = YES;
    configration.showTabbar = NO;//设置显示tabbar
    
    //创建控制器
    YNJianShuDemoViewController *vc = [YNJianShuDemoViewController pageScrollViewControllerWithControllers:[self getViewController] titles:@[@"积分纪录",@"兑换纪录"] Configration:configration];
    //头部视图
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    
    UILabel *jifenNumberLabel = [[UILabel alloc]init];
    jifenNumberLabel.text = @"121212121";
    jifenNumberLabel.textColor = [UIColor whiteColor];
    jifenNumberLabel.textAlignment = NSTextAlignmentCenter;
    jifenNumberLabel.font = [UIFont systemFontOfSize:50];
    [imageView addSubview:jifenNumberLabel];
    [jifenNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(imageView.mas_centerX);
        make.centerY.mas_equalTo(imageView.mas_centerY);
        make.width.mas_equalTo(280);
        make.height.mas_equalTo(80);
    }];
    
    //footer用来当做内容高度
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0)];
    footerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    vc.placeHoderView = footerView;
    vc.dataSource = self;
    vc.headerView = imageView;
    vc.IsTab = NO;
    return vc;
    
}
//兑换礼品
- (void)JiFenBtnClick{
    
}
- (void)JifenTap{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[UserViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
}
- (void)dealloc{
    
    NSLog(@"释放 父类 UIHomeViewController");
}

- (void)imageViewTap{
    
    NSLog(@"----- imageViewTap -----");
    
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
    
    JiFenRecordViewController *one = [[JiFenRecordViewController alloc]init];
    
    JiFenConvertViewController *two = [[JiFenConvertViewController alloc]init];
    
    
    
    return @[one,two];
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
