//
//  MessageViewController.m
//  milier
//
//  Created by amin on 2017/12/7.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "MessageViewController.h"
#import <WebKit/WebKit.h>

@interface MessageViewController ()<WKUIDelegate>{
    WKWebView *ActivityWebView;
    MBProgressHUD *hud;
}

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"消息";
    self.view.backgroundColor = colorWithRGB(0.97, 0.97, 0.97);
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(0, 0, 44, 44);
    [leftBtn setImage:[UIImage imageNamed:@"backarrow"] forState:UIControlStateNormal];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0,0,0,8 *SCREEN_WIDTH/375.0)];
    [leftBtn addTarget:self action:@selector(messageTap) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    NSString *userID = NSuserUse(@"userId");
    ActivityWebView  = [[WKWebView alloc]init];
    ActivityWebView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64);
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/news/message.html?userId=%@",HOST_URL,userID]]];
    NSLog(@"url== %@",[NSString stringWithFormat:@"%@/news/message.html?userId=%@",HOST_URL,userID]);
    [self.view addSubview:ActivityWebView];
    // ActivityWebView.scalesPageToFit  = YES;
    [ActivityWebView loadRequest:request];
    
    
    
}
- (void)messageTap{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSLog(@"REQUEST.URL = %@",request.URL);
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    // NSLog(@"webView start load");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    // NSLog(@"webview fail load");
    [webView sizeToFit];
}
- (void)HideProgress{
    [hud hideAnimated:YES afterDelay:1.f];
}
- (void)showProgress{
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    // Set the label text.
    
    hud.label.text = NSLocalizedString(@"正在请求中", @"HUD loading title");
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
