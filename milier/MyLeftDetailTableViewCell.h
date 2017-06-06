//
//  MyLeftDetailTableViewCell.h
//  milier
//
//  Created by amin on 17/4/24.
//  Copyright © 2017年 yj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyLeftModel.h"


@interface MyLeftDetailTableViewCell : UITableViewCell


@property (nonatomic, retain)MyLeftModel *LeftModel;

@property (nonatomic , retain) UILabel *NameLabel;

@property (nonatomic , retain) UILabel *DetailLabel;

@property (nonatomic , retain) UILabel *TimeLabel;

@property (nonatomic , retain) UILabel *NumberlLabel;

@property (nonatomic , retain) UILabel *StatelLabel;

- (void)configUI:(NSIndexPath *)indexPath;

- (void)setLeftModel:(MyLeftModel *)LeftModel;

@end
