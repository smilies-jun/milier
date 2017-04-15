//
//  YJCircleProgressView.h
//  milier
//
//  Created by amin on 17/2/23.
//  Copyright © 2017年 yj. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface YJCircleProgressView : UIView
@property(assign,nonatomic)CGFloat startValue;
@property(assign,nonatomic)CGFloat lineWidth;
@property(assign,nonatomic)CGFloat value;
@property(strong,nonatomic)UIColor *lineColr;
@end
