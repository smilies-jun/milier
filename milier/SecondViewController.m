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
#import "YNTestFiveTableViewController.h"
#import "YNTestSixTableViewController.h"
#import "SecondMainViewController.h"
#import "YNTestBaseViewController.h"
#import "YNJianShuDemoViewController.h"
#import "SecondPushViewController.h"
#import "SnailCurtainView.h"
#import "SnailPopupController.h"
#import "MyPopView.h"
#import "FourViewController.h"
#import "YWDLoginViewController.h"
#import <AwAlertViewlib/AwAlertViewlib.h>
#import "UserViewController.h"
#import <EAIntroView/EAIntroView.h>
#import "ActivityDetailViewController.h"
#import "ConfirmBankViewController.h"
#import "DDAlertView.h"
#import "MessageViewController.h"
#import "MoreMoreHelpViewController.h"



@interface SecondViewController ()<YNPageScrollViewControllerDataSource,SDCycleScrollViewDelegate,YNPageScrollViewControllerDelegate,YNPageScrollViewMenuDelegate,EAIntroDelegate>{
    SDCycleScrollView *autoScrollView;
    SDCycleScrollView *BannerAutoScrollView;
    UIImageView *CancelImageView;
    
    UIImageView *NetImageView;//网贷基金
    UILabel *NetLabel;
    UIImageView *ProuctImageView;//特色产品
    UILabel *ProuctLabel;
    UIImageView *BussinessImageView;//企业贷款
    UILabel *BussinessLabel;
    UIImageView *PersonImageView;//个人贷款
    UILabel *PersonLabel;
    UIImageView *BuyCarImageView;//购车贷款
    UILabel *BuyCarLabel;
    UIImageView *ChangeImageView;//债券转让
    UILabel *ChangeLabel;
    YNJianShuDemoViewController *vc;
    AwAlertView *alertView;
    AwAlertView *BannerAlertView;
     UIView *rootView;
    
    NSMutableArray *ImageArray;
    NSMutableArray *ActivityArray;
     NSMutableArray *TitleArray;
    NSMutableArray *OidArray;
    
    NSMutableArray *AcImageArray;
    NSMutableArray *AcActivityArray;
    NSMutableArray *AcTitleArray;
    NSMutableArray *AcOidArray;
    NSDictionary *NoticeDic;
    MBProgressHUD *hud;
}
@property(nonatomic, strong) MBProgressHUD *aProgressHUD;

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
    rootView = self.rdv_tabBarController.view;
    ImageArray = [[NSMutableArray alloc]init];
    ActivityArray = [[NSMutableArray alloc]init];
    TitleArray = [[NSMutableArray alloc]init];
    OidArray = [[NSMutableArray alloc]init];
    
    AcImageArray = [[NSMutableArray alloc]init];
    AcActivityArray = [[NSMutableArray alloc]init];
    AcTitleArray = [[NSMutableArray alloc]init];
    AcOidArray = [[NSMutableArray alloc]init];
    NoticeDic = [[NSDictionary   alloc]init];
    
    EAIntroPage *page1 = [EAIntroPage page];
    page1.bgImage = [UIImage imageNamed:@"welcome1_select@2x"];
    
    EAIntroPage *page2 = [EAIntroPage page];
    page2.bgImage = [UIImage imageNamed:@"welcome2_select@2x"];
    
    EAIntroPage *page3 = [EAIntroPage page];
    page3.bgImage = [UIImage imageNamed:@"welcome_select@2x"];
    
    
    
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:rootView.bounds andPages:@[page1,page2,page3]];
    intro.pageControlY = 42.f;
    [intro.skipButton setTitle:@"跳过" forState:UIControlStateNormal];
    intro.skipButton.frame = CGRectMake(100, 100, 40, 40);
    [intro setDelegate:self];
    intro.pageControl.currentPageIndicatorTintColor = colorWithRGB(0.95, 0.6, 0.11);
    intro.pageControl.pageIndicatorTintColor = colorWithRGB(0.94, 0.94, 0.94) ;
    intro.skipButton.hidden = YES;
   // intro.skipButtonY = 80;
