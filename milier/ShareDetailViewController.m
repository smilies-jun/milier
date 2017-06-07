//
//  ShareDetailViewController.m
//  milier
//
//  Created by amin on 2017/5/16.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "ShareDetailViewController.h"
#import "ShareViewController.h"


@interface ShareDetailViewController ()

@end

@implementation ShareDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"分享详细规则";
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
    
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(0, 7, 18, 18);
    [leftBtn setImage:[UIImage imageNamed:@"backarrow@2x.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(ShareDetail) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.view.backgroundColor = colorWithRGB(0.93, 0.93, 0.93);
    UILabel *label = [[UILabel alloc]init];
    label.text = @"1、邀请好友成功绑卡，奖励最高800元小米券1张\n2、根据好友投资额度，奖励邀请积分，多投多得哦，积分=(好友投资金额*投资期限)／1000";
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:13];
    label.frame = CGRectMake(10, 20, SCREEN_WIDTH- 20, 60);
    [self.view addSubview:label];
    
    
    
}
- (void)ShareDetail{
    //  返回指定页面
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[ShareViewController  class]]) {
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
