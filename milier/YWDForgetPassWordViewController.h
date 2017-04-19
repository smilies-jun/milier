//
//  YWDForgetPassWordViewController.h
//  YWD
//
//  Created by 007 on 15/10/28.
//  Copyright © 2015年 star. All rights reserved.
//

#import "BaseViewController.h"

@interface YWDForgetPassWordViewController : BaseViewController<UITextFieldDelegate>

@property (nonatomic,strong) NSTimer *securityCodeTimer;
@property (nonatomic,strong) UIButton *GetCode;


@end
