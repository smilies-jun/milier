//
//  DinQiListTableViewCell.h
//  milier
//
//  Created by amin on 2017/7/26.
//  Copyright © 2017年 yj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DinQiModel.h"

@interface DinQiListTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UIView *ImageView;
@property (nonatomic, strong) UILabel *DinQiLabel;
@property (nonatomic, strong) UILabel *DinQiDetailLabel;
@property (nonatomic, strong) UILabel *DinQiNnumberLabel;
@property (nonatomic, strong) UILabel *DinQiTotalNnumberLabel;
@property (nonatomic, strong) UIImageView *StateImageView;
@property (nonatomic, strong) UIProgressView *processView;
@property (nonatomic, strong)UIImageView *RowImageView;
- (void)configUI:(NSIndexPath *)indexPath;
@property (nonatomic, strong)DinQiModel *DinqiModel;
- (void)setDinqiModel:(DinQiModel *)DinqiModel;
@end
