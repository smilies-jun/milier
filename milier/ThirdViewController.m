//
//  ThirdViewController.m
//  milier
//
//  Created by amin on 17/2/21.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "ThirdViewController.h"
#import "CustomMoreView.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import "AllMoneyViewController.h"
#import "SepartViewController.h"
#import "OutViewController.h"
#import "YNPageScrollViewController.h"
#import "SDCycleScrollView.h"
#import "MoreHelpViewController.h"


@interface ThirdViewController ()<UITableViewDelegate, UITableViewDataSource,YNPageScrollViewControllerDataSource,SDCycleScrollViewDelegate,YNPageScrollViewControllerDelegate>{
    CustomMoreView *AboutUsView;
    CustomMoreView *SafeView;
    CustomMoreView *NewPersonView;
    CustomMoreView *HelpView;
    CustomMoreView *AllView;
    CustomMoreView *ShareView;
    CustomMoreView *DuiHuanView;
    CustomMoreView *TellUsView;
}

@end

@implementation ThirdViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"个人";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"更多";
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor blackColor]}];
    self.view.backgroundColor = colorWithRGB(0.97, 0.97, 0.97);
    [self ConfigUI];
}
- (void)ConfigUI{
    AboutUsView = [[CustomMoreView alloc]init];
    AboutUsView.NameLabel.text = @"关于我们";
    AboutUsView.userInteractionEnabled = YES;
    AboutUsView.tag = 1;
    UITapGestureRecognizer *AboutTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(MoreClick)];
    [AboutUsView addGestureRecognizer:AboutTap];
    AboutUsView.StaticImageView.image = [UIImage imageNamed:@"about"];
    [self.view addSubview:AboutUsView];
    [AboutUsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self.view.mas_top).offset(74);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(40);
    }];
    
    SafeView  = [[CustomMoreView alloc]init];
    SafeView.StaticImageView.image = [UIImage imageNamed:@"safe"];
    SafeView.userInteractionEnabled = YES;
    SafeView.tag = 1;
    UITapGestureRecognizer *SafeTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SafeMoreClick)];
    [SafeView addGestureRecognizer:SafeTap];

    SafeView.NameLabel.text = @"安全保障";
    [self.view addSubview:SafeView];
    [SafeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(AboutUsView.mas_bottom).offset(0.5);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(40);
    }];
    
    NewPersonView  = [[CustomMoreView alloc]init];
    NewPersonView.StaticImageView.image = [UIImage imageNamed:@"novice"];
    NewPersonView.userInteractionEnabled = YES;
    NewPersonView.tag = 1;
    UITapGestureRecognizer *PersonTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(NewMoreClick)];
    [NewPersonView addGestureRecognizer:PersonTap];

    NewPersonView.NameLabel.text = @"新手指引";
    [self.view addSubview:NewPersonView];
    [NewPersonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(SafeView.mas_bottom).offset(0.5);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(40);
    }];
    HelpView  = [[CustomMoreView alloc]init];
    HelpView.StaticImageView.image = [UIImage imageNamed:@"help"];
    HelpView.userInteractionEnabled = YES;
    HelpView.tag = 1;
    UITapGestureRecognizer *HelpTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(HelpMoreClick)];
    [HelpView addGestureRecognizer:HelpTap];

    HelpView.NameLabel.text = @"投资帮助";
    [self.view addSubview:HelpView];
    [HelpView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(NewPersonView.mas_bottom).offset(0.5);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(40);
    }];
    AllView   = [[CustomMoreView alloc]init];
    AllView.StaticImageView.image = [UIImage imageNamed:@"financing"];
    AllView.userInteractionEnabled = YES;
    UITapGestureRecognizer *allTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(AllClick)];
    [AllView addGestureRecognizer:allTap];
    AllView.NameLabel.text = @"全民理财师";
    [self.view addSubview:AllView];
    [AllView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(HelpView.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(40);
    }];
    ShareView  = [[CustomMoreView alloc]init];
    ShareView.StaticImageView.image = [UIImage imageNamed:@"share"];
    ShareView.userInteractionEnabled = YES;
    UITapGestureRecognizer *shareTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ShareClick)];
    [ShareView addGestureRecognizer:shareTap];
    ShareView.NameLabel.text = @"分享领礼包";
    [self.view addSubview:ShareView];
    [ShareView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(AllView.mas_bottom).offset(0.5);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(40);
    }];
    DuiHuanView  = [[CustomMoreView alloc]init];
    DuiHuanView.StaticImageView.image = [UIImage imageNamed:@"gift"];

    DuiHuanView.NameLabel.text = @"积分换礼品";
    [self.view addSubview:DuiHuanView];
    [DuiHuanView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(ShareView.mas_bottom).offset(0.5);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(40);
    }];
    TellUsView  = [[CustomMoreView alloc]init];
    TellUsView.StaticImageView.image = [UIImage imageNamed:@"feedback"];
    TellUsView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TellUSClick)];
    [TellUsView addGestureRecognizer:tap];
    TellUsView.NameLabel.text = @"意见反馈";
    [self.view addSubview:TellUsView];
    [TellUsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(DuiHuanView.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(40);
    }];
    
    
}
//关于我们
- (void)MoreClick{
    MoreHelpViewController *MoreVC = [[MoreHelpViewController alloc]init];
    MoreVC.type = 1;
    MoreVC.TitleStr = @"关于我们";
    [self.navigationController pushViewController:MoreVC animated:NO];
    
}
//安全
- (void)SafeMoreClick{
    MoreHelpViewController *MoreVC = [[MoreHelpViewController alloc]init];
    MoreVC.type = 2;
    MoreVC.TitleStr = @"安全保障";

    [self.navigationController pushViewController:MoreVC animated:NO];

}

