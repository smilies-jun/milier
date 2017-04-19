//
//  ReginAndLoginViewController.h
//  YWD
//
//  Created by 007 on 15/10/29.
//  Copyright © 2015年 star. All rights reserved.
//

#import "BaseViewController.h"

@interface ReginAndLoginViewController : BaseViewController<UITextFieldDelegate>

@property (nonatomic,strong) NSTimer *securityCodeTimer; //验证码倒计时
@property (nonatomic,strong) UIButton *GetCode;//验证码
@property (nonatomic,strong) NSString *codeStr;

@end