//    [intro.skipButton setTitle:@"Skip now" forState:UIControlStateNormal];
//    [intro.skipButton setImage:[UIImage imageNamed:@"explain"] forState:UIControlStateNormal];
    [intro setDelegate:self];

    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        [intro showInView:rootView animateDuration:0.3];
        [self showMyaActivity];
    }else {
        [self showMyaActivity];

    
    }
    
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setBarTintColor:[UIColor blackColor]];
    self.navigationItem.title = @"米粒儿金融";

    // 导航栏标题字体颜色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor blackColor]}];
    // 导航栏左右按钮字体颜色
    //self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
   
    [self GetVersion];
    [self refreshData];
    
    [self RequestData];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeWife) name:@"changeWife" object:nil];
    NSString *userID = NSuserUse(@"userId");
    if ([userID integerValue]) {
    
        NSString *url;
        NSString *tokenID = NSuserUse(@"Authorization");
        url = [NSString stringWithFormat:@"%@/bankValidate/%@",HOST_URL,userID];
        [[DateSource sharedInstance]requestHtml5WithParameters:nil withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
            if ([[result objectForKey:@"statusCode"]integerValue] == 200) {
                if ([[[result objectForKey:@"data"]objectForKey:@"validateState"]integerValue]) {
                    ConfirmBankViewController *vc1 = [[ConfirmBankViewController alloc]init];
                    [self presentViewController:vc1 animated:NO completion:nil];
 
                }
            }
            
        }];
        
    }
    
    
}
- (void)showMyaActivity{
    NSString *CarouselsUrl = [NSString stringWithFormat:@"%@/activities/isHomeAddActivity",HOST_URL];
    [[DateSource sharedInstance]requestHtml5WithParameters:nil  withUrl:CarouselsUrl withTokenStr:@"" usingBlock:^(NSDictionary *result, NSError *error) {
        NSString *stateStr = [result objectForKey:@"activity_state"];
        if ([stateStr integerValue] ==1) {
            [AcImageArray removeAllObjects];
            [AcActivityArray removeAllObjects];
            [AcTitleArray removeAllObjects];
            NSArray *array = [result objectForKey:@"items"];
            for (NSDictionary *dic in array) {
                [AcImageArray addObject:[dic objectForKey:@"image"]];
                [AcActivityArray addObject:[dic objectForKey:@"href"]];
                [AcTitleArray addObject:[dic objectForKey:@"title"]];
                [AcOidArray addObject:[dic objectForKey:@"oid"]];
            }
            
            [self ShowMySucess];
        }else{
            
        }
        
       
       
    }];
}
- (void)ShowMySucess{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-315)/2, 0, 315, 470)];
    view.backgroundColor=[UIColor clearColor];
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 10.0f;
    view.alpha = 0.9;
    
    BannerAutoScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0,315, 420) imageURLStringsGroup:AcImageArray];
    BannerAutoScrollView.delegate = self;
    BannerAutoScrollView.tag = 100;
    BannerAutoScrollView.layer.masksToBounds = YES;
    BannerAutoScrollView.layer.cornerRadius = 10.0f;
    BannerAutoScrollView.backgroundColor = colorWithRGB(0.93, 0.93, 0.93);
    [BannerAutoScrollView setPlaceholderImage:[UIImage imageNamed:@"bannerpic"]];
    [view addSubview:BannerAutoScrollView];
    
    UIButton *MyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [MyBtn addTarget:self action:@selector(bunnerDis) forControlEvents:UIControlEventTouchUpInside];
    [MyBtn setImage:[UIImage imageNamed:@"tcolse"] forState:UIControlStateNormal];
    [view addSubview:MyBtn];
    [MyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view.mas_centerX);
        make.top.mas_equalTo(BannerAutoScrollView.mas_bottom).offset(10);
        make.width.mas_equalTo(34);
        make.height.mas_equalTo(34);
    }];
    
    BannerAlertView=[[AwAlertView alloc]initWithContentView:view];
    BannerAlertView.isUseHidden=NO;
    [BannerAlertView showAnimated:YES];
}
- (void)bunnerDis{
    [BannerAlertView dismissAnimated:YES];
}
- (void)GetVersion{
    NSString *CarouselsUrl = [NSString stringWithFormat:@"%@/versions/latest?type=2",HOST_URL];
    [[DateSource sharedInstance]requestHtml5WithParameters:nil  withUrl:CarouselsUrl withTokenStr:@"" usingBlock:^(NSDictionary *result, NSError *error) {
        NSString *VersionNumber = [[result objectForKey:@"data"]objectForKey:@"versionNumber"];
        NSString *updateStatus = [[result objectForKey:@"data"]objectForKey:@"updateStatus"];
        NSString *desc = [[result objectForKey:@"data"]objectForKey:@"desc"];
        if ([VersionNumber isEqualToString:@"1.0"]) {
            
            if ([updateStatus integerValue]==3) {
                DDAlertView *view = [[DDAlertView alloc]initWithTitle:@"提示" message:desc cancelButtonTitle:@"立即更新" cancelBlock:^(){
                    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/米粒儿金融/id1142042774?l=zh&ls=1&mt=8"]];
                    //        [DDAlertView dismiss];
                } otherButtonTitle:nil otherBlock:nil];
                view.mode = DDAlertViewClosedNoAllowed ;
                [view show];
            }
            
            
          
        }
        
    }];
}
    
