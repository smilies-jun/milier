//
//  ActivityRefinViewController.h
//  milier
//
//  Created by amin on 2017/6/23.
//  Copyright © 2017年 yj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityRefinViewController : UIViewController
@property (nonatomic,strong) NSTimer *securityCodeTimer; //验证码倒计时
@property (nonatomic,strong) UIButton *GetCode;//验证码
@property (nonatomic,strong) NSString *codeStr;

@property (nonatomic,strong) NSString *type;
@end
