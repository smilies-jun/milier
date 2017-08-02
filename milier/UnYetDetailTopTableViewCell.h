//
//  UnYetDetailTopTableViewCell.h
//  milier
//
//  Created by amin on 2017/8/2.
//  Copyright © 2017年 yj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoneyModel.h"

@interface UnYetDetailTopTableViewCell : UITableViewCell


@property (nonatomic, strong) UIView *ImageView;

@property (nonatomic, strong) UILabel *DinQiLabel;

@property (nonatomic, strong) UILabel *DinQiDetailLabel;

@property (nonatomic, strong) UILabel *DaoQiLabel;
@property (nonatomic, strong) UILabel *MoneyLabel;

@property (nonatomic, strong) UIImageView *StateImageView;
@property (nonatomic, strong)UIImageView *RowImageView;
@property (nonatomic, strong) MoneyModel *LostModel;
- (void)setLostModel:(MoneyModel *)LostModel;
- (void)configUI:(NSIndexPath *)indexPath;

@end
