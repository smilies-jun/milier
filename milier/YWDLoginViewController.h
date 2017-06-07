//
//  YWDLoginViewController.h
//  YWD
//
//  Created by 007 on 15/10/28.
//  Copyright © 2015年 star. All rights reserved.
//

#import "BaseViewController.h"
#import "YWDReginViewController.h"
#import "YWDForgetPassWordViewController.h"
#import "YWDLoginNextViewController.h"


@interface YWDLoginViewController : BaseViewController<UIActionSheetDelegate,UIAlertViewDelegate>
@property (nonatomic,strong) UIImageView *bagView;
@property (nonatomic,strong) UILabel *TitleLabel;
@property (nonatomic,strong) UIButton *ReginButton;
@property (nonatomic,strong) UIImageView *YWDImageView;

@property (nonatomic,strong) UIImageView *PhoneIconImageView;
@property (nonatomic,strong) UITextField *PhoneTextField;
@property (nonatomic,strong) UIImageView *LineImageView;
@property (nonatomic,strong) UIImageView *userNameBackImageView;


@property (nonatomic,strong) UIImageView *PassWordIconImageView;
@property (nonatomic,strong) UITextField *PassWordTextField;
@property (nonatomic,strong) UIImageView *PassWordLineImageView;
@property (nonatomic,strong) UIImageView *PassWordBackImageView;

@property (nonatomic,strong) UIButton *LoginBtn;
@property (nonatomic,strong) UILabel *ForgetPasswordLabel;


@property(assign)int Type;

@end
