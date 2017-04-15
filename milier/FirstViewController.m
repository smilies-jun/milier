//
//  FirstViewController.m
//  milier
//
//  Created by amin on 17/2/21.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "FirstViewController.h"
#import "YJCircleProgressView.h"

@interface FirstViewController (){
    CAShapeLayer *shapeLayer;
}
@end

@implementation FirstViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"投资";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    //创建出CAShapeLayer
    self->shapeLayer = [CAShapeLayer layer];
    self->shapeLayer.frame = CGRectMake(0, 0, 200, 200);//设置shapeLayer的尺寸和位置
    self->shapeLayer.position = self.view.center;
    self->shapeLayer.fillColor = [UIColor clearColor].CGColor;//填充颜色为ClearColor
    self->shapeLayer.strokeStart = 0;
    
    self->shapeLayer.strokeEnd = 0.75;
    //设置线条的宽度和颜色
    self->shapeLayer.lineWidth = 1.0f;
    self->shapeLayer.strokeColor = [UIColor redColor].CGColor;
    
    //创建出圆形贝塞尔曲线
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 200, 200)];
    
    //让贝塞尔曲线与CAShapeLayer产生联系
    self->shapeLayer.path = circlePath.CGPath;
    
    //添加并显示
    [self.view.layer addSublayer:self->shapeLayer];
    

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
