//
//  YWDAlertView.h
//  YWD
//
//  Created by 007 on 15/10/30.
//  Copyright © 2015年 star. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^AlertClicked) (int type);

@interface YWDAlertView : UIView{
    AlertClicked _alertClicked;
}


@property (nonatomic,strong)NSString *titleStr;

- (void)clickedSure:(AlertClicked)clickedBlock;

@end