//新手
- (void)NewMoreClick{
    MoreHelpViewController *MoreVC = [[MoreHelpViewController alloc]init];
    MoreVC.type = 3;
    MoreVC.TitleStr = @"新手指引";

    [self.navigationController pushViewController:MoreVC animated:NO];

}
//投资帮助
-(void)HelpMoreClick{
    MoreHelpViewController *MoreVC = [[MoreHelpViewController alloc]init];
    MoreVC.type = 4;
    MoreVC.TitleStr = @"投资帮助";

    [self.navigationController pushViewController:MoreVC animated:NO];

}
//意见反馈
- (void)TellUSClick{
    NSLog(@"意见反馈");
    NSString *urlStr = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=1142042774&pageNumber=0&sortOrdering=2&mt=8"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
}
- (void)AllClick{
    UIViewController *allvc = nil;
    allvc = [self getAllMoneyViewController];
    [self.navigationController   pushViewController:allvc animated:NO];
}
- (UIViewController *)getAllMoneyViewController{
    //配置信息
    YNPageScrollViewMenuConfigration *configration = [[YNPageScrollViewMenuConfigration alloc]init];
    configration.scrollViewBackgroundColor = [UIColor redColor];
    configration.itemLeftAndRightMargin = 10;
    configration.itemMargin = 30;
    configration.itemFont = [UIFont systemFontOfSize:13];
    configration.lineColor = colorWithRGB(0.96, 0.6, 0.11);
    configration.lineHeight = 2;
    configration.itemMaxScale = 1.2;
    configration.scrollViewBackgroundColor = colorWithRGB(1, 0.87, 0.25);
    configration.pageScrollViewMenuStyle = YNPageScrollViewMenuStyleSuspension;
    configration.scrollViewBackgroundColor = [UIColor whiteColor];
    configration.selectedItemColor = colorWithRGB(0.96, 0.6, 0.11);
    //设置平分不滚动   默认会居中
    // configration.aligmentModeCenter = YES;
    configration.scrollMenu = YES;
    configration.showGradientColor = NO;//取消渐变
    configration.showNavigation = NO;
    configration.showTabbar = NO;//设置显示tabbar
    
    AllMoneyViewController *vc = [AllMoneyViewController pageScrollViewControllerWithControllers:[self getViewController] titles:@[@"分成列表",@"转出记录"] Configration:configration];
    // 头部是否能伸缩效果   要伸缩效果就不要有下拉刷新控件 默认NO*/
    vc.HeaderViewCouldScale = YES;
    
    
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 245)];
    imageView.backgroundColor = colorWithRGB(1, 0.87, 0.25);
    imageView.userInteractionEnabled = YES;
    UIImageView *TopImageView = [[UIImageView alloc]init];
    TopImageView.image = [UIImage imageNamed:@"licaishipic"];
    TopImageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 160);
    [imageView addSubview:TopImageView];
    
    UILabel *MyScorLabel = [[UILabel alloc]init];
    MyScorLabel.text = @"我的总分成：280元";
    MyScorLabel.font = [UIFont systemFontOfSize:12];
    [imageView addSubview:MyScorLabel];
    [MyScorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView.mas_left).offset(10);
        make.top.mas_equalTo(TopImageView.mas_bottom).offset(10);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(20);
    }];
    UILabel *DetailLabel = [[UILabel alloc]init];
    DetailLabel.text = @"全民理财师，躺着把钱赚";
    DetailLabel.font = [UIFont systemFontOfSize:12];
    DetailLabel.textAlignment = NSTextAlignmentRight;
    [imageView addSubview:DetailLabel];
    [DetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(imageView.mas_right).offset(-10);
        make.top.mas_equalTo(TopImageView.mas_bottom).offset(10);
        make.width.mas_equalTo(140);
        make.height.mas_equalTo(20);
    }];
    UILabel *myMoneyLabel = [[UILabel alloc]init];
    myMoneyLabel.text = @"我的分成🐟🈷️额";
    myMoneyLabel.font = [UIFont systemFontOfSize:14];
    [imageView addSubview:myMoneyLabel];
    [myMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView.mas_left).offset(10);
        make.top.mas_equalTo(MyScorLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(20);
    }];
    
    UILabel *ComeLabel = [[UILabel alloc]init];
    ComeLabel.text = @"转入米粒余额";
    ComeLabel.textAlignment = NSTextAlignmentCenter;
    ComeLabel.layer.cornerRadius = 10;
    ComeLabel.layer.masksToBounds = YES;
    ComeLabel.textColor = [UIColor whiteColor];
    ComeLabel.backgroundColor = colorWithRGB(0.95, 0.6, 0.11);
    ComeLabel.font = [UIFont systemFontOfSize:13];
    [imageView addSubview:ComeLabel];
    [ComeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(imageView.mas_right).offset(-30);
        make.top.mas_equalTo(MyScorLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(35);
    }];
    
    //里面有默认高度 等ScrollView的高度 //里面设置了背景颜色与tableview相同
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0)];
    
    
    vc.pageIndex = 0;
    
    vc.placeHoderView = footerView;
    vc.IsTab = YES;
    vc.headerView = imageView;
    
    vc.dataSource = self;
    
    
    
    return vc;

}
- (UITableView *)pageScrollViewController:(YNPageScrollViewController *)pageScrollViewController scrollViewForIndex:(NSInteger)index{
    
    YNTestBaseViewController *VC= (YNTestBaseViewController *)pageScrollViewController.currentViewController;
    return [VC tableView];
    
};

