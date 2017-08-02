//
//  UnYetListTableViewCell.h
//  milier
//
//  Created by amin on 2017/8/1.
//  Copyright © 2017年 yj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoneyModel.h"

@interface UnYetListTableViewCell : UITableViewCell

@property (nonatomic, strong) UIView *ImageView;

@property (nonatomic, strong) UILabel *DinQiLabel;

@property (nonatomic, strong) UILabel *DinQiDetailLabel;

@property (nonatomic, strong) UILabel *DaoQiLabel;
@property (nonatomic, strong) UILabel *MoneyLabel;

@property (nonatomic, strong) UIImageView *StateImageView;

@property (nonatomic, strong) MoneyModel *LostModel;
- (void)setLostModel:(MoneyModel *)LostModel;
- (void)configUI:(NSIndexPath *)indexPath;

@end
