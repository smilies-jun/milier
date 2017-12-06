//
//  DinQiMoneyViewController.m
//  milier
//
//  Created by amin on 2017/11/22.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "DinQiMoneyViewController.h"
#import "YNPageScrollViewController.h"
#import "YNTestBaseViewController.h"
#import "YNJianShuDemoViewController.h"
#import <AwAlertViewlib/AwAlertViewlib.h>
#import "SDCycleScrollView.h"
#import "UserViewController.h"
#import "oneDinqQiViewController.h"
#import "twoDinQiViewController.h"
#import "ThreeDinQiViewController.h"
#import "FourDinQiViewController.h"
#import "FiveDinQiViewController.h"
#import "SixDinQIViewController.h"
#import "OldProfitViewController.h"
#import "AddProfitViewController.h"
#import "SevenDinQiViewController.h"

@interface DinQiMoneyViewController ()<YNPageScrollViewControllerDataSource,SDCycleScrollViewDelegate,YNPageScrollViewControllerDelegate,YNPageScrollViewMenuDelegate>{
    YNJianShuDemoViewController *vc;
    AwAlertView *alertView;
    NSDictionary *MyDic;
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
    UIImageView *AllImageView;//债券转让
    UILabel *AllLabel;
    MBProgressHUD *hud;
}

@end

