//
//  MyJiFenNewViewController.m
//  milier
//
//  Created by amin on 2017/6/22.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "MyJiFenNewViewController.h"
#import "SDCycleScrollView.h"
#import "YNJianShuDemoViewController.h"
#import "MJRefresh.h"
#import "BoundViewController.h"
#import "UserViewController.h"
#import "YNTestOneViewController.h"


#import "JiFenRecordViewController.h"
#import "JiFenConvertViewController.h"
#import "MJRefresh.h"
#import "UserViewController.h"
#import "ConvertViewController.h"
#import "ZJScrollPageView.h"
#import "ZJPageTableViewController.h"
#import "BundProfileViewController.h"


@interface MyJiFenNewViewController ()<YNPageScrollViewControllerDataSource,SDCycleScrollViewDelegate,YNPageScrollViewControllerDelegate,YNPageScrollViewMenuDelegate>{
    NSDictionary *UserDic;
    NSDictionary *ShareDic;
    int Type;
    MBProgressHUD *hud;
    NSString *jifenStr;
    NSString *MyjifenStr;
    NSString *MyTypeJifen;
}

@property (nonatomic, strong) UIActivityIndicatorView *loadingView;

@end

@implementation MyJiFenNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的积分";
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(0, 0, 44, 44);
    [leftBtn setImage:[UIImage imageNamed:@"backarrow"] forState:UIControlStateNormal];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0,0,0,8 *SCREEN_WIDTH/375.0)];
    [leftBtn addTarget:self action:@selector(jiFenTap) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
   
    
  }
