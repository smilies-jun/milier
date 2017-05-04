//
//  ThirdViewController.m
//  milier
//
//  Created by amin on 17/2/21.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "ThirdViewController.h"
#import "CustomMoreView.h"
@interface ThirdViewController (){
    CustomMoreView *AboutUsView;
    CustomMoreView *SafeView;
    CustomMoreView *NewPersonView;
    CustomMoreView *HelpView;
    CustomMoreView *AllView;
    CustomMoreView *ShareView;
    CustomMoreView *DuiHuanView;
    CustomMoreView *TellUsView;
}

@end

@implementation ThirdViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"个人";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"更多";
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor blackColor]}];
    self.view.backgroundColor = [UIColor grayColor];
    [self ConfigUI];
}
- (void)ConfigUI{
    AboutUsView = [[CustomMoreView alloc]init];
    AboutUsView.NameLabel.text = @"关于我们";
    [self.view addSubview:AboutUsView];
    [AboutUsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self.view.mas_top).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(44);
    }];
    
    SafeView  = [[CustomMoreView alloc]init];
    SafeView.NameLabel.text = @"安全保障";
    [self.view addSubview:SafeView];
    [SafeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(AboutUsView.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(44);
    }];
    
    NewPersonView  = [[CustomMoreView alloc]init];
    NewPersonView.NameLabel.text = @"安全保障";
    [self.view addSubview:NewPersonView];
    [NewPersonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(SafeView.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(44);
    }];
    HelpView  = [[CustomMoreView alloc]init];
    HelpView.NameLabel.text = @"新手指引";
    [self.view addSubview:HelpView];
    [HelpView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(NewPersonView.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(44);
    }];
    AllView   = [[CustomMoreView alloc]init];
    AllView.NameLabel.text = @"投资帮助";
    [self.view addSubview:AllView];
    [AllView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(HelpView.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(44);
    }];
    ShareView  = [[CustomMoreView alloc]init];
    ShareView.NameLabel.text = @"全面理财师";
    [self.view addSubview:ShareView];
    [ShareView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(AllView.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(44);
    }];
    DuiHuanView  = [[CustomMoreView alloc]init];
    DuiHuanView.NameLabel.text = @"积分兑换礼品";
    [self.view addSubview:DuiHuanView];
    [DuiHuanView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(ShareView.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(44);
    }];
    TellUsView  = [[CustomMoreView alloc]init];
    TellUsView.NameLabel.text = @"意见反馈";
    [self.view addSubview:TellUsView];
    [TellUsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(DuiHuanView.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(44);
    }];
    
    
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
