//
//  UnYetDetailTableViewCell.h
//  milier
//
//  Created by amin on 2017/8/1.
//  Copyright © 2017年 yj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YetDetailModel.h"


@interface UnYetDetailTableViewCell : UITableViewCell



- (void)configUI:(NSIndexPath *)indexPath;

@property (nonatomic, strong) UILabel *TitleLabel;

@property (nonatomic, strong) UILabel *DetailLabel;

@property (nonatomic, strong) UILabel *DetailMoneyLabel;

@property (nonatomic, strong) UILabel *TimeLabel;

@property (nonatomic, strong)YetDetailModel *DetailModel;

- (void)setDetailModel:(YetDetailModel *)DetailModel;

@end
