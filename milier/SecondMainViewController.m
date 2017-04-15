//
//  SeconMainViewController.m
//  milier
//
//  Created by amin on 17/4/12.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "SecondMainViewController.h"

@interface SecondMainViewController ()<YNPageScrollViewControllerDelegate>


@property (nonatomic, strong) UIView *navView;



@end

@implementation SecondMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    self.view.backgroundColor = [UIColor greenColor];
    self.addButtonAtion = ^(UIButton *btn, YNPageScrollViewController *vc) {
        NSLog(@"%@",btn);
        
    };
    
    [self.view addSubview:self.navView];
    
    
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}


#pragma mark - YNPageScrollViewControllerDelegate

- (void)pageScrollViewController:(YNPageScrollViewController *)pageScrollViewController tableViewScrollViewContentOffset:(CGFloat)contentOffset progress:(CGFloat)progress{
    
    self.navView.alpha = progress;
    
}
- (UIView *)navView{
    
    if (!_navView) {
        _navView =  [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
        _navView.backgroundColor = [UIColor purpleColor];
        _navView.alpha = 0;
    }
    
    return _navView;
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