@implementation DinQiMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"定期投资";
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
    [self CreateUI];
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
    NSString *Bottomurl;
    NSString *userID = NSuserUse(@"userId");
    NSString *tokenID = NSuserUse(@"Authorization");
    
    Bottomurl = [NSString stringWithFormat:@"%@/%@/investmentStatistics?productCategoryId=0",USER_URL,userID];
    
    
    [[DateSource sharedInstance]requestHtml5WithParameters:nil  withUrl:Bottomurl withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
        MyDic = [result objectForKey:@"data"];
        
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
    
    oneDinqQiViewController *one = [[oneDinqQiViewController alloc]init];
    
    twoDinQiViewController *two = [[twoDinQiViewController alloc]init];
    
    ThreeDinQiViewController *three = [[ThreeDinQiViewController alloc]init];
    
    FourDinQiViewController  *four = [[FourDinQiViewController alloc]init];
    
    FiveDinQiViewController  *five = [[FiveDinQiViewController alloc]init];
    
    SixDinQIViewController    *six = [[SixDinQIViewController alloc]init];
    
    SevenDinQiViewController   *seven = [[SevenDinQiViewController alloc]init];
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
    configration.aligmentModeCenter = YES;
    configration.scrollMenu = YES;
    configration.showGradientColor = NO;//取消渐变
    configration.showNavigation = YES;
    configration.showTabbar = NO;//设置显示tabbar
    configration.showPersonTab = NO;
    vc = [YNJianShuDemoViewController pageScrollViewControllerWithControllers:@[one,two,three,four,five,six,seven] titles:@[@"全部",@"募集期",@"转让中",@"计息中",@"已还款",@"逾期",@"坏账"] Configration:configration];
    vc.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-44);
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
        NetImageView = [[UIImageView alloc]init];
        NetImageView.tag = 1;
        NetImageView.image = [UIImage imageNamed:@"quanbu1"];
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
        NetLabel.text = @"全部";
        NetLabel.textAlignment = NSTextAlignmentCenter;

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
        ProuctImageView.image = [UIImage imageNamed:@"muji1"];
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
        ProuctLabel.text = @"募集期";
        ProuctLabel.textAlignment = NSTextAlignmentCenter;

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
        BussinessImageView.image = [UIImage imageNamed:@"daicheng1"];
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
        BussinessLabel.text = @"转让中";
        BussinessLabel.textAlignment = NSTextAlignmentCenter;
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
        PersonImageView.image = [UIImage imageNamed:@"jixi1"];
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
        PersonLabel.text = @"计息中";
        PersonLabel.textAlignment = NSTextAlignmentCenter;

        PersonLabel.font = [UIFont systemFontOfSize:13];
        [view addSubview:PersonLabel];
        [PersonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(PersonImageView.mas_centerX);
            make.top.mas_equalTo(PersonImageView.mas_bottom).offset(10);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(20);
        }];
                BuyCarImageView = [[UIImageView alloc]init];
                BuyCarImageView.tag = 5;
                BuyCarImageView.userInteractionEnabled = YES;
                UITapGestureRecognizer *BuyTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(BuyClick)];
                [BuyCarImageView addGestureRecognizer:BuyTap];
                BuyCarImageView.image = [UIImage imageNamed:@"huankuan1"];
                [view addSubview:BuyCarImageView];
                [BuyCarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    if (SCREEN_WIDTH == 320) {
                        make.left.mas_equalTo(PersonImageView.mas_right).offset(45);
        
                    }else{
                        make.left.mas_equalTo(PersonImageView.mas_right).offset(55);
        
                    }
                    make.top.mas_equalTo(NetImageView.mas_bottom).offset(50);
                    make.width.mas_equalTo(68);
                    make.height.mas_equalTo(68);
                }];
                BuyCarLabel = [[UILabel alloc]init];
                BuyCarLabel.text = @"已还款";
                BuyCarLabel.textAlignment = NSTextAlignmentCenter;
        
                BuyCarLabel.font = [UIFont systemFontOfSize:13];
                [view addSubview:BuyCarLabel];
                [BuyCarLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.mas_equalTo(BuyCarImageView.mas_centerX);
                    make.top.mas_equalTo(BuyCarImageView.mas_bottom).offset(10);
                    make.width.mas_equalTo(60);
                    make.height.mas_equalTo(20);
                }];
        ChangeImageView = [[UIImageView alloc]init];
        ChangeImageView.tag = 6;
        ChangeImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *ChangeTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ChangeClick)];
        [ChangeImageView addGestureRecognizer:ChangeTap];
        ChangeImageView.image = [UIImage imageNamed:@"yuqi1"];
        [view addSubview:ChangeImageView];
        [ChangeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (SCREEN_WIDTH == 320) {
                make.left.mas_equalTo(BuyCarImageView.mas_right).offset(45);
                
            }else{
                make.left.mas_equalTo(BuyCarImageView.mas_right).offset(55);
                
            }
            make.top.mas_equalTo(NetImageView.mas_bottom).offset(50);
            make.width.mas_equalTo(68);
            make.height.mas_equalTo(68);
        }];
        ChangeLabel = [[UILabel alloc]init];
        ChangeLabel.text = @"逾期";
        ChangeLabel.textAlignment = NSTextAlignmentCenter;

        ChangeLabel.font = [UIFont systemFontOfSize:13];
        [view addSubview:ChangeLabel];
        [ChangeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(ChangeImageView.mas_centerX);
            make.top.mas_equalTo(ChangeImageView.mas_bottom).offset(10);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(20);
        }];
        
        AllImageView = [[UIImageView alloc]init];
        AllImageView.tag = 7;
        AllImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *AllTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(AllClick)];
        [AllImageView addGestureRecognizer:AllTap];
        AllImageView.image = [UIImage imageNamed:@"huaizhang1"];
        [view addSubview:AllImageView];
        [AllImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (SCREEN_WIDTH == 375) {
                make.left.mas_equalTo(view.mas_left).offset(30);
                
            }else if (SCREEN_WIDTH == 320){
                make.left.mas_equalTo(view.mas_left).offset(10);
            }else{
                make.left.mas_equalTo(view.mas_left).offset(45);
                
            }
            make.top.mas_equalTo(PersonImageView.mas_bottom).offset(50);
            make.width.mas_equalTo(68);
            make.height.mas_equalTo(68);
        }];
        AllLabel = [[UILabel alloc]init];
        AllLabel.text = @"坏账";
        AllLabel.textAlignment = NSTextAlignmentCenter;

        AllLabel.font = [UIFont systemFontOfSize:13];
        [view addSubview:AllLabel];
        [AllLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(AllImageView.mas_centerX);
            make.top.mas_equalTo(AllImageView.mas_bottom).offset(10);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(20);
        }];
        
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
    UIView *headerView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, 375/2+70)];
    headerView2.backgroundColor = [UIColor whiteColor];
    self.pieChart = [[ZFPieChart alloc] initWithFrame:CGRectMake(40, 30, 100, 100)];
    self.pieChart.userInteractionEnabled = NO;
    self.pieChart.dataSource= self;
    self.pieChart.delegate = self;
    self.pieChart.piePatternType = kPieChartPatternTypeForCirque;
    self.pieChart.isShadow = NO;
    self.pieChart.isShowPercent = NO;
    [self.pieChart strokePath];
    [headerView2  addSubview:self.pieChart];
    
    //    UILabel *TitleLabel = [[UILabel alloc]init];
    //    TitleLabel.textAlignment = NSTextAlignmentCenter;
    //    TitleLabel.text = @"在投资产";
    //    TitleLabel.font = [UIFont systemFontOfSize:15];
    //    TitleLabel.textColor = colorWithRGB(0.53, 0.53, 0.53);
    //    [self.pieChart addSubview:TitleLabel];
    //    [TitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.centerX.mas_equalTo(self.pieChart.mas_centerX);
    //        make.top.mas_equalTo(self.mas_top).offset(60);
    //        make.width.mas_equalTo(80);
    //        make.height.mas_equalTo(15);
    //    }];
    //
    //    UILabel *MoneyLabel = [[UILabel alloc]init];
    //    MoneyLabel.textAlignment = NSTextAlignmentCenter;
    //    MoneyLabel.text = @"234";
    //    MoneyLabel.font = [UIFont systemFontOfSize:16];
    //    [self.pieChart addSubview:MoneyLabel];
    //    [MoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.centerX.mas_equalTo(TitleLabel.mas_centerX);
    //        make.top.mas_equalTo(TitleLabel.mas_bottom).offset(5);
    //        make.width.mas_equalTo(100);
    //        make.height.mas_equalTo(20);
    //    }];
    
    UIImageView *FirstImageView = [[UIImageView alloc]init];
    FirstImageView.layer.cornerRadius = 5;
    FirstImageView.clipsToBounds = YES;
    FirstImageView.backgroundColor = colorWithRGB(0.62, 0.80, 0.09);
    [headerView2 addSubview:FirstImageView];
    [FirstImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(headerView2.mas_right).offset(-170);
        make.top.mas_equalTo(headerView2.mas_top).offset(40);
        make.width.mas_equalTo(10);
        make.height.mas_equalTo(10);
    }];
    _FirstCircleLabel = [[UILabel alloc]init];
    _FirstCircleLabel.textColor = colorWithRGB(0.53, 0.53, 0.53);
    
    _FirstCircleLabel.textAlignment = NSTextAlignmentLeft;
    _FirstCircleLabel.font = [UIFont systemFontOfSize:12];
    [headerView2 addSubview:_FirstCircleLabel];
    [_FirstCircleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(FirstImageView.mas_centerY);
        make.left.mas_equalTo(FirstImageView.mas_right).offset(5);
        make.width.mas_equalTo(130);
        make.height.mas_equalTo(20);
    }];
    
    UIImageView *SecondImageView = [[UIImageView alloc]init];
    SecondImageView.layer.cornerRadius = 5;
    SecondImageView.clipsToBounds = YES;
    
    SecondImageView.backgroundColor = colorWithRGB(0.99, 0.79, 0.09);
    [headerView2 addSubview:SecondImageView];
    [SecondImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(FirstImageView.mas_centerX);
        make.top.mas_equalTo(FirstImageView.mas_bottom).offset(5);
        make.width.mas_equalTo(10);
        make.height.mas_equalTo(10);
    }];
    _SecondCircleLabel = [[UILabel alloc]init];
    _SecondCircleLabel.textColor = colorWithRGB(0.53, 0.53, 0.53);
    _SecondCircleLabel.textAlignment = NSTextAlignmentLeft;
    _SecondCircleLabel.font = [UIFont systemFontOfSize:12];
    [headerView2 addSubview:_SecondCircleLabel];
    [_SecondCircleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(SecondImageView.mas_centerY);
        make.left.mas_equalTo(SecondImageView.mas_right).offset(5);
        make.width.mas_equalTo(130);
        make.height.mas_equalTo(20);
    }];
    
    UIImageView *ThirdImageView = [[UIImageView alloc]init];
    ThirdImageView.layer.cornerRadius = 5;
    ThirdImageView.clipsToBounds = YES;
    
    ThirdImageView.backgroundColor = colorWithRGB(0.99, 0.52, 0.18);
    [headerView2 addSubview:ThirdImageView];
    [ThirdImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(headerView2.mas_right).offset(-170);
        make.top.mas_equalTo(SecondImageView.mas_bottom).offset(5);
        make.width.mas_equalTo(10);
        make.height.mas_equalTo(10);
    }];
    _ThirdCircleLabel = [[UILabel alloc]init];
    _ThirdCircleLabel.textColor = colorWithRGB(0.53, 0.53, 0.53);
    _ThirdCircleLabel.textAlignment = NSTextAlignmentLeft;
    _ThirdCircleLabel.font = [UIFont systemFontOfSize:12];
    [headerView2 addSubview:_ThirdCircleLabel];
    [_ThirdCircleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(ThirdImageView.mas_centerY);
        make.left.mas_equalTo(ThirdImageView.mas_right).offset(5);
        make.width.mas_equalTo(130);
        make.height.mas_equalTo(20);
    }];
    
    
    UIImageView *FourImageView = [[UIImageView alloc]init];
    FourImageView.layer.cornerRadius = 5;
    FourImageView.clipsToBounds = YES;
    
    FourImageView.backgroundColor = colorWithRGB(0.27, 0.78, 0.96);
    [headerView2 addSubview:FourImageView];
    [FourImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(headerView2.mas_right).offset(-170);
        make.top.mas_equalTo(ThirdImageView.mas_bottom).offset(5);
        make.width.mas_equalTo(10);
        make.height.mas_equalTo(10);
    }];
    _FourCircleLabel = [[UILabel alloc]init];
    _FourCircleLabel.textColor = colorWithRGB(0.53, 0.53, 0.53);
    _FourCircleLabel.textAlignment = NSTextAlignmentLeft;
    _FourCircleLabel.font = [UIFont systemFontOfSize:12];
    [headerView2 addSubview:_FourCircleLabel];
    [_FourCircleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(FourImageView.mas_centerY);
        make.left.mas_equalTo(FourImageView.mas_right).offset(5);
        make.width.mas_equalTo(130);
        make.height.mas_equalTo(20);
    }];
    
