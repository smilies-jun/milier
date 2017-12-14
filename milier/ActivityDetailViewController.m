//
//  ActivityDetailViewController.m
//  milier
//
//  Created by amin on 2017/5/16.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "ActivityDetailViewController.h"
#import "FirstViewController.h"
#import "ProductDetailNewViewController.h"
#import "YWDLoginViewController.h"
#import "SecondViewController.h"
#import "ReginAndLoginViewController.h"
#import "ActivityRefinViewController.h"
#import <WebKit/WebKit.h>
#import "YWDLoginViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>

@interface ActivityDetailViewController ()<WKUIDelegate>{
    WKWebView *ActivityWebView;
    MBProgressHUD *hud;
    UILabel *SaleLbel;
    NSDictionary *MyDIC;
    NSDictionary *ShareDic;
    
}

@end

@implementation ActivityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = _TitleStr;
    self.view.backgroundColor = colorWithRGB(0.97, 0.97, 0.97);
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(0, 0, 44, 44);
    [leftBtn setImage:[UIImage imageNamed:@"backarrow"] forState:UIControlStateNormal];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0,0,0,8 *SCREEN_WIDTH/375.0)];
    [leftBtn addTarget:self action:@selector(ActivityDetailTap) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    MyDIC = [[NSDictionary alloc]init];
    ShareDic = [[NSDictionary alloc]init];
    [self showProgress];
  

  
    //可以滑动的按钮
//    RCDraggableButton *avatar = [[RCDraggableButton alloc] initInKeyWindowWithFrame:CGRectMake(0, 100, 100, 100)];
//    [avatar setTitle:@"登陆领取" forState:UIControlStateNormal];
//    [avatar setImage:[UIImage imageNamed:@"Icon-60"] forState:UIControlStateNormal];
//    [self.view addSubview:avatar];
}


-(void)configUi{
    
    if ([[MyDIC objectForKey:@"state"]integerValue] ==1) {
        ActivityWebView  = [[WKWebView alloc]init];
        ActivityWebView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-60);
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_WebStr]]];
        [self.view addSubview:ActivityWebView];
        // ActivityWebView.scalesPageToFit  = YES;
        [ActivityWebView loadRequest:request];
        UIView *saleView = [[UIView alloc]init];
        saleView.backgroundColor = [UIColor whiteColor];
        saleView.frame = CGRectMake(0, SCREEN_HEIGHT - 64-60, SCREEN_WIDTH, 60);
        [self.view addSubview:saleView];
        SaleLbel =  [[UILabel alloc]init];
         SaleLbel.text = [NSString stringWithFormat:@"%@",[MyDIC objectForKey:@"introduction"]];
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
        
        UITapGestureRecognizer *SaleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ActiveClick
                                                                                                              )];
        [SaleLbel addGestureRecognizer:SaleTap];
        [self HideProgress];
    }else if ([[MyDIC objectForKey:@"state"]integerValue] ==2){
        ActivityWebView  = [[WKWebView alloc]init];
        ActivityWebView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-60);
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_WebStr]]];
        [self.view addSubview:ActivityWebView];
        // ActivityWebView.scalesPageToFit  = YES;
        [ActivityWebView loadRequest:request];
        UIView *saleView = [[UIView alloc]init];
        saleView.backgroundColor = [UIColor whiteColor];
        saleView.frame = CGRectMake(0, SCREEN_HEIGHT - 64-60, SCREEN_WIDTH, 60);
        [self.view addSubview:saleView];
        SaleLbel =  [[UILabel alloc]init];
        SaleLbel.text = [NSString stringWithFormat:@"%@",[MyDIC objectForKey:@"introduction"]];
        SaleLbel.userInteractionEnabled = YES;
        SaleLbel.backgroundColor = colorWithRGB(0.85, 0.85, 0.85);
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
        [self HideProgress];
