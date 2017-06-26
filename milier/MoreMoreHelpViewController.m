//
//  MoreMoreHelpViewController.m
//  milier
//
//  Created by amin on 2017/6/12.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "MoreMoreHelpViewController.h"
#import "MoreHelpViewController.h"
#import "NewPersonViewController.h"

@interface MoreMoreHelpViewController ()<UIWebViewDelegate>{
    UIWebView *ActivityWebView;
}


@end

@implementation MoreMoreHelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = _TitleStr;
    self.view.backgroundColor = colorWithRGB(0.93, 0.93, 0.93);
      [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor blackColor]}];
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(0, 7, 18, 18);
    [leftBtn setImage:[UIImage imageNamed:@"backarrow@2x.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(BundDetailTap) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    ActivityWebView  = [[UIWebView alloc]init];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_WebStr]]];
    ActivityWebView.delegate= self;
    ActivityWebView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.view addSubview:ActivityWebView];
    [ActivityWebView loadRequest:request];
    
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
}
- (void)BundDetailTap{
    if ([_type integerValue] == 4) {
        //  返回指定页面
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[NewPersonViewController class]]) {
                [self.navigationController popToViewController:controller animated:YES];
            }
        }

    }else{
        //  返回指定页面
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[MoreHelpViewController class]]) {
                [self.navigationController popToViewController:controller animated:YES];
            }
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
