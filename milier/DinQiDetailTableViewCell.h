//
//  DinQiDetailTableViewCell.h
//  milier
//
//  Created by amin on 17/4/25.
//  Copyright © 2017年 yj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DinQiDetailTableViewCell : UITableViewCell

@property (nonatomic , retain) UIImageView *SailTimeImageView;

@property (nonatomic , retain) UILabel *SailNameLabel;

@property (nonatomic , retain) UILabel *LookSailLabel;


@property (nonatomic , retain) UIImageView *LimitTimeImageView;

@property (nonatomic , retain) UILabel *LimitNameLabel;

@property (nonatomic , retain) UILabel *LookLimitLabel;

- (void)configUI:(NSIndexPath *)indexPath;


@end
