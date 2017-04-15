//
//  SecondViewController.m
//  milier
//
//  Created by amin on 17/2/21.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "SecondViewController.h"
#import "SDCycleScrollView.h"
#import "MJRefresh.h"
#import "YNPageScrollViewController.h"
#import "YNTestOneViewController.h"
#import "YNTestFourViewController.h"
#import "YNTestTwoViewController.h"
#import "YNTestThreeViewController.h"
#import "SecondMainViewController.h"
#import "YNTestBaseViewController.h"
#import "YNJianShuDemoViewController.h"
#import "SecondPushViewController.h"
#import "SnailCurtainView.h"
#import "SnailPopupController.h"
#import "MyPopView.h"

@interface SecondViewController ()<YNPageScrollViewControllerDataSource,SDCycleScrollViewDelegate,YNPageScrollViewControllerDelegate,YNPageScrollViewMenuDelegate>{

}

@property (nonatomic, strong) UIActivityIndicatorView *loadingView;
@property (nonnull, strong)UIView *ContentView;
@property (nonnull, strong)UIView *PopView;


@end

@implementation SecondViewController
//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        　self.title = @"米粒儿金融";
//    }
//    return self;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.000 green:0.800 blue:0.800 alpha:1.000]];
    // 导航栏标题字体颜色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11],NSForegroundColorAttributeName:[UIColor orangeColor]}];
    // 导航栏左右按钮字体颜色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

    self.navigationItem.title = @"米粒儿金融";
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    [self.loadingView startAnimating];
    [self.loadingView stopAnimating];
    YNJianShuDemoViewController *viewController = [self getJianShuDemoViewController];
    [viewController addSelfToParentViewController:self isAfterLoadData:YES];
    
    //遮罩
    self.ContentView = [[UIView alloc]init];
    self.ContentView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.ContentView.backgroundColor = [UIColor clearColor];
    
    
   // [self.view addSubview:self.ContentView];
    
    self.PopView = [[UIView alloc]init];
    self.PopView.backgroundColor = [UIColor redColor];
    self.PopView.frame = CGRectMake(0, 64+150, SCREEN_WIDTH, 700);

  //  [self.ContentView addSubview:self.PopView];
}

- (void)changLabelText:(NSString *)text{
    //根据tag查找label
    //    UILabel *label = (UILabel *)[self.view viewWithTag:102];
    //    label.text = text;
    NSLog(@"text = %@",text);
}
- (void)viewWillLayoutSubviews{
    
    [super viewWillLayoutSubviews];
    
    NSLog(@"%@",[NSValue valueWithCGRect:self.view.frame]);
    
}

- (void)viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews];
    NSLog(@"%@",[NSValue valueWithCGRect:self.view.frame]);
}