- (void)changeWife{
    [self refreshData];
    [self RequestData];


}
- (void)HideProgress{
     [hud hideAnimated:YES afterDelay:1.f];
}
- (void)showProgress{
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    // Set the label text.
    hud.label.text = NSLocalizedString(@"正在请求中", @"HUD loading title");
}

- (void)refreshData{
    UIImageView *LeftBtn = [[UIImageView alloc]init];
    LeftBtn.frame = CGRectMake(0, 0, 20, 20);
   
    if (@available(iOS 11.0, *)) {
        LeftBtn.layer.masksToBounds = YES;
        LeftBtn.layer.cornerRadius = 20;
        LeftBtn.layer.maskedCorners = kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner |kCALayerMinXMaxYCorner|kCALayerMaxXMaxYCorner;
    } else {
        LeftBtn.layer.masksToBounds = YES;
        LeftBtn.layer.cornerRadius = 20;
        // Fallback on earlier versions
    }
    LeftBtn.userInteractionEnabled = YES;
     LeftBtn.image = [UIImage imageNamed:@"headpicUser"];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(LeftBtnClick)];
    [LeftBtn addGestureRecognizer:tap];
   // [LeftBtn addTarget:self action:@selector(LeftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:LeftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIImage *rightImage = [[UIImage imageNamed:@"news"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithImage:rightImage style:UIBarButtonItemStylePlain target:self action:@selector(RightClick)];
        NSString *userID = NSuserUse(@"userId");
        NSString *url;
        NSString *tokenID = NSuserUse(@"Authorization");
        url = [NSString stringWithFormat:@"%@/%@",USER_URL,userID];
        [[DateSource sharedInstance]requestHtml5WithParameters:nil  withUrl:url withTokenStr:tokenID  usingBlock:^(NSDictionary *result, NSError *error) {
            if ([[result objectForKey:@"statusCode"]integerValue] == 200) {
                NSMutableDictionary *   UserDic = [result objectForKey:@"data"];
                NSuserSave([UserDic objectForKey:@"bankCardExist"], @"bankCardExist");
                NSuserSave([UserDic objectForKey:@"dealPasswordExist"], @"dealPasswordExist");
                NSuserSave([UserDic objectForKey:@"bankCardId"], @"bankCardId");
                NSuserSave([UserDic objectForKey:@"bankId"], @"bankId");
                NSuserSave([UserDic objectForKey:@"bankCardNumberSuffix"], @"bankCardNumberSuffix");
                NSuserSave([UserDic objectForKey:@"phoneNumber"], @"phoneNumber");
                NSuserSave([UserDic objectForKey:@"receivedPropsCount"], @"receivedPropsCount");
                NSuserSave([UserDic objectForKey:@"noneReceivedPropsCount"], @"noneReceivedPropsCount");
                NSuserSave([UserDic objectForKey:@"customersCount"], @"customersCount");
                NSuserSave([UserDic objectForKey:@"avatar"], @"avatar");
                NSString *userImageStr = NSuserUse(@"avatar");
                if (userImageStr.length) {
                      [LeftBtn sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[UserDic objectForKey:@"avatar"]]] placeholderImage:[UIImage imageNamed:@"headpicUser"]options:SDWebImageAllowInvalidSSLCertificates];
                    if (@available(iOS 11.0, *)) {
                        LeftBtn.layer.masksToBounds = YES;
                        LeftBtn.layer.cornerRadius = 20;
                        LeftBtn.layer.maskedCorners = kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner |kCALayerMinXMaxYCorner|kCALayerMaxXMaxYCorner;
                    } else {
                        LeftBtn.layer.masksToBounds = YES;
                        LeftBtn.layer.cornerRadius = 10;
                        // Fallback on earlier versions
                    }
                  
                }else{
                    LeftBtn.image = [UIImage imageNamed:@"headpicUser"];
                }
                [self RequestHead];
                self.navigationItem.rightBarButtonItem = rightItem;
            }else{
                LeftBtn.image = [UIImage imageNamed:@"headpicUser"];
                self.navigationItem.rightBarButtonItem = nil;
            }
            
        }];


}

