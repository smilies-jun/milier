//
//  ConfirmBankViewController.h
//  milier
//
//  Created by amin on 2017/8/14.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "BaseViewController.h"


@interface ConfirmBankViewController : BaseViewController<UITextFieldDelegate>

@property (nonatomic,strong) NSTimer *securityCodeTimer;
@property (nonatomic,strong) UIButton *GetCode;


@property (nonatomic,strong)NSString *TypeStr;


@end
