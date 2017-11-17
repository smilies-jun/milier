//
//  SecondTableViewCell.h
//  milier
//
//  Created by amin on 17/4/11.
//  Copyright © 2017年 yj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProuctModel.h"


@interface SecondTableViewCell : UITableViewCell

@property(nonatomic,strong)ProuctModel *productMoel;

@property (nonatomic , retain) UILabel *TitleLabel;

@property (nonatomic , retain) UILabel *TypeLabel;
@property (nonatomic , retain) UILabel *TimeLabel;

@property (nonatomic , retain) UILabel *ProfitLabel;

@property (nonatomic , retain) UILabel *MoneyLabel;

@property (nonatomic , retain) UILabel *MoneyPercentLabel;

@property (nonatomic , retain) UILabel *StyleLabel;

@property (nonatomic , retain) UILabel *SaleLabel;

@property (nonatomic , retain) UILabel *FullLabel;

@property (nonatomic , retain) UILabel *limitTimeLabel;

@property (nonatomic , retain) UILabel *BeginMoneyLabel;

@property (nonatomic, retain)UILabel *ChangeLabel;

@property (nonatomic , retain)  CAShapeLayer *shapeLayer;
@property (nonatomic , retain)  CAShapeLayer *BageLayer;

@property (nonatomic ,retain) UILabel *PercentLabel;

- (void)configUI:(NSIndexPath *)indexPath;


@end
