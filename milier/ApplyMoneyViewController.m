//
//  ApplyMoneyViewController.m
//  milier
//
//  Created by amin on 2018/3/26.
//  Copyright © 2018年 yj. All rights reserved.
//

#import "ApplyMoneyViewController.h"
#import <WebKit/WebKit.h>
#import "ThirdViewController.h"
#import "ApplyAllMoneyViewController.h"
#import "YWDLoginViewController.h"
#import "YNPageScrollViewController.h"
#import "SDCycleScrollView.h"
#import "AllMoneyViewController.h"
#import "SepartViewController.h"
#import "OutViewController.h"
#import "AutoScrollLabel.h"
#import "HelpMoneyViewController.h"


@interface ApplyMoneyViewController ()<WKNavigationDelegate, WKUIDelegate>{
    NSDictionary    *MyDic;
}@property (strong, nonatomic) WKWebView *webView;

@end

@implementation ApplyMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"全民理财师";
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor blackColor]}];
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(0, 7, 18, 18);
    [leftBtn setImage:[UIImage imageNamed:@"backarrow@2x.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(HelpAllTap) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    [self.view addSubview:_webView];
    
    
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://csapp1.milibanking.com/app/agent/index.html"]]];
    
    UIView *saleView = [[UIView alloc]init];
    saleView.backgroundColor = [UIColor whiteColor];
    saleView.frame = CGRectMake(0, SCREEN_HEIGHT - 60, SCREEN_WIDTH, 60);
    [self.view addSubview:saleView];
    UILabel *SaleLbel =  [[UILabel alloc]init];
    SaleLbel.text = @"立即申请";
    SaleLbel.userInteractionEnabled = YES;
    SaleLbel.backgroundColor = colorWithRGB(0.95, 0.60, 0.11);
    SaleLbel.textAlignment = NSTextAlignmentCenter;
    SaleLbel.textColor = [UIColor whiteColor];
    SaleLbel.layer.cornerRadius = 20;
    SaleLbel.layer.masksToBounds = YES;
    [saleView addSubview:SaleLbel];
    [SaleLbel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(saleView.mas_left).offset(40);
        make.centerY.mas_equalTo(saleView.mas_centerY);
        make.width.mas_equalTo(SCREEN_WIDTH-80);
        make.height.mas_equalTo(40);
    }];
    UITapGestureRecognizer *SaleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ApplyClick
                                                                                                          )];
    [SaleLbel addGestureRecognizer:SaleTap];
    
}
- (void)ApplyClick{
     NSString *userID = NSuserUse(@"userId");
        NSString *url = [NSString stringWithFormat:@"%@/users/%@/type",HOST_URL,userID];
            NSString *tokenID = NSuserUse(@"Authorization");
        [[DateSource sharedInstance]requestHtml5WithParameters:nil withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
            NSLog(@"re == %@",result);
            if ([[result objectForKey:@"statusCode"]integerValue]==200) {
                if ([[result objectForKey:@"type"]integerValue] == 0) {
                    ApplyAllMoneyViewController *vc = [[ApplyAllMoneyViewController alloc]init];
                    [self.navigationController   pushViewController:vc animated:NO];
    
                }else if ([[result objectForKey:@"type"]integerValue] == 1){
                    NSString *urlType = [NSString stringWithFormat:@"%@/brokers/%@",HOST_URL,userID];
                    [[DateSource sharedInstance]requestHtml5WithParameters:nil withUrl:urlType withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
                        if ([[result objectForKey:@"statusCode"]integerValue] == 200) {
                            MyDic = [result objectForKey:@"data"];
                            UIViewController *allvc = nil;
                            allvc = [self getAllMoneyViewController];
                            [self.navigationController   pushViewController:allvc animated:NO];
                        }else{
    
                        }
                    }];
    
                }else{
                    normal_alert(@"提示", @"合约渠道用户不能成为全民理财师", @"确定");
                }
    
            }else{
                YWDLoginViewController *loginVC = [[YWDLoginViewController alloc] init];
                UINavigationController *loginNagition = [[UINavigationController alloc]initWithRootViewController:loginVC];
                loginNagition.navigationBarHidden = YES;
                [self presentViewController:loginNagition animated:NO completion:nil];
    
            }
    
                }];
    
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
    //configration.showConver = YES;
    //configration.converColor = colorWithRGB(1,0.87, 0.01);
    //设置平分不滚动   默认会居中
    // configration.aligmentModeCenter = YES;
    //configration.showScrollLine = NO;
    configration.scrollMenu = YES;
    configration.showGradientColor = NO;//取消渐变
    configration.showNavigation = YES;
    configration.showTabbar = YES;//设置显示tabbar
    configration.showPersonTab = YES;
    
    AllMoneyViewController *vc = [AllMoneyViewController pageScrollViewControllerWithControllers:[self getViewController] titles:@[@"分成列表",@"转出记录"] Configration:configration];
    // 头部是否能伸缩效果   要伸缩效果就不要有下拉刷新控件 默认NO*/
    vc.HeaderViewCouldScale = YES;
    
    
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 270)];
    imageView.backgroundColor = colorWithRGB(1, 0.87, 0.25);
    imageView.userInteractionEnabled = YES;
    UIImageView *TopImageView = [[UIImageView alloc]init];
    TopImageView.image = [UIImage imageNamed:@"licaishipic"];
    TopImageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 160);
    [imageView addSubview:TopImageView];
    
    AutoScrollLabel *autoScrollLabel = [[AutoScrollLabel alloc]initWithFrame:CGRectMake(0, 160, SCREEN_WIDTH, 40)];
    autoScrollLabel.backgroundColor = [UIColor whiteColor];
    autoScrollLabel.text = @"Hi Mom!  How are you?  I really ought to write more often.";
    autoScrollLabel.textColor = [UIColor blackColor];
    [imageView addSubview:autoScrollLabel];
    
    UILabel *MyScorLabel = [[UILabel alloc]init];
    if ( [[MyDic objectForKey:@"totalIncome"]doubleValue]) {
        MyScorLabel.text =[NSString stringWithFormat:@"我的总分成:%.2f元", [[MyDic objectForKey:@"totalIncome"]floatValue]];
    }else{
        MyScorLabel.text =[NSString stringWithFormat:@"我的总分成:0元"];
        
    }
    MyScorLabel.font = [UIFont systemFontOfSize:14];
    [imageView addSubview:MyScorLabel];
    [MyScorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView.mas_left).offset(10);
        make.top.mas_equalTo(autoScrollLabel.mas_bottom).offset(5);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(20);
    }];
    
    UILabel *DetailLabel = [[UILabel alloc]init];
    DetailLabel.text = @"全民理财师，躺着把钱赚";
    DetailLabel.font = [UIFont systemFontOfSize:14];
    DetailLabel.textAlignment = NSTextAlignmentRight;
    [imageView addSubview:DetailLabel];
    [DetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(imageView.mas_right).offset(-10);
        make.top.mas_equalTo(autoScrollLabel.mas_bottom).offset(5);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(20);
    }];
    UILabel *myMoneyLabel = [[UILabel alloc]init];
    myMoneyLabel.backgroundColor = [UIColor whiteColor];
    if ([[MyDic objectForKey:@"assets"]doubleValue]) {
        myMoneyLabel.text =[NSString stringWithFormat:@" 我的分成余额:%.2f元", [[MyDic objectForKey:@"assets"]floatValue]];
        
    }else{
        myMoneyLabel.text =[NSString stringWithFormat:@"  我的分成余额:0元"];
        
    }
    myMoneyLabel.font = [UIFont systemFontOfSize:14];
    [imageView addSubview:myMoneyLabel];
    [myMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView.mas_left);
        make.top.mas_equalTo(MyScorLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(40);
    }];
    
    UIImageView *helpImageView = [[UIImageView alloc]init];
    helpImageView.image = [UIImage imageNamed:@"help_lcs"];
    helpImageView.userInteractionEnabled = YES;
    [imageView addSubview:helpImageView];
    [helpImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(imageView.mas_right).offset(-80);
        make.top.mas_equalTo(MyScorLabel.mas_bottom).offset(20);
        make.width.mas_equalTo(17);
        make.height.mas_equalTo(17);
    }];
    UITapGestureRecognizer *imageTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(helpClick)];
    [helpImageView addGestureRecognizer:imageTap];
    
    UILabel *helpLabel = [[UILabel alloc]init];
    helpLabel.text = @"帮助";
    [imageView addSubview:helpLabel];
    [helpLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(helpImageView.mas_right);
        make.top.mas_equalTo(MyScorLabel.mas_bottom).offset(20);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(17);
    }];
    
    //里面有默认高度 等ScrollView的高度 //里面设置了背景颜色与tableview相同
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0)];
    
    
    vc.pageIndex = 0;
    vc.placeHoderView = footerView;
    vc.headerView = imageView;
    vc.dataSource = self;
    
    return vc;
    
}
- (void)helpClick{
    HelpMoneyViewController  *MoreVC = [[HelpMoneyViewController alloc]init];
    [self presentViewController:MoreVC animated:YES completion:nil];
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

- (void)HelpAllTap{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
#pragma mark - WKNavigationDelegate

/**
 *  页面开始加载时调用
 *
 *  @param webView    实现该代理的webview
 *  @param navigation 当前navigation
 */
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    
    NSLog(@"%s", __FUNCTION__);
}

/**
 *  当内容开始返回时调用
 *
 *  @param webView    实现该代理的webview
 *  @param navigation 当前navigation
 */
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    
    NSLog(@"%s", __FUNCTION__);
}

