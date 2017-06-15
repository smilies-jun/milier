//
//  BundProfileViewController.m
//  milier
//
//  Created by amin on 2017/6/11.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "BundProfileViewController.h"
#import "BundCardViewController.h"
#import "ProductDetailNewViewController.h"
#import "SaleViewController.h"
#import "MoreHelpViewController.h"
#import "DinQiDeatilViewController.h"


@interface BundProfileViewController ()<UIWebViewDelegate>{
    UIWebView *ActivityWebView;
}

@end

@implementation BundProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = _TitleStr;
    self.view.backgroundColor = colorWithRGB(0.97, 0.97, 0.97);
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(0, 7, 18, 18);
    [leftBtn setImage:[UIImage imageNamed:@"backarrow@2x.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(BundDetailTap) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
        ActivityWebView  = [[UIWebView alloc]init];
    ActivityWebView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);

        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_WebStr]]];
        ActivityWebView.delegate= self;
        [self.view addSubview:ActivityWebView];
        [ActivityWebView loadRequest:request];
//        [ActivityWebView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(self.view.mas_left);
//            make.top.mas_equalTo(self.view.mas_top);
//            make.width.mas_equalTo(SCREEN_WIDTH);
//            make.bottom.mas_equalTo(SCREEN_HEIGHT - 64 - 44);
//        }];
 

    
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
        //  返回指定页面
  
    if ([_WebTypeStr integerValue] == 1) {
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[ProductDetailNewViewController  class]]) {
                [self.navigationController popToViewController:controller animated:YES];
            }
        }
 
    }else{
        
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[BundCardViewController  class]]) {
                [self.navigationController popToViewController:controller animated:YES];
            }
        }
        
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[SaleViewController class]]) {
                [self.navigationController popToViewController:controller animated:YES];
            }
        }
        
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[MoreHelpViewController class]]) {
                [self.navigationController popToViewController:controller animated:YES];
            }
        }
        
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[DinQiDeatilViewController class]]) {
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
