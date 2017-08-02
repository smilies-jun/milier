//
//  DinQiJiXiDetailTableViewCell.h
//  milier
//
//  Created by amin on 2017/7/31.
//  Copyright © 2017年 yj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DinQiModel.h"

@interface DinQiJiXiDetailTableViewCell : UITableViewCell

@property (nonatomic, strong)UILabel *SaleLabel;

@property (nonatomic, strong)UIImageView *SaleImageView;

@property (nonatomic, strong)UILabel *MoneyLabel;


@property (nonatomic, strong)DinQiModel     *JixiModel;

- (void)setJixiModel:(DinQiModel *)JixiModel;
- (void)configUI:(NSIndexPath *)indexPath;
@end
