//
//  AddTwoDayTableViewCell.h
//  milier
//
//  Created by amin on 2018/2/6.
//  Copyright © 2018年 yj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddProfileModel.h"


@interface AddTwoDayTableViewCell : UITableViewCell
@property (nonatomic ,retain)AddProfileModel *AddModel;
@property (nonatomic , retain) UILabel *NameLabel;

@property (nonatomic , retain) UILabel *DetailLabel;


- (void)configUI:(NSIndexPath *)indexPath;

- (void)setAddModel:(AddProfileModel *)AddModel;
@end
