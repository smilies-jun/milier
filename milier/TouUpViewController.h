//
//  TouUpViewController.h
//  milier
//
//  Created by amin on 17/4/19.
//  Copyright © 2017年 yj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLPaySdk.h"

@interface TouUpViewController : UIViewController<LLPaySdkDelegate>

@property(assign)int type;

@end
