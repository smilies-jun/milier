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
@property (nonatomic , retain) UILabel *NumberLabel;


@property (nonatomic , retain) UILabel *limitTimeLabel;
@property (nonatomic , retain) UILabel *MoneyLabel;



@property (nonatomic , retain)  CAShapeLayer *shapeLayer;

@property (nonatomic ,retain) UILabel *PercentLabel;


- (void)configUI:(NSIndexPath *)indexPath;


@end