- (void)RequestHead{
    NSString *tokenID = NSuserUse(@"Authorization");
    NSString *CarouselsUrl = [NSString stringWithFormat:@"%@/messages/isNewMessageExist",HOST_URL];
    [[DateSource sharedInstance]requestHtml5WithParameters:nil  withUrl:CarouselsUrl withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
        if ([[result objectForKey:@"exist"]integerValue]==1) {
            [self refreshUI];
        }
    }];

}

- (void)refreshUI{
    UIImage *rightImage = [[UIImage imageNamed:@"news_dot"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

     UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithImage:rightImage style:UIBarButtonItemStylePlain target:self action:@selector(RightClick)];
    self.navigationItem.rightBarButtonItem = rightItem;

}
- (void)RequestData{
    
    NSString *CarouselsUrl = [NSString stringWithFormat:@"%@",CAROUSSELS_URL];
    [[DateSource sharedInstance]requestHtml5WithParameters:nil  withUrl:CarouselsUrl withTokenStr:@"" usingBlock:^(NSDictionary *result, NSError *error) {
        [ImageArray removeAllObjects];
        [ActivityArray removeAllObjects];
        [TitleArray removeAllObjects];
        NSArray *array = [result objectForKey:@"items"];
        NoticeDic = [result objectForKey:@"data"];

        for (NSDictionary *dic in array) {
            [ImageArray addObject:[dic objectForKey:@"image"]];
            [ActivityArray addObject:[dic objectForKey:@"href"]];
            [TitleArray addObject:[dic objectForKey:@"desc"]];
            [OidArray addObject:[dic objectForKey:@"activityId"]];
        }
        // [self ShowMySucess];
        [self CreateUI];
    }];

}

- (void)CreateUI{
    [self.loadingView startAnimating];
    [self.loadingView stopAnimating];
    YNJianShuDemoViewController *viewController = [self getJianShuDemoViewController];
    [viewController addSelfToParentViewController:self isAfterLoadData:YES];
}
- (void)LeftBtnClick{
    [self showProgress];
    NSString *url;
    NSString *userID = NSuserUse(@"userId");
    NSString *tokenID = NSuserUse(@"Authorization");
    
    url = [NSString stringWithFormat:@"%@/%@",USER_URL,userID];
    [[DateSource sharedInstance]requestHtml5WithParameters:nil  withUrl:url withTokenStr:tokenID  usingBlock:^(NSDictionary *result, NSError *error) {
        NSString *state = [result objectForKey:@"statusCode"];
        if ([state integerValue] == 200) {
            [self HideProgress];
            UserViewController *NserVC = [[UserViewController alloc]init];
            [self.navigationController  pushViewController:NserVC animated:NO];
        }else{
            [self HideProgress];
            YWDLoginViewController *loginVC = [[YWDLoginViewController alloc] init];
            UINavigationController *loginNagition = [[UINavigationController alloc]initWithRootViewController:loginVC];
            loginNagition.navigationBarHidden = YES;
            [self presentViewController:loginNagition animated:NO completion:nil];
 
        }
    }];
    
    
//    if ([userID integerValue] > 0) {
//        NSString *tokenIsOrNo = NSuserUse(@"tokenIDisOraNo");
//        
//        
//        
//        if ([tokenIsOrNo integerValue] ==1) {
//                   }else{
//           
//        }
//        
//       
//    }else{
//        YWDLoginViewController *loginVC = [[YWDLoginViewController alloc] init];
//        UINavigationController *loginNagition = [[UINavigationController alloc]initWithRootViewController:loginVC];
//        loginNagition.navigationBarHidden = YES;
//        [self presentViewController:loginNagition animated:NO completion:nil];
//    }
   
    

}
- (void)RightClick{
//    FourViewController *fourVC = [[FourViewController alloc]init];
//    [self.navigationController pushViewController:fourVC animated:YES];
    
    MessageViewController *fourVC = [[MessageViewController alloc]init];
    [self.navigationController pushViewController:fourVC animated:YES];

}
- (void)changLabelText:(NSString *)text{
    //根据tag查找label
    //    UILabel *label = (UILabel *)[self.view viewWithTag:102];
    //    label.text = text;
}
- (void)viewWillLayoutSubviews{
    
    [super viewWillLayoutSubviews];
    
   // NSLog(@"%@",[NSValue valueWithCGRect:self.view.frame]);
    
}

- (void)viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews];
   // NSLog(@"%@",[NSValue valueWithCGRect:self.view.frame]);
}


