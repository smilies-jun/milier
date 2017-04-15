//
//  SecondPushViewController.m
//  milier
//
//  Created by amin on 17/4/13.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "SecondPushViewController.h"

@interface SecondPushViewController (){
@private
UITextField *_textField;  //设置全局变量
UIButton *btn;
}

@end

@implementation SecondPushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *backimag = [[UIView alloc]init];
    backimag.frame = CGRectMake(0, 0, 100, 100);
    backimag.backgroundColor = [UIColor redColor];
    [self.view  addSubview:backimag];


//    [self.navigationController.navigationBar setTranslucent:NO];
//    
//    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.000 green:0.800 blue:0.800 alpha:1.000]];
//    // 导航栏标题字体颜色
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11],NSForegroundColorAttributeName:[UIColor orangeColor]}];
//    // 导航栏左右按钮字体颜色
//    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//    
//    self.navigationItem.title = @"米粒儿金融";

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)BtnClick{
    if ([self.delegate respondsToSelector:@selector(changLabelText:)])
    {
        //改变label的内容
        [self.delegate changLabelText:@"232323"];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
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