//    UIImageView *FiveImageView = [[UIImageView alloc]init];
//    FiveImageView.layer.cornerRadius = 5;
//    FiveImageView.clipsToBounds = YES;
//
//    FiveImageView.backgroundColor = colorWithRGB(0.31, 0.69, 1);
//    [headerView2 addSubview:FiveImageView];
//    [FiveImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(headerView2.mas_right).offset(-170);
//        make.top.mas_equalTo(FourImageView.mas_bottom).offset(5);
//        make.width.mas_equalTo(10);
//        make.height.mas_equalTo(10);
//    }];
//    _FiveCircleLabel = [[UILabel alloc]init];
//    _FiveCircleLabel.textColor = colorWithRGB(0.53, 0.53, 0.53);
//    _FiveCircleLabel.textAlignment = NSTextAlignmentLeft;
//    _FiveCircleLabel.font = [UIFont systemFontOfSize:12];
//    [headerView2 addSubview:_FiveCircleLabel];
//    [_FiveCircleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(FiveImageView.mas_centerY);
//        make.left.mas_equalTo(FiveImageView.mas_right).offset(5);
//        make.width.mas_equalTo(130);
//        make.height.mas_equalTo(20);
//    }];
    
    
    UIImageView *SixImageView = [[UIImageView alloc]init];
    SixImageView.layer.cornerRadius = 5;
    SixImageView.clipsToBounds = YES;
    SixImageView.backgroundColor = colorWithRGB(0.19, 0.39, 0.9);
    [headerView2 addSubview:SixImageView];
    [SixImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(headerView2.mas_right).offset(-170);
        make.top.mas_equalTo(FourImageView.mas_bottom).offset(5);
        make.width.mas_equalTo(10);
        make.height.mas_equalTo(10);
    }];
    _SixCircleLabel = [[UILabel alloc]init];
    _SixCircleLabel.textColor = colorWithRGB(0.53, 0.53, 0.53);
    _SixCircleLabel.textAlignment = NSTextAlignmentLeft;
    _SixCircleLabel.font = [UIFont systemFontOfSize:12];
    [headerView2 addSubview:_SixCircleLabel];
    [_SixCircleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(SixImageView.mas_centerY);
        make.left.mas_equalTo(SixImageView.mas_right).offset(5);
        make.width.mas_equalTo(130);
        make.height.mas_equalTo(20);
    }];
    UIView *ImageLineView  = [[UIView alloc]init];
    ImageLineView.backgroundColor = [UIColor whiteColor];
    [headerView2 addSubview:ImageLineView];
    [ImageLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headerView2.mas_left);
        make.top.mas_equalTo(_SixCircleLabel.mas_bottom).offset(40);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(1);
    }];
    
    
    //昨日收益
    UIView *OldView = [[UIView alloc]init];
    OldView.userInteractionEnabled = YES;
    OldView.backgroundColor = [UIColor whiteColor];
    [headerView2 addSubview:OldView];
    [OldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headerView2.mas_left);
        make.top.mas_equalTo(ImageLineView.mas_bottom).offset(0.5);
        make.width.mas_equalTo(SCREEN_WIDTH/2);
        make.height.mas_equalTo(60);
    }];
    UIView *segeLineView = [[UIView alloc]init];
    segeLineView.backgroundColor = [UIColor whiteColor];
    [headerView2 addSubview:segeLineView];
    [segeLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(OldView.mas_right);
        make.centerY.mas_equalTo(OldView.mas_centerY);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(50);
    }];
    UILabel *OldNamelabel = [[UILabel alloc]init];
    OldNamelabel.text = @"昨日收益";
    OldNamelabel.textAlignment = NSTextAlignmentCenter;
    OldNamelabel.font = [UIFont systemFontOfSize:12];
    OldNamelabel.textColor = colorWithRGB(0.61, 0.61, 0.61);
    [OldView addSubview:OldNamelabel];
    [OldNamelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(OldView.mas_left);
        make.top.mas_equalTo(ImageLineView.mas_bottom).offset(5);
        make.width.mas_equalTo(SCREEN_WIDTH/2);
        make.height.mas_equalTo(20);
    }];
    _OldLabel = [[UILabel alloc]init];
    _OldLabel.textAlignment = NSTextAlignmentCenter;
    _OldLabel.textColor = [UIColor orangeColor];
    _OldLabel.font = [UIFont systemFontOfSize:14];
    [OldView addSubview:_OldLabel];
    [_OldLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(OldNamelabel.mas_left);
        make.top.mas_equalTo(OldNamelabel.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH/2);
        make.height.mas_equalTo(30);
    }];
    _OldDetailLabel = [UIButton buttonWithType:UIButtonTypeCustom];
    [_OldDetailLabel setTitle:@"详情" forState:UIControlStateNormal];
    
    _OldDetailLabel.layer.borderColor = ZFOrange.CGColor;
    _OldDetailLabel.layer.borderWidth = 0.5f;
    _OldDetailLabel.layer.masksToBounds = YES;
    _OldDetailLabel.layer.cornerRadius = 10;
    [_OldDetailLabel setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    _OldDetailLabel.titleLabel.font = [UIFont systemFontOfSize:14];
    [headerView2 addSubview:_OldDetailLabel];
    [_OldDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_OldLabel.mas_centerX);
        make.top.mas_equalTo(_OldLabel.mas_bottom);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(20);
    }];
    
    UIView *AddView = [[UIView alloc]init];
    AddView.userInteractionEnabled = YES;
    AddView.backgroundColor = [UIColor whiteColor];
    [headerView2 addSubview:AddView];
    [AddView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(headerView2.mas_right);
        make.top.mas_equalTo(ImageLineView.mas_bottom).offset(0.5);
        make.width.mas_equalTo(SCREEN_WIDTH/2);
        make.height.mas_equalTo(60);
    }];
    UILabel *AddNamelabel = [[UILabel alloc]init];
    AddNamelabel.textAlignment = NSTextAlignmentCenter;
    AddNamelabel.text = @"累计收益";
    AddNamelabel.font = [UIFont systemFontOfSize:12];
    AddNamelabel.textColor = colorWithRGB(0.61, 0.61, 0.61);
    [AddView addSubview:AddNamelabel];
    [AddNamelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(AddView.mas_left);
        make.top.mas_equalTo(ImageLineView.mas_bottom).offset(5);
        make.width.mas_equalTo(SCREEN_WIDTH/2);
        make.height.mas_equalTo(20);
    }];
    _AddLabel = [[UILabel alloc]init];
    _AddLabel.textAlignment = NSTextAlignmentCenter;
    _AddLabel.textColor = [UIColor orangeColor];
    _AddLabel.font = [UIFont systemFontOfSize:14];
    [AddView addSubview:_AddLabel];
    [_AddLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(AddView.mas_left);
        make.top.mas_equalTo(AddNamelabel.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH/2);
        make.height.mas_equalTo(30);
    }];
    _AddDetailLabel = [[UILabel alloc]init];
    _AddDetailLabel.text = @"详情";
    _AddDetailLabel.userInteractionEnabled = YES;
    _AddDetailLabel.layer.borderColor = ZFOrange.CGColor;
    _AddDetailLabel.layer.borderWidth = 0.5f;
    _AddDetailLabel.layer.masksToBounds = YES;
    _AddDetailLabel.layer.cornerRadius = 10;
    _AddDetailLabel.textAlignment = NSTextAlignmentCenter;
    _AddDetailLabel.textColor = [UIColor orangeColor];
    _AddDetailLabel.font = [UIFont systemFontOfSize:14];
    [headerView2  addSubview:_AddDetailLabel];
    [_AddDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_AddLabel.mas_centerX);
        make.top.mas_equalTo(_AddLabel.mas_bottom);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(20);
    }];
    
    UIImageView *lineView = [[UIImageView alloc]init];
    lineView.backgroundColor = colorWithRGB(0.93, 0.93, 0.93);
    [headerView2 addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_AddDetailLabel.mas_bottom).offset(20);
        make.left.mas_equalTo(headerView2.mas_left);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(5);
    }];
    
    
    _FirstCircleLabel.text =[NSString stringWithFormat:@"网贷基金   %@",[MyDic objectForKey:@"p2pLoanInvestmentAmount"]];
    _SecondCircleLabel.text = [NSString stringWithFormat:@"新手专享   %@",[MyDic objectForKey:@"noviceExclusiveInvestmentAmount"]  ];
    _ThirdCircleLabel.text = [NSString stringWithFormat:@"企业贷款   %@",[MyDic objectForKey:@"enterpriseLoanInvestmentAmount"]];
    _FourCircleLabel.text = [NSString stringWithFormat:@"个人贷款   %@",[MyDic objectForKey:@"personalLoanInvestmentAmount"]];
   // _FiveCircleLabel.text = [NSString stringWithFormat:@"购车贷款   %@",[MyDic objectForKey:@"carLoanInvestmentAmount"]];
    _SixCircleLabel.text =[NSString stringWithFormat:@"债权转让   %@",[MyDic objectForKey:@"debentureTransferInvestmentAmount"]];
    _OldLabel.text = [NSString stringWithFormat:@"¥%.2f",[[MyDic objectForKey:@"yesterdayEarnings"]doubleValue]];
    _AddLabel.text =[NSString stringWithFormat:@"¥%.2f",[[MyDic objectForKey:@"accumulatedEarnings"]doubleValue]];
    
    
    double p2p1 = [[MyDic objectForKey:@"p2pLoanInvestmentAmount"] doubleValue];
    double p2p2 =[[MyDic objectForKey:@"noviceExclusiveInvestmentAmount"] doubleValue];
    double p2p3 =[[MyDic objectForKey:@"enterpriseLoanInvestmentAmount"] doubleValue] ;
    double p2p4 =[[MyDic objectForKey:@"personalLoanInvestmentAmount"] doubleValue];
    //double p2p5 = [_topModel.carLoanInvestmentAmount doubleValue];
    double p2p6 =[[MyDic objectForKey:@"debentureTransferInvestmentAmount"] doubleValue] ;
    double value1; double value2; double value3; double value4;  double value6;
    if (p2p1) {
        value1 = p2p1;
    }else{
        value1 = 0;
        
    }
    
    if (p2p2) {
        value2 = p2p2;
        
    }else{
        value2 =0;
        
    }
    if (p2p3) {
        value3 = p2p3;
        
    }else{
        value3 = 0;
        
    }
    if (p2p4) {
        value4 = p2p4;
        
        
    }else{
        value4 = 0;
        
    }
