//
//  popupFade.h
//  shiyi
//
//  Created by 于君 on 15/6/11.
//  Copyright (c) 2015年 于君. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface popupFade : NSObject

- (void)showView:(UIView *)popupView;
- (void)dismissView:(UIView *)popupView  completion:(void (^)(void))completion;

@end
