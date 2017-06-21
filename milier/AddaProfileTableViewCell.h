//
//  AddaProfileTableViewCell.h
//  milier
//
//  Created by amin on 17/4/24.
//  Copyright © 2017年 yj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileModel.h"

@interface AddaProfileTableViewCell : UITableViewCell

@property (nonatomic , retain) UILabel *NameLabel;

@property (nonatomic , retain) UILabel *DetailLabel;

@property (nonatomic, retain)UIImageView *typeImagewView;

@property(nonatomic, retain)ProfileModel *ProfileModel;

- (void)configUI:(NSIndexPath *)indexPath;

- (void)setProfileModel:(ProfileModel *)ProfileModel;

@end