- (YNJianShuDemoViewController *)getJianShuDemoViewController{
    
    YNTestOneViewController *one = [[YNTestOneViewController alloc]init];
    
    YNTestTwoViewController *two = [[YNTestTwoViewController alloc]init];
    
    YNTestThreeViewController *three = [[YNTestThreeViewController alloc]init];
    
    YNTestFourViewController *four = [[YNTestFourViewController alloc]init];
    
   // YNTestFiveTableViewController  *five = [[YNTestFiveTableViewController alloc]init];
    
    YNTestSixTableViewController  *six = [[YNTestSixTableViewController alloc]init];
    //配置信息
    YNPageScrollViewMenuConfigration *configration = [[YNPageScrollViewMenuConfigration alloc]init];
    configration.scrollViewBackgroundColor = [UIColor whiteColor];
    configration.itemLeftAndRightMargin = 20;
    configration.lineColor = colorWithRGB(0.96, 0.6, 0.11);
    configration.lineHeight = 2;
    configration.itemFont = [UIFont systemFontOfSize:15];
    configration.selectedItemColor = colorWithRGB(0.96, 0.6, 0.11);
    configration.aligmentModeCenter = NO;
    configration.showConver = NO;
    configration.showNavigation = YES;
    configration.showAddButton = YES;
    //configration.addButtonHightImageName = @"menu@2x";
    configration.addButtonNormalImageName = @"menu@2x";
    configration.itemMaxScale = 1.05;
    configration.lineBottomMargin = 0;
    configration.pageScrollViewMenuStyle = YNPageScrollViewMenuStyleSuspension;
    configration.aligmentModeCenter = NO;
    configration.scrollMenu = YES;
    configration.showGradientColor = NO;//取消渐变
    configration.showNavigation = YES;
    configration.showTabbar = YES;//设置显示tabbar
    vc = [YNJianShuDemoViewController pageScrollViewControllerWithControllers:@[one,two,three,four,six] titles:@[@"网贷基金",@"特色产品",@"企业贷款",@"个人贷款",@"债权转让"] Configration:configration];
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
        
        CancelImageView = [[UIImageView alloc]init];
        
        CancelImageView.image = [UIImage imageNamed:@"close"];
        CancelImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *CancelTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(CancelClick)];
        [CancelImageView addGestureRecognizer:CancelTap];
        CancelImageView.frame = CGRectMake(SCREEN_WIDTH - 30, 30, 20, 20);
        [view addSubview:CancelImageView];
    
        NetImageView = [[UIImageView alloc]init];
        NetImageView.tag = 1;
        NetImageView.image = [UIImage imageNamed:@"fund"];
        NetImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *NetTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(NetClick)];
        [NetImageView addGestureRecognizer:NetTap];
        [view addSubview:NetImageView];
        [NetImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (SCREEN_WIDTH == 375) {
                make.left.mas_equalTo(view.mas_left).offset(30);

            }else if (SCREEN_WIDTH == 320){
                make.left.mas_equalTo(view.mas_left).offset(10);
                
            }
            
            else{
                make.left.mas_equalTo(view.mas_left).offset(45);

            }
            make.top.mas_equalTo(view.mas_top).offset(70);
            make.width.mas_equalTo(68);
            make.height.mas_equalTo(68);
        }];
        NetLabel = [[UILabel alloc]init];
        NetLabel.text = @"网贷基金";
        NetLabel.font = [UIFont systemFontOfSize:13];
        [view addSubview:NetLabel];
        [NetLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(NetImageView.mas_centerX);
            make.top.mas_equalTo(NetImageView.mas_bottom).offset(10);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(20);
        }];
        ProuctImageView = [[UIImageView alloc]init];
        ProuctImageView.tag = 2;
        ProuctImageView.userInteractionEnabled = YES;
        ProuctImageView.image = [UIImage imageNamed:@"featured"];
        UITapGestureRecognizer *ProTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ProClick)];
        [ProuctImageView addGestureRecognizer:ProTap];
        [view addSubview:ProuctImageView];
        [ProuctImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (SCREEN_WIDTH == 320) {
                make.left.mas_equalTo(NetImageView.mas_right).offset(45);

            }else{
                make.left.mas_equalTo(NetImageView.mas_right).offset(55);
  
            }
            make.top.mas_equalTo(view.mas_top).offset(70);
            make.width.mas_equalTo(68);
            make.height.mas_equalTo(68);
        }];
        ProuctLabel = [[UILabel alloc]init];
        ProuctLabel.text = @"特色产品";
        ProuctLabel.font = [UIFont systemFontOfSize:13];
        [view addSubview:ProuctLabel];
        [ProuctLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(ProuctImageView.mas_centerX);
            make.top.mas_equalTo(ProuctImageView.mas_bottom).offset(10);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(20);
        }];
        BussinessImageView = [[UIImageView alloc]init];
        BussinessImageView.tag = 3;
        BussinessImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *BusTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(BusClick)];
        [BussinessImageView addGestureRecognizer:BusTap];
        BussinessImageView.image = [UIImage imageNamed:@"businessloans"];
        [view addSubview:BussinessImageView];
        [BussinessImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (SCREEN_WIDTH == 320) {
                make.left.mas_equalTo(ProuctImageView.mas_right).offset(45);

            }else{
                make.left.mas_equalTo(ProuctImageView.mas_right).offset(55);
 
            }
            make.top.mas_equalTo(view.mas_top).offset(70);
            make.width.mas_equalTo(68);
            make.height.mas_equalTo(68);
        }];
        BussinessLabel = [[UILabel alloc]init];
        BussinessLabel.text = @"企业贷款";
        BussinessLabel.font = [UIFont systemFontOfSize:13];
        [view addSubview:BussinessLabel];
        [BussinessLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(BussinessImageView.mas_centerX);
            make.top.mas_equalTo(BussinessImageView.mas_bottom).offset(10);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(20);
        }];
        
        PersonImageView = [[UIImageView alloc]init];
        PersonImageView.tag = 4;
        PersonImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *PerTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(PersonClick)];
        [PersonImageView addGestureRecognizer:PerTap];
        PersonImageView.image = [UIImage imageNamed:@"personalloan"];
        [view addSubview:PersonImageView];
        [PersonImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            if (SCREEN_WIDTH == 375) {
                make.left.mas_equalTo(view.mas_left).offset(30);
                
            }else if (SCREEN_WIDTH == 320){
                make.left.mas_equalTo(view.mas_left).offset(10);
            }else{
                make.left.mas_equalTo(view.mas_left).offset(45);
                
            }
            make.top.mas_equalTo(NetImageView.mas_bottom).offset(50);
            make.width.mas_equalTo(68);
            make.height.mas_equalTo(68);
        }];
        PersonLabel = [[UILabel alloc]init];
        PersonLabel.text = @"个人贷款";
        PersonLabel.font = [UIFont systemFontOfSize:13];
        [view addSubview:PersonLabel];
        [PersonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(PersonImageView.mas_centerX);
            make.top.mas_equalTo(PersonImageView.mas_bottom).offset(10);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(20);
        }];
