//
//  SepartTableViewCell.h
//  milier
//
//  Created by amin on 2017/5/19.
//  Copyright © 2017年 yj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SepartTableViewCell : UITableViewCell


@property (nonatomic , retain) UILabel *TitleLabel;

@property (nonatomic , retain) UILabel *TypeLabel;

@property (nonatomic , retain) UILabel *TimeLabel;
- (void)configUI:(NSIndexPath *)indexPath;

@end