//        UITapGestureRecognizer *SaleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ActiveClick
//                                                                                                              )];
//        [SaleLbel addGestureRecognizer:SaleTap];
    }else{
        ActivityWebView  = [[WKWebView alloc]init];
        ActivityWebView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64);
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_WebStr]]];
        [self.view addSubview:ActivityWebView];
        // ActivityWebView.scalesPageToFit  = YES;
        [ActivityWebView loadRequest:request];
        [self HideProgress];
    }
    
    
}
//领取
- (void)ActiveClick{
    if ([[MyDIC objectForKey:@"type"]integerValue] ==1) {
        [self.navigationController popToRootViewControllerAnimated:YES];
        switch ([[MyDIC objectForKey:@"productid"]integerValue]) {
            case 1:
                 NSuserSave(@"1", @"qiye");
                break;
            case 2:
                NSuserSave(@"2", @"qiye");
                break;
            case 3:
                NSuserSave(@"3", @"qiye");
                break;
            case 4:
                NSuserSave(@"4", @"qiye");
                break;
            case 6:
                NSuserSave(@"5", @"qiye");
//            case 6:
//                NSuserSave(@"6", @"qiye");
//                break;
            default:
                break;
        }
        
        [self.rdv_tabBarController setSelectedIndex:0];
        [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    }else if ([[MyDIC objectForKey:@"type"]integerValue] ==3){
        NSString *url;
        NSString *tokenID = NSuserUse(@"Authorization");
        url = [NSString stringWithFormat:@"%@/props/activity/receiveProps",HOST_URL];
        
        [[DateSource sharedInstance]requestHomeWithParameters:nil  withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
               //领取成功
            if ([[result objectForKey:@"statusCode"]integerValue] ==201) {
                NSString *sucessStr = [NSString stringWithFormat:@"%@",[result objectForKey:@"message"]];
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示"
                                                                                             message:sucessStr
                                                                                      preferredStyle:UIAlertControllerStyleAlert ];
                    
                    //添加取消到UIAlertController中
                    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
                    [alertController addAction:cancelAction];
                    
                    //添加确定到UIAlertController中
                    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        SaleLbel.text = @"今日已领取";
                        SaleLbel.backgroundColor = colorWithRGB(0.85, 0.85, 0.85);
                        
                    }];
                    [alertController addAction:OKAction];
                    [self presentViewController:alertController animated:YES completion:nil];
                
            }else{
                 normal_alert(@"提示",@"领取失败", @"确定");
            }
            
            
        }];
    }else if ([[MyDIC objectForKey:@"type"]integerValue] ==0){
        YWDLoginViewController *loginVC = [[YWDLoginViewController alloc] init];
        UINavigationController *loginNagition = [[UINavigationController alloc]initWithRootViewController:loginVC];
        loginNagition.navigationBarHidden = YES;
        [self presentViewController:loginNagition animated:NO completion:nil];
    }else{
        [self shareClick];
    }
    
   
}
- (void)shareClick{
    NSString *Shareurl;
    Shareurl = [NSString stringWithFormat:@"%@/tools/shareMessage",HOST_URL];
    
    [[DateSource sharedInstance]requestHtml5WithParameters:nil withUrl:Shareurl withTokenStr:nil usingBlock:^(NSDictionary *result, NSError *error) {
        NSString *State = [result objectForKey:@"statusCode"];
        if ([State integerValue] == 200) {
            ShareDic = [result objectForKey:@"data"];
            [self shareMyUi];
        }
    }];
}
- (void)shareMyUi{
    //先构造分享参数：
    NSString *userID = NSuserUse(@"userId");
    NSString *Url;
    if ([userID integerValue] >0) {
        Url = [NSString stringWithFormat:@"%@?userId=%@",[ShareDic objectForKey:@"url"],userID];
    }else{
        Url = [NSString stringWithFormat:@"%@",[ShareDic objectForKey:@"url"]];
    }
    
    
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:[ShareDic objectForKey:@"content"]
                                     images:[NSString stringWithFormat:@"%@",[ShareDic objectForKey:@"image"]]
                                        url:[NSURL URLWithString:Url]
                                      title:[ShareDic objectForKey:@"title"]
                                       type:SSDKContentTypeAuto];
    //有的平台要客户端
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
    // [sheet.directSharePlatforms addObject:@(SSDKPlatformTypeSinaWeibo)];//（加了这个方法之后可以不跳分享编辑界面，直接点击分享菜单里的选项，直接分享）
    
}
- (void)getActivity{
    NSString *url;
    NSString *tokenID = NSuserUse(@"Authorization");
    url = [NSString stringWithFormat:@"%@/activities/%@/isButton",HOST_URL,_activioid];
    [[DateSource sharedInstance]requestHtml5WithParameters:nil  withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
        
        MyDIC = result;
        [self configUi];
        
    }];
}
- (void)HideProgress{
     [hud hideAnimated:YES afterDelay:2.f];
}
- (void)showProgress{
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    // Set the label text.
    hud.label.text = NSLocalizedString(@"正在请求中", @"HUD loading title");
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
     NSLog(@"REQUEST.URL = %@",request.URL);
    NSString *urlStr = [NSString stringWithFormat:@"%@",request.URL];
    NSString *strRegin = @"https://weixin.milibanking.com/weixin/weixin/login/toRegister";
    NSString *strSale1 = @"https://weixin.milibanking.com/weixin/weixin/product/productList?productId=1";
    NSString *strSale2 = @"https://weixin.milibanking.com/weixin/weixin/product/productList?productId=2";
    NSString *strSale3 = @"https://weixin.milibanking.com/weixin/weixin/product/productList?productId=3";

    NSString *strSale4 = @"https://weixin.milibanking.com/weixin/weixin/product/productList?productId=4";

    NSString *strSale5 = @"https://weixin.milibanking.com/weixin/weixin/product/productList?productId=5";

    NSString *strSale6 = @"https://weixin.milibanking.com/weixin/weixin/product/productList?productId=6";

    if ([urlStr containsString:strRegin]) {
        ActivityRefinViewController *reVC= [[ActivityRefinViewController alloc]init];
        reVC.type = @"1";
        [self.navigationController pushViewController:reVC animated:NO];
    }else if ([urlStr containsString:strSale1]){
        NSuserSave(@"2", @"qiye");
        [self.navigationController popToRootViewControllerAnimated:YES];
        [self.rdv_tabBarController setSelectedIndex:0];
        [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    }else if ([urlStr containsString:strSale2]){
          NSuserSave(@"5", @"qiye");
        [self.navigationController popToRootViewControllerAnimated:YES];
        [self.rdv_tabBarController setSelectedIndex:0];
        [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    }else if ([urlStr containsString:strSale3]){
          NSuserSave(@"1", @"qiye");
        [self.navigationController popToRootViewControllerAnimated:YES];
        [self.rdv_tabBarController setSelectedIndex:0];
        [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    }else if ([urlStr containsString:strSale4]){
          NSuserSave(@"4", @"qiye");
        [self.navigationController popToRootViewControllerAnimated:YES];
        [self.rdv_tabBarController setSelectedIndex:0];
        [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    }else if ([urlStr containsString:strSale5]){
          NSuserSave(@"3", @"qiye");
        [self.navigationController popToRootViewControllerAnimated:YES];
        [self.rdv_tabBarController setSelectedIndex:0];
        [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    }else if ([urlStr containsString:strSale6]){
          NSuserSave(@"6", @"qiye");
        [self.navigationController popToRootViewControllerAnimated:YES];
        [self.rdv_tabBarController setSelectedIndex:0];
        [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    }
    
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    // NSLog(@"webView start load");
    [self showProgress];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
  //  [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [self HideProgress];
  //  [webView sizeToFit];

}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    // NSLog(@"webview fail load");
}
- (void)ActivityDetailTap{
    
   // [self.navigationController popToRootViewControllerAnimated:NO];
    //  返回指定页面
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[FirstViewController  class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
    
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[SecondViewController  class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[ProductDetailNewViewController   class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
      [self getActivity];
    
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