//        BuyCarImageView = [[UIImageView alloc]init];
//        BuyCarImageView.tag = 5;
//        BuyCarImageView.userInteractionEnabled = YES;
//        UITapGestureRecognizer *BuyTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(BuyClick)];
//        [BuyCarImageView addGestureRecognizer:BuyTap];
//        BuyCarImageView.image = [UIImage imageNamed:@"carloan"];
//        [view addSubview:BuyCarImageView];
//        [BuyCarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            if (SCREEN_WIDTH == 320) {
//                make.left.mas_equalTo(PersonImageView.mas_right).offset(45);
//
//            }else{
//                make.left.mas_equalTo(PersonImageView.mas_right).offset(55);
//
//            }
//            make.top.mas_equalTo(NetImageView.mas_bottom).offset(50);
//            make.width.mas_equalTo(68);
//            make.height.mas_equalTo(68);
//        }];
//        BuyCarLabel = [[UILabel alloc]init];
//        BuyCarLabel.text = @"购车贷款";
//        BuyCarLabel.font = [UIFont systemFontOfSize:13];
//        [view addSubview:BuyCarLabel];
//        [BuyCarLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.mas_equalTo(BuyCarImageView.mas_centerX);
//            make.top.mas_equalTo(BuyCarImageView.mas_bottom).offset(10);
//            make.width.mas_equalTo(60);
//            make.height.mas_equalTo(20);
//        }];
        ChangeImageView = [[UIImageView alloc]init];
        ChangeImageView.tag = 5;
        ChangeImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *ChangeTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ChangeClick)];
        [ChangeImageView addGestureRecognizer:ChangeTap];
        ChangeImageView.image = [UIImage imageNamed:@"creditor"];
        [view addSubview:ChangeImageView];
        [ChangeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (SCREEN_WIDTH == 320) {
                make.left.mas_equalTo(PersonImageView.mas_right).offset(45);
   
            }else{
                make.left.mas_equalTo(PersonImageView.mas_right).offset(55);

            }
            make.top.mas_equalTo(NetImageView.mas_bottom).offset(50);
            make.width.mas_equalTo(68);
            make.height.mas_equalTo(68);
        }];
        ChangeLabel = [[UILabel alloc]init];
        ChangeLabel.text = @"债权转让";
        ChangeLabel.font = [UIFont systemFontOfSize:13];
        [view addSubview:ChangeLabel];
        [ChangeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(ChangeImageView.mas_centerX);
            make.top.mas_equalTo(ChangeImageView.mas_bottom).offset(10);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(20);
        }];