//    if (p2p5) {
//        value5 = p2p6;
//
//
//    }else{
//        value5 = 0;
//
//    }
    if (p2p6) {
        value6 = p2p6;
        
        
    }else{
        value6 = 0;
        
    }
    _myArray  = [[NSArray alloc]initWithObjects:[NSString stringWithFormat:@"%.2f",value1],[NSString stringWithFormat:@"%.2f",value2],[NSString stringWithFormat:@"%.2f",value3],[NSString stringWithFormat:@"%.2f",value4],[NSString stringWithFormat:@"%.2f",value6], nil];
    
    
    [_pieChart strokePath];
    
    UILabel *TitleLabel = [[UILabel alloc]init];
    TitleLabel.textAlignment = NSTextAlignmentCenter;
    TitleLabel.text = @"在投资产";
    TitleLabel.font = [UIFont systemFontOfSize:15];
    TitleLabel.textColor = colorWithRGB(0.53, 0.53, 0.53);
    [self.pieChart addSubview:TitleLabel];
    [TitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.pieChart.mas_centerX);
        make.top.mas_equalTo(headerView2.mas_top).offset(60);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(15);
    }];
    
    UILabel *MoneyLabel = [[UILabel alloc]init];
    MoneyLabel.textAlignment = NSTextAlignmentCenter;
    if ([[MyDic objectForKey:@"investmentAmount"] integerValue]) {
        MoneyLabel.text =[NSString stringWithFormat:@"%@",[MyDic objectForKey:@"investmentAmount"]];
        
    }else{
        MoneyLabel.text =@"0.0";
        
    }
    MoneyLabel.font = [UIFont systemFontOfSize:16];
    [self.pieChart addSubview:MoneyLabel];
    [MoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(TitleLabel.mas_centerX);
        make.top.mas_equalTo(TitleLabel.mas_bottom).offset(5);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    }];
    [_OldDetailLabel addTarget:self action:@selector(OldTapClick) forControlEvents:UIControlEventTouchUpInside];
    UITapGestureRecognizer *AddDetailLabelTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(AddTapDetail)];
    [_AddDetailLabel addGestureRecognizer:AddDetailLabelTap];
    vc.headerView = headerView2;
    
    return vc;
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
- (void)BuyClick{
    [vc setPageScrollViewMenuSelectPageIndex:4 animated:NO];
    [alertView dismissAnimated:NO];
}
- (void)ChangeClick{
    [vc setPageScrollViewMenuSelectPageIndex:5 animated:NO];
    [alertView dismissAnimated:NO];
}

