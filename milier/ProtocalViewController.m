//
//  ProtocalViewController.m
//  YWD
//
//  Created by 007 on 15/11/9.
//  Copyright © 2015年 star. All rights reserved.
//

#import "ProtocalViewController.h"
#import "YWDReginViewController.h"

@interface ProtocalViewController ()

@end

@implementation ProtocalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.TopView.hidden = NO;
    self.view.backgroundColor = colorWithRGB(0.94, 0.94, 0.94);
    
    self.TopTitleLabel.text = @"隐私协议";
    [self.BackButton addTarget:self action:@selector(protocalBackClick) forControlEvents:UIControlEventTouchUpInside];
    
    AboutSafeWebView  = [[UIWebView alloc]init];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.yiwudai.com/mobile/webview/legal.html"]];
    AboutSafeWebView.delegate= self;
    [self.view addSubview:AboutSafeWebView];
    [AboutSafeWebView loadRequest:request];
    
    [AboutSafeWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self.TopView.mas_bottom);
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];

    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
    [super viewWillDisappear:animated];
}
- (void)safeCallBackClick{
    [self.navigationController popToRootViewControllerAnimated:NO];
    
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    // NSLog(@"REQUEST.URL = %@",request.URL);
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
}


- (void)protocalBackClick{
    //  返回指定页面
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[YWDReginViewController class]]) {
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