//        NSString *typeStr =  NSuserUse(@"qiye");
//        NSLog(@"type == %@",typeStr);
//        switch ([typeStr integerValue]) {
//            case 1:
//                [self BusClick];
//                break;
//            case 2:
//                [self NetClick];
//                break;
//            case 3:
//                [self BuyClick];
//                break;
//            case 4:
//                [self PersonClick];
//                break;
//            case 5:
//                [self ProClick];
//                break;
//            case 6:
//                [self ChangeClick];
//                break;
//            default:
//                break;
//        }

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
    UIView *headerView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, 375/2+40)];
    //轮播器
    
    
    
    autoScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0,self.view.frame.size.width, 375/2) imageURLStringsGroup:ImageArray];
    autoScrollView.delegate = self;
    autoScrollView.tag = 200;
    autoScrollView.backgroundColor = colorWithRGB(0.93, 0.93, 0.93);
    [autoScrollView setPlaceholderImage:[UIImage imageNamed:@"bannerpic"]];
    [headerView2 addSubview:autoScrollView];
    
    UILabel *NoticeLabel = [[UILabel alloc]init];
    NoticeLabel.backgroundColor = [UIColor whiteColor];
    NoticeLabel.userInteractionEnabled = YES;
    NoticeLabel.frame = CGRectMake(0, 375/2, SCREEN_WIDTH, 40);
    [headerView2 addSubview:NoticeLabel];
    
    UIImageView *NoticeImageView = [[UIImageView alloc]init];
    NoticeImageView.image = [UIImage  imageNamed:@"icon_notice"];
    NoticeImageView.frame = CGRectMake(10, 10, 30, 30);
    [NoticeLabel addSubview:NoticeImageView];
    
    UILabel *NewNoticeLabel = [[UILabel alloc]init];
    NewNoticeLabel.text=[NSString stringWithFormat:@"%@",[NoticeDic objectForKey:@"title"]];
    NewNoticeLabel.frame = CGRectMake(45, 10, SCREEN_WIDTH - 65, 30);
    NewNoticeLabel.userInteractionEnabled = YES;
    [NoticeLabel addSubview:NewNoticeLabel];
    
    UITapGestureRecognizer *MyNoticeTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(noticeClick)];
    [NewNoticeLabel addGestureRecognizer:MyNoticeTap];
    
    
    vc.headerView = headerView2;

    return vc;
}
- (void)noticeClick{
    MoreMoreHelpViewController *vc= [[MoreMoreHelpViewController alloc]init];
    vc.TitleStr =[NSString stringWithFormat:@"%@",[NoticeDic objectForKey:@"title"]];
    vc.WebStr = [NSString stringWithFormat:@"%@/%@",HOST_URL,[NoticeDic objectForKey:@"url"]];
    [self.navigationController pushViewController:vc animated:NO];
}
- (void)NetClick{
    [vc setPageScrollViewMenuSelectPageIndex:0 animated:NO];
    [alertView dismissAnimated:NO];
}
-(void)ProClick{
    [vc setPageScrollViewMenuSelectPageIndex:1 animated:NO];
    [alertView dismissAnimated:NO];
}
- (void)BusClick{
    [vc setPageScrollViewMenuSelectPageIndex:2 animated:NO];
    [alertView dismissAnimated:NO];
}
- (void)PersonClick{
    [vc setPageScrollViewMenuSelectPageIndex:3 animated:NO];
    [alertView dismissAnimated:NO];
}
//- (void)BuyClick{
//    [vc setPageScrollViewMenuSelectPageIndex:4 animated:NO];
//    [alertView dismissAnimated:NO];
//}
- (void)ChangeClick{
    [vc setPageScrollViewMenuSelectPageIndex:4 animated:NO];
    [alertView dismissAnimated:NO];
}
- (void)CancelClick{
    [alertView dismissAnimated:YES];
}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    [BannerAlertView dismissAnimated:YES];
    ActivityDetailViewController *fourVC = [[ActivityDetailViewController alloc]init];
    if (cycleScrollView.tag == 200) {
        fourVC.WebStr = [ActivityArray objectAtIndex:index];
        if ( fourVC.WebStr.length) {
            fourVC.TitleStr = [TitleArray objectAtIndex:index];
            fourVC.activioid  = [OidArray  objectAtIndex:index];
            [self.navigationController pushViewController:fourVC animated:YES];
        }
    }else{
        fourVC.WebStr = [AcActivityArray objectAtIndex:index];
        if ( fourVC.WebStr.length) {
            fourVC.TitleStr = [AcTitleArray objectAtIndex:index];
            fourVC.activioid  = [AcOidArray  objectAtIndex:index];
            [self.navigationController pushViewController:fourVC animated:YES];
        }
    }
    
  
}
- (void)pageScrollViewMenuItemOnClick:(UILabel *)label index:(NSInteger)index{
    
    NSLog(@"label = %@",label);
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
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //[self refreshData];
    //[self RequestData];
//    NSString *refresh =     NSuserUse( @"refresh");
//    NSLog(@"re == %@",refresh);
//    if ([refresh integerValue] == 1) {
//          [self refreshData];
//          [self RequestData];
//    }else{
//        NSuserSave(@"0", @"refresh");
//    }
    
    [self GetVersion];
    NSString *heafresh =     NSuserUse( @"heafresh");
    if ([heafresh integerValue] ==1) {
        [self refreshData];
        NSuserSave(@"0", @"heafresh");
    }
     [self refreshData];
    NSString *typeStr =  NSuserUse(@"qiye");
    switch ([typeStr integerValue]) {
        case 1:
            [self BusClick];
            break;
        case 2:
            [self NetClick];
            break;
        case 3:
            [self ChangeClick];
            break;
        case 4:
            [self PersonClick];
            break;
        case 5:
            [self ProClick];
            break;
        
        default:
            break;
    }

//    [[DateSource sharedInstance]CheckNetWorkinguseingBlock:^(NSString *staus) {
//        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
//        
//        // Set the text mode to show only text.
//        hud.mode = MBProgressHUDModeText;
//        hud.label.text = NSLocalizedString(staus, @"HUD message title");
//        
//        [hud hideAnimated:YES afterDelay:1.f];
//    }];
}

//- (void)createTabbarItems
//{
//    
//    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 49 + 5)];
//    [imageView setImage:[self createImageWithColor:[UIColor clearColor]]];
//    [imageView setContentMode:UIViewContentModeScaleToFill];
//    [self.tabBarController.tabBar insertSubview:imageView atIndex:0];
//    //覆盖原生Tabbar的上横线
//    [[UITabBar appearance] setShadowImage:[self createImageWithColor:[UIColor whiteColor]]];
//    // 背景图片为透明色
//    [[UITabBar appearance] setBackgroundImage:[self createImageWithColor:[UIColor whiteColor]]];
//    self.tabBarController.tabBar.translucent = YES;
//}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