- (BOOL)pageScrollViewController:(YNPageScrollViewController *)pageScrollViewController headerViewIsRefreshingForIndex:(NSInteger)index{
    
    YNTestBaseViewController *VC= (YNTestBaseViewController *)pageScrollViewController.currentViewController;
    return [[[VC tableView] mj_header ] isRefreshing];
}

- (void)pageScrollViewController:(YNPageScrollViewController *)pageScrollViewController scrollViewHeaderAndFooterEndRefreshForIndex:(NSInteger)index{
    
    YNTestBaseViewController *VC= pageScrollViewController.viewControllers[index];
    [[[VC tableView] mj_header] endRefreshing];
    [[[VC tableView] mj_footer] endRefreshing];
}

- (NSArray *)getViewController{
    
    SepartViewController *one = [[SepartViewController alloc]init];
    
    OutViewController   *two = [[OutViewController alloc]init];
    

    return @[one,two];
}

-(void)ShareClick{
    //先构造分享参数：
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                     images:@[[UIImage imageNamed:@"erweima"]]
                                        url:[NSURL URLWithString:@"http://mob.com"]
                                      title:@"分享标题"
                                       type:SSDKContentTypeAuto];
    //有的平台要客户端分享需要加此方法，例如微博
    [shareParams SSDKEnableUseClientShare];
    //调用分享的方法
    SSUIShareActionSheetController *sheet = [ShareSDK showShareActionSheet:self.view
                                                                     items:nil
                                                               shareParams:shareParams
                                                       onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                                                           switch (state) {
                                                               case SSDKResponseStateSuccess:
                                                                   NSLog(@"分享成功!");
                                                                   break;
                                                               case SSDKResponseStateFail:
                                                                   NSLog(@"分享失败%@",error);
                                                                   break;
                                                               case SSDKResponseStateCancel:
                                                                   NSLog(@"分享已取消");
                                                                   break;
                                                               default:
                                                                   break;
                                                           }
                                                       }];
    //删除和添加平台示例
    //[sheet.directSharePlatforms removeObject:@(SSDKPlatformTypeWechat)];//(默认微信，QQ，QQ空间都是直接跳客户端分享，加了这个方法之后，可以跳分享编辑界面分享)
    [sheet.directSharePlatforms addObject:@(SSDKPlatformTypeSinaWeibo)];//（加了这个方法之后可以不跳分享编辑界面，直接点击分享菜单里的选项，直接分享）
}


#pragma mark - YNPageScrollViewDelegate
/** 伸缩开始结束监听*/
- (void)pageScrollViewController:(YNPageScrollViewController *)pageScrollViewController
      scrollViewHeaderScaleState:(BOOL)isStart {
    //这里处理方式不是特别好
    //1.在开始的时候需要手动隐藏背景图片,反之,相反.
    
    UIImageView *imageView =  (UIImageView *)pageScrollViewController.headerView;
    if (isStart) {
        imageView.image = nil;
    }else{
        imageView.image = [UIImage imageNamed:@"mine_header_bg"];
    }
    
    
}

/** 伸缩位置contentOffset*/
- (void)pageScrollViewController:(YNPageScrollViewController *)pageScrollViewController
scrollViewHeaderScaleContentOffset:(CGFloat)contentOffset {
    NSLog(@"contentOffset : %f",contentOffset);
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