//简书Demo
- (YNJianShuDemoViewController *)getJianShuDemoViewController{
    
    YNTestOneViewController *one = [[YNTestOneViewController alloc]init];
    
    YNTestTwoViewController *two = [[YNTestTwoViewController alloc]init];
    
    YNTestThreeViewController *three = [[YNTestThreeViewController alloc]init];
    
    YNTestFourViewController *four = [[YNTestFourViewController alloc]init];
    
    
    //配置信息
    YNPageScrollViewMenuConfigration *configration = [[YNPageScrollViewMenuConfigration alloc]init];
    configration.scrollViewBackgroundColor = [UIColor whiteColor];
    configration.itemLeftAndRightMargin = 20;
    configration.lineColor = [UIColor orangeColor];
    configration.lineHeight = 2;
    configration.itemFont = [UIFont systemFontOfSize:12];
    configration.selectedItemColor = [UIColor orangeColor];
    configration.lineBottomMargin = 0;
    configration.aligmentModeCenter = NO;
    configration.showConver = NO;
    configration.showNavigation = YES;
    configration.showAddButton = YES;
    //configration.addButtonHightImageName = @"menu@2x";
    configration.addButtonNormalImageName = @"menu@2x";
    configration.showTabbar = NO;//设置显示tabbar
    configration.itemMaxScale = 1.2;
    
    configration.pageScrollViewMenuStyle = YNPageScrollViewMenuStyleSuspension;

    NSArray *imagesURLStrings = @[
                                  @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                  @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"];
    
    
    
    
    
    YNJianShuDemoViewController *vc = [YNJianShuDemoViewController pageScrollViewControllerWithControllers:@[one,two,three,four] titles:@[@"网贷基金",@"特色产品",@"企业贷款",@"个人贷款"] Configration:configration];
    vc.dataSource = self;
    vc.delegate = self;
    
    //按钮点击
    vc.addButtonAtion = ^(UIButton *btn, YNPageScrollViewController *vc) {
        NSLog(@"%f",btn.frame.size.height);
        
        
    //        MyPopView *cuView = [[MyPopView alloc]init];
//        
////        cuView.closeClicked = ^(UIButton *closeButton) {
////            [self.sl_popupController dismissWithDuration:0.25 elasticAnimated:NO];
////        };
////        cuView.didClickItems = ^(SnailCurtainView *curtainView, NSInteger index) {
////            [UIAlertController showAlert:curtainView.items[index].textLabel.text];
////        };
//        
//        self.sl_popupController = [SnailPopupController new];
//        self.sl_popupController.layoutType = PopupLayoutTypeBottom                ;
//        self.sl_popupController.allowPan = NO;
//        @weakify(self);
//        self.sl_popupController.maskTouched = ^(SnailPopupController * _Nonnull popupController) {
//            [weak_self.sl_popupController dismissWithDuration:0.25 elasticAnimated:NO];
//        };
//        [self.sl_popupController presentContentView:cuView duration:0.75 elasticAnimated:YES];
        
//        SecondPushViewController  *controller = [SecondPushViewController new];
//        controller.delegate = self;
//        controller.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
//        controller.providesPresentationContextTransitionStyle = YES;
//        controller.definesPresentationContext = YES;
//        controller.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//
//        controller.bubbleColor = [UIColor whiteColor];
//        [self presentViewController:controller animated:YES completion:^{
//            controller.view.alpha = 0.5;
//        }];
 };
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0)];
    footerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    vc.placeHoderView = footerView;
    
    
    //头部headerView
    UIView *headerView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, 150)];
    //轮播器
    SDCycleScrollView *autoScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0,self.view.frame.size.width, 150) imageURLStringsGroup:imagesURLStrings];
    autoScrollView.delegate = self;
    
    [headerView2 addSubview:autoScrollView];
    vc.headerView = headerView2;
 
    return vc;
}

- (void)dealloc{
    
    NSLog(@"释放 父类 UIHomeViewController");
}

- (void)imageViewTap{
    
    NSLog(@"----- imageViewTap -----");
    
}


- (void)pageScrollViewMenuItemOnClick:(UILabel *)label index:(NSInteger)index{
    
    NSLog(@"label = %@",label);
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


//- (void)pageScrollViewController:(YNPageScrollViewController *)pageScrollViewController scrollViewHeaderScaleContentOffset:(CGFloat)contentOffset{
//    NSLog(@"====%f",contentOffset);
//}
- (void)pageScrollViewController:(YNPageScrollViewController *)pageScrollViewController tableViewScrollViewContentOffset:(CGFloat)contentOffset progress:(CGFloat)progress{
    NSLog(@"位置====%f",contentOffset);
    if (contentOffset >= 0 && contentOffset <= 150) {
        NSLog(@" 调整弹出视图的位置");
    }
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


- (void)createTabbarItems
{
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 49 + 5)];
    [imageView setImage:[self createImageWithColor:[UIColor clearColor]]];
    [imageView setContentMode:UIViewContentModeScaleToFill];
    [self.tabBarController.tabBar insertSubview:imageView atIndex:0];
    //覆盖原生Tabbar的上横线
    [[UITabBar appearance] setShadowImage:[self createImageWithColor:[UIColor whiteColor]]];
    // 背景图片为透明色
    [[UITabBar appearance] setBackgroundImage:[self createImageWithColor:[UIColor whiteColor]]];
    self.tabBarController.tabBar.translucent = YES;
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
