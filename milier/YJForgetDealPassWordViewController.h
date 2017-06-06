//
//  YJForgetDealPassWordViewController.h
//  milier
//
//  Created by amin on 2017/6/2.
//  Copyright © 2017年 yj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YJForgetDealPassWordViewController : UIViewController<UITextFieldDelegate>

@property (nonatomic,strong) NSTimer *securityCodeTimer;
@property (nonatomic,strong) UIButton *GetCode;


@property (nonatomic,strong)NSString *TypeStr;

@end
