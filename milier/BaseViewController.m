//
//  BaseViewController.m
//  milier
//
//  Created by amin on 17/2/22.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "BaseViewController.h"
@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    _TopView = [[UIView alloc]init];
    _TopView.backgroundColor = [UIColor whiteColor];
    _TopView.hidden = YES;
    [self.view addSubview:_TopView];
    [_TopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self.view.mas_top);
        make.height.mas_equalTo(64);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
    _BackButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_BackButton setImage:[UIImage imageNamed:@"backarrow"] forState:UIControlStateNormal];
    [_TopView addSubview:_BackButton];
    [_BackButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_TopView.mas_left).offset(20);
        make.top.mas_equalTo(_TopView.mas_top).offset(35);
        make.height.mas_equalTo(18);
        make.width.mas_equalTo(18);
    }];
    _TopTitleLabel = [[UILabel alloc]init];
    _TopTitleLabel.textAlignment = NSTextAlignmentCenter;
    _TopTitleLabel.font = [UIFont systemFontOfSize:15];
    _TopTitleLabel.textColor = [UIColor blackColor];
    [_TopView addSubview:_TopTitleLabel];
    [_TopTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_TopView.mas_centerX);
        make.top.mas_equalTo(self.view.mas_top).offset(20);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(40);
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
