//
//  SecondPushViewController.h
//  milier
//
//  Created by amin on 17/4/13.
//  Copyright © 2017年 yj. All rights reserved.
//
#import "JKRBubbleViewController.h"
#import "SecondViewController.h"


@interface SecondPushViewController : JKRBubbleViewController
@property (nonatomic,assign) id<ModalViewControllerDelegate>delegate;     //代理设置

@end