-(void)requestUi{
    [self.loadingView startAnimating];
    [self.loadingView stopAnimating];
    
    YNJianShuDemoViewController *viewController = [self getJianShuDemoViewController];
    [viewController addSelfToParentViewController:self isAfterLoadData:YES];
    [self showProgress];
    [self HideProgress];
    UIView *saleView = [[UIView alloc]init];
    saleView.backgroundColor = [UIColor whiteColor];
    saleView.frame = CGRectMake(0, SCREEN_HEIGHT - 64-60, SCREEN_WIDTH, 60);
    [self.view addSubview:saleView];
    UILabel *SaleLbel =  [[UILabel alloc]init];
    SaleLbel.text = @"兑换礼品";
    SaleLbel.userInteractionEnabled = YES;
    SaleLbel.backgroundColor = colorWithRGB(0.95, 0.60, 0.11);
    SaleLbel.textAlignment = NSTextAlignmentCenter;
    SaleLbel.textColor = [UIColor whiteColor];
    SaleLbel.layer.cornerRadius = 20;
    SaleLbel.layer.masksToBounds = YES;
    [saleView addSubview:SaleLbel];
    [SaleLbel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(saleView.mas_centerX);
        make.centerY.mas_equalTo(saleView.mas_centerY);
        make.width.mas_equalTo(SCREEN_WIDTH - 40);
        make.height.mas_equalTo(40);
    }];
    
    UITapGestureRecognizer *SaleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(JiFenBtnClick
                                                                                                          )];
    [SaleLbel addGestureRecognizer:SaleTap];
}
- (void)requestJifen{
    
    NSString *tokenID = NSuserUse(@"Authorization");

    NSString *Statisurl;
    NSString *userID = NSuserUse(@"userId");
    if ([userID integerValue]) {
        Statisurl = [NSString stringWithFormat:@"%@/%@/statistics",USER_URL,userID];
        [[DateSource sharedInstance]requestHtml5WithParameters:nil  withUrl:Statisurl withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
            MyjifenStr = [[result objectForKey:@"data"] objectForKey:@"points"];
            [self requestUi];

        }];
    }
    NSString *url;
    url = [NSString stringWithFormat:@"%@/commodities/expire",HOST_URL];
    [[DateSource sharedInstance]requestHtml5WithParameters:nil  withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
        if ([[result objectForKey:@"statusCode"]integerValue] == 200) {
            if ([[result objectForKey:@"state"]integerValue] == 1) {
                 jifenStr = [result objectForKey:@"introduction"];
                MyTypeJifen = @"1";
                 [self requestUi];
            }else{
                 MyTypeJifen = @"0";
                [self requestUi];
            }
           
            
        }
        
    }];
   
    
}
- (void)HideProgress{
    [hud hideAnimated:YES afterDelay:1.5];
}
- (void)showProgress{
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    // Set the label text.
    
    hud.label.text = NSLocalizedString(@"正在请求中", @"HUD loading title");
}
- (void)jiFenTap{
    for (UIViewController *controller in self.navigationController.viewControllers) {
             if ([controller isKindOfClass:[UserViewController class]]) {
                 [self.navigationController popToViewController:controller animated:YES];
             }
         }
}
- (void)JiFenBtnClick{
    ConvertViewController    *ConvertVC = [[ConvertViewController alloc]init];
    ConvertVC.JifenStr =  MyjifenStr;
    ConvertVC.MyType = @"2";
    [self.navigationController pushViewController:ConvertVC animated:NO];

}
- (void)ConFigUI{
   
    [self.loadingView startAnimating];
    [self.loadingView stopAnimating];
    YNJianShuDemoViewController *viewController = [self getJianShuDemoViewController];
    [viewController addSelfToParentViewController:self isAfterLoadData:YES];
}
- (YNJianShuDemoViewController *)getJianShuDemoViewController{
    //配置信息
    YNPageScrollViewMenuConfigration *configration = [[YNPageScrollViewMenuConfigration alloc]init];
    //configration.scrollViewBackgroundColor = [UIColor redColor];
    configration.itemLeftAndRightMargin = 30;
    configration.itemMargin = 60;
    configration.lineColor = [UIColor orangeColor];
    configration.lineHeight = 2;
    configration.itemMaxScale = 1.2;
    configration.pageScrollViewMenuStyle = YNPageScrollViewMenuStyleSuspension;
    configration.scrollViewBackgroundColor = [UIColor whiteColor]    ;
    configration.selectedItemColor = [UIColor blackColor];
    configration.normalItemColor = [UIColor grayColor];
    configration.selectedItemColor = [UIColor blackColor];
    //configration.showConver = YES;
    //configration.converColor = colorWithRGB(1,0.87, 0.01);
    //设置平分不滚动   默认会居中
    // configration.aligmentModeCenter = YES;
    //configration.showScrollLine = NO;
    configration.scrollMenu = YES;
    configration.showGradientColor = NO;//取消渐变
    configration.showNavigation = YES;
    configration.showTabbar = YES;//设置显示tabbar
    
    //创建控制器
    YNJianShuDemoViewController *vc = [YNJianShuDemoViewController pageScrollViewControllerWithControllers:[self getViewController] titles:@[@"积分记录",@"兑换记录"] Configration:configration];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180)];
    imageView.userInteractionEnabled = YES;
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 40, SCREEN_WIDTH, 40);
    
    if ([MyjifenStr integerValue]) {
        label.text =[NSString   stringWithFormat:@"%@",MyjifenStr];

    }else{
        label.text  = @"0";
    }
    label.font = [UIFont systemFontOfSize:26];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor orangeColor];
    [imageView addSubview:label];
    UILabel *jifenlabel = [[UILabel alloc]init];
    jifenlabel.text = @"积分规则>>";
    jifenlabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *jifenTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(JifenProTap)];
    [jifenlabel addGestureRecognizer:jifenTap];
    jifenlabel.font = [UIFont systemFontOfSize:13];
    jifenlabel.textAlignment = NSTextAlignmentCenter;
    jifenlabel.frame = CGRectMake(0, 90, SCREEN_WIDTH, 20);
    jifenlabel.textColor = colorWithRGB(0.95, 0.6, 0.11);
    [imageView addSubview:jifenlabel];
    //        [jifenlabel mas_makeConstraints:^(MASConstraintMaker *make) {
    //            make.top.mas_equalTo(label.mas_bottom);
    //            make.left.mas_equalTo(label.mas_left);
    //            make.width.mas_equalTo(200);
    //            make.height.mas_equalTo(20);
    //        }];
    UILabel *topView = [[UILabel alloc]init];
    topView.backgroundColor = colorWithRGB(0.97, 0.93, 0.89);
    topView.frame = CGRectMake(0, 130, SCREEN_WIDTH, 40);
    topView.layer.borderWidth = 0.5;
    topView.font = [UIFont systemFontOfSize:13];
    topView.layer.borderColor = [colorWithRGB(0.95, 0.6, 0.11) CGColor];
    topView.textAlignment = NSTextAlignmentCenter;
    topView.textColor = colorWithRGB(0.95, 0.6, 0.11);
    if ([MyTypeJifen integerValue] ==1) {
        if (jifenStr.length) {
            topView.text= jifenStr;
            topView.hidden = NO;
        }else{
            topView.hidden = YES;
        }
    }else{
        topView.hidden = YES;
    }
    
   
    [imageView addSubview:topView];
    imageView.backgroundColor = [UIColor whiteColor];
    UIView *bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = colorWithRGB(0.93, 0.93, 0.93);
    bottomView.frame = CGRectMake(0, 170, SCREEN_WIDTH, 10);
    [imageView addSubview:bottomView];

    //footer用来当做内容高度
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0)];
    footerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    vc.placeHoderView = footerView;
    vc.dataSource = self;
    vc.headerView = imageView;

    return vc;
}


- (void)JifenProTap{
        BundProfileViewController *vc= [[BundProfileViewController alloc]init];
        vc.TitleStr = @"积分规则";
        vc.WebStr = [NSString stringWithFormat:@"%@/score/rules.html",HOST_URL];
        [self.navigationController pushViewController:vc animated:NO];
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


//#pragma mark - lazy
//
//- (UIActivityIndicatorView *)loadingView{
//
//    if (!_loadingView) {
//        _loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//        _loadingView.hidesWhenStopped = YES;
//        _loadingView.center = self.view.center;
//        [self.view addSubview:_loadingView];
//    }
//
//    return _loadingView;
//}
//-(UIImage*) createImageWithColor:(UIColor*) color
//{
//    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
//    UIGraphicsBeginImageContext(rect.size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetFillColorWithColor(context, [color CGColor]);
//    CGContextFillRect(context, rect);
//    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return theImage;
//}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self requestJifen];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
    [super viewWillDisappear:animated];
}

- (void)ShareTap{
    //  返回指定页面
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[UserViewController  class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
