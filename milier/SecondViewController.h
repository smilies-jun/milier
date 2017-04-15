//
//  SecondViewController.h
//  milier
//
//  Created by amin on 17/2/21.
//  Copyright © 2017年 yj. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ModalViewControllerDelegate <NSObject>

- (void)changLabelText:(NSString *)text;

@end

@interface SecondViewController : UIViewController  

@end
