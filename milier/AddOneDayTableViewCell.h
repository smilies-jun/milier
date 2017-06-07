//
//  AddOneDayTableViewCell.h
//  milier
//
//  Created by amin on 2017/6/5.
//  Copyright © 2017年 yj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddProfileModel.h"

@interface AddOneDayTableViewCell : UITableViewCell

@property (nonatomic ,retain)AddProfileModel *AddModel;
@property (nonatomic , retain) UILabel *NameLabel;

@property (nonatomic , retain) UILabel *DetailLabel;


- (void)configUI:(NSIndexPath *)indexPath;

- (void)setAddModel:(AddProfileModel *)AddModel;

@end