/**
 *  页面加载完成之后调用
 *
 *  @param webView    实现该代理的webview
 *  @param navigation 当前navigation
 */
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    NSLog(@"%s", __FUNCTION__);
}

/**
 *  加载失败时调用
 *
 *  @param webView    实现该代理的webview
 *  @param navigation 当前navigation
 *  @param error      错误
 */
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    
    NSLog(@"%s", __FUNCTION__);
}

/**
 *  接收到服务器跳转请求之后调用
 *
 *  @param webView      实现该代理的webview
 *  @param navigation   当前navigation
 */
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    
    NSLog(@"%s", __FUNCTION__);
}

/**
 *  在收到响应后，决定是否跳转
 *
 *  @param webView            实现该代理的webview
 *  @param navigationResponse 当前navigation
 *  @param decisionHandler    是否跳转block
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    NSLog(@"url ==%@",navigationResponse.response.URL.host.lowercaseString);
    // 如果响应的地址是百度，则允许跳转
    if ([navigationResponse.response.URL.host.lowercaseString isEqual:@"csapp1.milibanking.com"]) {
        
        // 允许跳转
        decisionHandler(WKNavigationResponsePolicyAllow);
        return;
    }
    // 不允许跳转
    decisionHandler(WKNavigationResponsePolicyCancel);
}

/**
 *  在发送请求之前，决定是否跳转
 *
 *  @param webView          实现该代理的webview
 *  @param navigationAction 当前navigation
 *  @param decisionHandler  是否调转block
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSLog(@"url2222 ==%@",navigationAction.request.URL.host.lowercaseString);
    // 如果请求的是百度地址，则延迟5s以后跳转
    if ([navigationAction.request.URL.host.lowercaseString isEqual:@"csapp1.milibanking.com"]) {
        
        //        // 延迟5s之后跳转
        //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //
        //            // 允许跳转
        //            decisionHandler(WKNavigationActionPolicyAllow);
        //        });
        
        // 允许跳转
        decisionHandler(WKNavigationActionPolicyAllow);
        return;
    }
    // 不允许跳转
    decisionHandler(WKNavigationActionPolicyCancel);
}
- (void)viewWillAppear:(BOOL)animated {
    NSString *userID = NSuserUse(@"userId");
    NSString *url = [NSString stringWithFormat:@"%@/users/%@/type",HOST_URL,userID];
    NSString *tokenID = NSuserUse(@"Authorization");
    
    if ([userID integerValue]) {
        [[DateSource sharedInstance]requestHtml5WithParameters:nil withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
            if ([[result objectForKey:@"statusCode"]integerValue]==200) {
                NSLog(@"re == %@",result);
                if ([[result objectForKey:@"type"]integerValue] == 0) {
                    ApplyAllMoneyViewController *vc = [[ApplyAllMoneyViewController alloc]init];
                    [self.navigationController   pushViewController:vc animated:NO];
                    
                }else if ([[result objectForKey:@"type"]integerValue] == 1){
                    NSString *urlType = [NSString stringWithFormat:@"%@/brokers/%@",HOST_URL,userID];
                    [[DateSource sharedInstance]requestHtml5WithParameters:nil withUrl:urlType withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
                        if ([[result objectForKey:@"statusCode"]integerValue] == 200) {
                            MyDic = [result objectForKey:@"data"];
                            UIViewController *allvc = nil;
                            allvc = [self getAllMoneyViewController];
                            [self.navigationController   pushViewController:allvc animated:NO];
                        }else{
                            
                        }
                    }];
                    
                }else{
                    normal_alert(@"提示", @"合约渠道用户不能成为全民理财师", @"确定");
                }
                
            }else{
                //            YWDLoginViewController *loginVC = [[YWDLoginViewController alloc] init];
                //            UINavigationController *loginNagition = [[UINavigationController alloc]initWithRootViewController:loginVC];
                //            loginNagition.navigationBarHidden = YES;
                //            [self presentViewController:loginNagition animated:NO completion:nil];
                
            }
            
        }];
    }
   
    
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
