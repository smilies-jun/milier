//
//  ShareViewController.m
//  milier
//
//  Created by amin on 17/4/26.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "ShareViewController.h"
#import "SDCycleScrollView.h"
#import "YNJianShuDemoViewController.h"
#import "MJRefresh.h"
#import "BoundViewController.h"
#import "AleardyBoundViewController.h"
#import "UserViewController.h"
#import "YNTestOneViewController.h"
#import "ShareDetailViewController.h"
#import "SGQRCode.h"
#import <AwAlertViewlib/AwAlertViewlib.h>


@interface ShareViewController ()<YNPageScrollViewControllerDataSource,SDCycleScrollViewDelegate,YNPageScrollViewControllerDelegate,YNPageScrollViewMenuDelegate>{
    AwAlertView *alertView;

}

@property (nonatomic, strong) UIActivityIndicatorView *loadingView;

@end

@implementation ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"分享邀请";
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
    
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(0, 7, 18, 18);
    [leftBtn setImage:[UIImage imageNamed:@"backarrow@2x.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(ShareTap) forControlEvents:UIControlEventTouchUpInside];
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
    SaleLbel.text = @"使用道具";
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
    
    UITapGestureRecognizer *SaleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(UseBtnClick
                                                                                                          )];
    [SaleLbel addGestureRecognizer:SaleTap];
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
    configration.scrollViewBackgroundColor = colorWithRGB(1, 0.89, 0.53);
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
    configration.showTabbar = NO;//设置显示tabbar
    
    //创建控制器
    YNJianShuDemoViewController *vc = [YNJianShuDemoViewController pageScrollViewControllerWithControllers:[self getViewController] titles:@[@"已绑卡",@"未绑卡"] Configration:configration];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 600)];
    imageView.userInteractionEnabled = YES;
    
    
    
    UIImageView *TopImageView = [[UIImageView alloc]init];
    TopImageView.image = [UIImage imageNamed:@"shareforbonus"];
    TopImageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 365);
    [imageView addSubview:TopImageView];
    
    UIView *titleview = [[UIView alloc]init];
    titleview.backgroundColor = colorWithRGB(1, 0.94, 0.72);
    [imageView addSubview:titleview];
    [titleview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView.mas_left).offset(26);
        make.top.mas_equalTo(TopImageView.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH - 52);
        make.height.mas_equalTo(40);
    }];
    
    UILabel *titlelabel = [[UILabel alloc]init];
    titlelabel.textAlignment = NSTextAlignmentCenter;
    titlelabel.font = [UIFont systemFontOfSize:15];
    titlelabel.textColor = colorWithRGB(0.61, 0.32, 0.05);
    titlelabel.text = @"已获得5个红包，还有3个红包未领取";
    [titleview addSubview:titlelabel];
    [titlelabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(titleview.mas_centerX);
        make.centerY.mas_equalTo(titleview.mas_centerY);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(30);
    }];
    
    UILabel *SaleLbel =  [[UILabel alloc]init];
    SaleLbel.text = @"马上领取";
    SaleLbel.userInteractionEnabled = YES;
    SaleLbel.backgroundColor = colorWithRGB(0.91, 0.31, 0.24);
    SaleLbel.textAlignment = NSTextAlignmentCenter;
    SaleLbel.textColor = [UIColor whiteColor];
    SaleLbel.layer.cornerRadius = 10;
    SaleLbel.layer.masksToBounds = YES;
    [imageView addSubview:SaleLbel];
    [SaleLbel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(titleview.mas_centerX);
        make.top.mas_equalTo(titleview.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH - 52);
        make.height.mas_equalTo(40);
    }];
    
    UITapGestureRecognizer *SaleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(linquiBtnClick
                                                                                                          )];
    [SaleLbel addGestureRecognizer:SaleTap];
    
    
    
    UIView *UserInviteView = [[UIView alloc]init];
    UserInviteView.backgroundColor = colorWithRGB(1, 0.94, 0.72);
    [imageView addSubview:UserInviteView];
    [UserInviteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView.mas_left);
        make.top.mas_equalTo(SaleLbel.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    UIImageView *userImageView = [[UIImageView alloc]init];
    userImageView.image = [UIImage imageNamed:@"head"];
    userImageView.layer.cornerRadius = 20;
    userImageView.layer.masksToBounds = YES;
    [UserInviteView addSubview:userImageView];
    [userImageView   mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(UserInviteView.mas_left).offset(30);
        make.centerY.mas_equalTo(UserInviteView.mas_centerY);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
    }];
    UIImageView *codeImageView = [[UIImageView alloc]init];
    codeImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *CodeTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(setupGenerateQRCode)];
    [codeImageView addGestureRecognizer:CodeTap];
    codeImageView.image = [UIImage imageNamed:@"erweima"];
    codeImageView.backgroundColor = [UIColor orangeColor];
    [UserInviteView addSubview:codeImageView];
    [codeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(userImageView.mas_right).offset(10);
        make.centerY.mas_equalTo(UserInviteView.mas_centerY);
        make.width.mas_equalTo(18);
        make.height.mas_equalTo(18);
    }];
    
    
    UILabel *CodeLabel = [[UILabel alloc]init];
    CodeLabel.font = [UIFont systemFontOfSize:15];
    CodeLabel.textColor = colorWithRGB(0.61, 0.32, 0.05);
    CodeLabel.text = @"我的邀请码";
    [UserInviteView addSubview:CodeLabel];
    [CodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(codeImageView.mas_right).offset(10);
        make.centerY.mas_equalTo(UserInviteView.mas_centerY);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(20);
    }];
    
    UILabel *CodeNumberLabel = [[UILabel alloc]init];
    CodeNumberLabel.font = [UIFont systemFontOfSize:15];
    CodeNumberLabel.textColor = colorWithRGB(0.86, 0.29, 0.24);
    CodeNumberLabel.text = @"2324";
    [UserInviteView addSubview:CodeNumberLabel];
    [CodeNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CodeLabel.mas_right);
        make.centerY.mas_equalTo(UserInviteView.mas_centerY);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(20);
    }];
    

    UIView *InviteView = [[UIView alloc]init];
    InviteView.backgroundColor = colorWithRGB(1, 0.94, 0.72);
    [imageView addSubview:InviteView];
    [InviteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView.mas_left);
        make.top.mas_equalTo(UserInviteView.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(40);
    }];
    
    UILabel *MeLabel = [[UILabel alloc]init];
    MeLabel.text = @"我的邀请记录(共邀请7个好友)";
    MeLabel.textColor = colorWithRGB(0.61, 0.32, 0.05);
    MeLabel.font = [UIFont systemFontOfSize:14];
    [InviteView addSubview:MeLabel];
    [MeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(InviteView.mas_left).offset(40);
        make.centerY.mas_equalTo(InviteView.mas_centerY);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(40);
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

// 生成二维码
- (void)setupGenerateQRCode {
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH-40, 280)];
    view.backgroundColor=[UIColor whiteColor];
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 5.0f;
    //view.alpha = 0.9;
    
    UILabel *userLabel = [[UILabel alloc]init];
    userLabel.text = @"我的二维码";
    userLabel.font = [UIFont systemFontOfSize:14];
    userLabel.frame = CGRectMake(40, 10, 80, 20);
    [view addSubview:userLabel];
    
    UIImageView*   CancelImageView = [[UIImageView alloc]init];
    CancelImageView.image = [UIImage imageNamed:@"close"];
    CancelImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *CancelTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(CancelClick)];
    [CancelImageView addGestureRecognizer:CancelTap];
    CancelImageView.frame = CGRectMake(SCREEN_WIDTH - 40 - 30, 10, 20, 20);
    [view addSubview:CancelImageView];
    // 1、借助UIImageView显示二维码
    UIImageView *imageView = [[UIImageView alloc] init];
    CGFloat imageViewW = 200;
    CGFloat imageViewH = imageViewW;
    CGFloat imageViewX = 65;
    CGFloat imageViewY = 40;
    imageView.frame =CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
    [view addSubview:imageView];
    
    CGFloat scale = 0.2;
    
    // 2、将最终合得的图片显示在UIImageView上
    imageView.image = [SGQRCodeTool SG_generateWithLogoQRCodeData:@"https://github.com/kingsic" logoImageName:@"head" logoScaleToSuperView:scale];
    
    alertView=[[AwAlertView alloc]initWithContentView:view];
    alertView.isUseHidden=YES;
    [alertView showAnimated:YES];
    
    //[imageView addSubview:borderView];
}
- (void)CancelClick{
    [alertView dismissAnimated:NO];

}
- (void)linquiBtnClick{
    //领取
    ShareDetailViewController *vc = [[ShareDetailViewController alloc]init];
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


- (void)UseBtnClick{
    NSLog(@"使用");
}
- (NSArray *)getViewController{
    
    BoundViewController *one = [[BoundViewController alloc]init];
    
    AleardyBoundViewController *two = [[AleardyBoundViewController alloc]init];
    
    
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

@end
