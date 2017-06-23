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


@interface ActivityDetailViewController ()<UIWebViewDelegate>{
    UIWebView *ActivityWebView;
}

@end

@implementation ActivityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = _TitleStr;
    self.view.backgroundColor = colorWithRGB(0.97, 0.97, 0.97);
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(0, 7, 18, 18);
    [leftBtn setImage:[UIImage imageNamed:@"backarrow@2x.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(ActivityDetailTap) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    ActivityWebView  = [[UIWebView alloc]init];
    ActivityWebView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64);
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_WebStr]]];
    ActivityWebView.delegate= self;
    [self.view addSubview:ActivityWebView];
   // ActivityWebView.scalesPageToFit  = YES;
    [ActivityWebView loadRequest:request];

   

}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
     NSLog(@"REQUEST.URL = %@",request.URL);
    NSString *urlStr = [NSString stringWithFormat:@"%@",request.URL];
    NSString *strRegin = @"http://weixin.milibanking.com/weixin/weixin/login/toRegister";
    NSString *strSale = @"http://weixin.milibanking.com/weixin/weixin/product/productList";
    if ([urlStr containsString:strRegin]) {
        ActivityRefinViewController *reVC= [[ActivityRefinViewController alloc]init];
        reVC.type = @"1";
        [self.navigationController pushViewController:reVC animated:YES];
    }else if ([urlStr containsString:strSale]){
        [self.tabBarController setSelectedIndex:0];
    }
    
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    // NSLog(@"webView start load");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
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
