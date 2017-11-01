//
//  ChangeBankCardViewController.h
//  milier
//
//  Created by amin on 2017/10/19.
//  Copyright © 2017年 yj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangeBankCardViewController : UIViewController<UITextFieldDelegate>

@property (nonatomic,strong) NSTimer *securityCodeTimer;
@property (nonatomic,strong) UIButton *GetCode;


@property (nonatomic,strong)NSString *TypeStr;
@property (nonatomic,strong)NSString *BankName;
@property (nonatomic,strong)NSString *BankCard;
@end
