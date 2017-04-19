//
//  YWDLoginNextViewController.h
//  YWD
//
//  Created by 007 on 15/10/30.
//  Copyright © 2015年 star. All rights reserved.
//

#import "BaseViewController.h"
#import "YWDForgetPassWordViewController.h"

@interface YWDLoginNextViewController : BaseViewController<UITextFieldDelegate,UIAlertViewDelegate>
@property (nonatomic, strong) NSString *phoneStr;
@end
