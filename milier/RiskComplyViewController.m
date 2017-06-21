//
//  RiskComplyViewController.m
//  milier
//
//  Created by amin on 17/4/26.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "RiskComplyViewController.h"
#import "UserViewController.h"
#import "RiskViewController.h"


@interface RiskComplyViewController ()

@end

@implementation RiskComplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"风险结果";
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
    
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(0, 7, 18, 18);
    [leftBtn setImage:[UIImage imageNamed:@"backarrow@2x.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(RiskComplyTap) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.view.backgroundColor = colorWithRGB(0.94, 0.94, 0.94);
    [self ConFigUI];

}
- (void)ConFigUI{
    UIView *RisktopView = [[UIView alloc]init];
    RisktopView.backgroundColor = colorWithRGB(0.95, 0.6, 0.11);
    [self.view addSubview:RisktopView];
    [RisktopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self.view.mas_top);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(140);
    }];
    UILabel *topLabel = [[UILabel alloc]init];
    topLabel.text = @"评估结果";
    topLabel.textAlignment = NSTextAlignmentCenter;
    topLabel.textColor = [UIColor whiteColor];
    [RisktopView addSubview:topLabel];
    [topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(RisktopView.mas_centerX);
        make.top.mas_equalTo(self.view.mas_top).offset(10);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(20);
    }];
    
    UILabel *topTypeLabel = [[UILabel alloc]init];
    topTypeLabel.text = @"稳健型";
    topTypeLabel.textAlignment = NSTextAlignmentCenter;
    topTypeLabel.font = [UIFont systemFontOfSize:30];
    topTypeLabel.textColor = [UIColor whiteColor];
    [RisktopView addSubview:topTypeLabel];
    [topTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(RisktopView.mas_centerX);
        make.top.mas_equalTo(topLabel.mas_bottom).offset(20);
        make.width.mas_equalTo(180);
        make.height.mas_equalTo(60);
    }];
    
    UIView *RiskBootmView = [[UIView alloc]init];
    RiskBootmView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:RiskBootmView];
    [RiskBootmView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(RisktopView.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(160);
    }];
    
    UILabel *firstLabel = [[UILabel alloc]init];
    firstLabel.text = @"-能接受适中产品";
    firstLabel.font = [UIFont systemFontOfSize:13];
    [RiskBootmView addSubview:firstLabel];
    [firstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(RisktopView.mas_left).offset(10);
        make.top.mas_equalTo(RiskBootmView.mas_top).offset(20);
        make.width.mas_equalTo(360);
        make.height.mas_equalTo(20);
    
    }];
    UILabel *secondLabel = [[UILabel alloc]init];
    secondLabel.text = @"-能接受适中产品";
    secondLabel.numberOfLines = 0;
    secondLabel.font = [UIFont systemFontOfSize:13];
    [RiskBootmView addSubview:secondLabel];
    [secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(RiskBootmView.mas_left).offset(10);
        make.top.mas_equalTo(firstLabel.mas_bottom).offset(15);
        make.width.mas_equalTo(360);
        make.height.mas_equalTo(40);
    }];

    UILabel *threeLabel = [[UILabel alloc]init];
    threeLabel.text = @"-能接受适中产品";
    threeLabel.numberOfLines = 0;
    threeLabel.font = [UIFont systemFontOfSize:13];
    [RiskBootmView addSubview:threeLabel];
    [threeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(RiskBootmView.mas_left).offset(10);
        make.top.mas_equalTo(secondLabel.mas_bottom).offset(15);
        make.width.mas_equalTo(360);
        make.height.mas_equalTo(40);
    }];
    if (_type == 1) {
        topTypeLabel.text = @"保守型";
        firstLabel.text = @"-希望本金安全，能接受较小的价格波动";
        secondLabel.text = @"-愿意尝试得到大于定期存款的回报并承担较小风险，希望投资本金不因通货膨胀而贬值";
        threeLabel.hidden = YES;

    }else if (_type == 2){
        topTypeLabel.text = @"稳健型";
        firstLabel.text = @"-能接受适中的价格波动";
        secondLabel.text = @"-能承受较高的投资风险";
        threeLabel.text = @"-偏好投资兼具成长性及收益性的产品";
    }else{
        topTypeLabel.text = @"积极型";
        firstLabel.text = @"-资产市值波动比较大，可能会低于原始投资本金";
        secondLabel.text = @"-能承担全部收益包括本金可能损失的风险，预期收益率较高";
        threeLabel.text = @"-偏好投资高成长性的产品或投机性产品，希望投资较快的增长，尽可能获得最高回报";
    }
    
    UILabel *TestLabel =  [[UILabel alloc]init];
    TestLabel.text = @"再测一次";
    TestLabel.userInteractionEnabled = YES;
    TestLabel.backgroundColor = colorWithRGB(0.95, 0.6, 0.11);
    TestLabel.textAlignment = NSTextAlignmentCenter;
    TestLabel.textColor = [UIColor whiteColor];
    TestLabel.layer.cornerRadius = 20;
    TestLabel.layer.masksToBounds = YES;
    [self.view addSubview:TestLabel];
    [TestLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(40);
        make.top.mas_equalTo(RiskBootmView.mas_bottom).offset(20);
        make.width.mas_equalTo(SCREEN_WIDTH - 40);
        make.height.mas_equalTo(40);
    }];
    
    UITapGestureRecognizer *SaleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TestSureBtnClick
                                                                                                          )];
    [TestLabel addGestureRecognizer:SaleTap];
}
- (void)TestSureBtnClick{
    RiskViewController *risk = [[RiskViewController alloc]init];
    [self.navigationController   pushViewController:risk animated:NO];
}
- (void)RiskComplyTap{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[UserViewController class]]) {
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