- (void)AllClick{
    [vc setPageScrollViewMenuSelectPageIndex:6 animated:NO];
    [alertView dismissAnimated:NO];
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

#pragma mark - ZFPieChartDataSource

- (NSArray *)valueArrayInPieChart:(ZFPieChart *)chart{
    if ([[_myArray objectAtIndex:0]integerValue]==0 && [[_myArray objectAtIndex:1]integerValue]==0 && [[_myArray objectAtIndex:2]integerValue]==0 && [[_myArray objectAtIndex:3]integerValue]==0 &&[[_myArray objectAtIndex:4]integerValue]==0) {

        return @[@"100"];
    }else{
        return _myArray;

    }
//    NSLog(@"arr== %@",_myArray);
//    return _myArray;
}

- (NSArray *)colorArrayInPieChart:(ZFPieChart *)chart{
    
    if ([[_myArray objectAtIndex:0]integerValue]==0 && [[_myArray objectAtIndex:1]integerValue]==0 && [[_myArray objectAtIndex:2]integerValue]==0 && [[_myArray objectAtIndex:3]integerValue]==0 &&[[_myArray objectAtIndex:4]integerValue]==0) {
        return @[colorWithRGB(0.83, 0.83, 0.83)];
    }else{
        return @[colorWithRGB(0.62, 0.80, 0.09),colorWithRGB(0.99, 0.79, 0.09), colorWithRGB(0.99, 0.52, 0.18), colorWithRGB(0.31, 0.69, 1), colorWithRGB(0.27, 0.78, 0.96), colorWithRGB(0.19, 0.39, 0.9)];
    }
   
//      return @[colorWithRGB(0.62, 0.80, 0.09),colorWithRGB(0.99, 0.79, 0.09), colorWithRGB(0.99, 0.52, 0.18), colorWithRGB(0.31, 0.69, 1), colorWithRGB(0.19, 0.39, 0.9)];
}

#pragma mark - ZFPieChartDelegate

- (void)pieChart:(ZFPieChart *)pieChart didSelectPathAtIndex:(NSInteger)index{
    NSLog(@"第%ld个",(long)index);
}

- (CGFloat)allowToShowMinLimitPercent:(ZFPieChart *)pieChart{
    return 5.f;
}

- (CGFloat)radiusForPieChart:(ZFPieChart *)pieChart{
    return 80.f;
}

/** 此方法只对圆环类型(kPieChartPatternTypeForCirque)有效 */
- (CGFloat)radiusAverageNumberOfSegments:(ZFPieChart *)pieChart{
    return 2.f;
}

- (void)viewWillAppear:(BOOL)animated {
    NSString *typeStr =  NSuserUse(@"change");
    switch ([typeStr integerValue]) {
        case 1:
            [self BusClick];
            break;
            
        default:
            break;
    }
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


- (void)OldTapClick{
    OldProfitViewController * oldVC  = [[OldProfitViewController alloc]init];
    [self.navigationController pushViewController:oldVC animated:NO];
}
- (void)AddTapDetail{
    AddProfitViewController * oldVC  = [[AddProfitViewController alloc]init];
    [self.navigationController pushViewController:oldVC animated:NO];
}
//昨日收益
- (void)OldTap{
    OldProfitViewController * oldVC  = [[OldProfitViewController alloc]init];
    [self.navigationController pushViewController:oldVC animated:NO];
}
//累计收益
- (void)AddTap{
    AddProfitViewController * oldVC  = [[AddProfitViewController alloc]init];
    [self.navigationController pushViewController:oldVC animated:NO];
    
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
