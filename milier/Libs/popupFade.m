//
//  popupFade.m
//  shiyi
//
//  Created by 于君 on 15/6/11.
//  Copyright (c) 2015年 于君. All rights reserved.
//

#import "popupFade.h"

@implementation popupFade
- (void)showView:(UIView *)popupView{
    // Generating Start and Stop Positions
    // Set starting properties
    popupView.alpha = 0.0f;
    
    [UIView animateWithDuration:0.5 animations:^{
        popupView.alpha = 1.0f;
    } completion:nil];
    
}
- (void)dismissView:(UIView *)popupView  completion:(void (^)(void))completion{
    [UIView animateWithDuration:0.25 animations:^{
        popupView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        if (finished) {
            completion();
        }
    }];
}

@end
