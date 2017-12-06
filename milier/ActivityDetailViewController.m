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

@interface ActivityDetailViewController ()<WKUIDelegate>{
    WKWebView *ActivityWebView;
    MBProgressHUD *hud;
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
    
    ActivityWebView  = [[WKWebView alloc]init];
    ActivityWebView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64);
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_WebStr]]];
    [self.view addSubview:ActivityWebView];
   // ActivityWebView.scalesPageToFit  = YES;
    [ActivityWebView loadRequest:request];

   

}
- (void)HideProgress{
     [hud hideAnimated:YES afterDelay:1.f];
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
