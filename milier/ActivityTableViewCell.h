//
//  ActivityTableViewCell.h
//  milier
//
//  Created by amin on 2017/5/9.
//  Copyright © 2017年 yj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityModel.h"


@interface ActivityTableViewCell : UITableViewCell

@property(nonatomic, strong)ActivityModel *ActivityModel;

@property (nonatomic, retain) UIView *BagView;

@property (nonatomic, retain) UILabel *TitleLabel;

@property (nonatomic, retain) UILabel *DetailLabel;

@property (nonatomic, retain) UIImageView *ActivityImageView;;

@property (nonatomic, retain) UIImageView *ActivityTypeImageView;

@property (nonatomic, retain) UILabel *ActivityLabel;

@property (nonatomic, retain) UILabel *LookLabel;


- (void)configUI:(NSIndexPath *)indexPath;

@end
