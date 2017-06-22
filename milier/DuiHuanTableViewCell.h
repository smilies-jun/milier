//
//  DuiHuanTableViewCell.h
//  milier
//
//  Created by amin on 17/5/3.
//  Copyright © 2017年 yj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DuiHuanModel.h"


@interface DuiHuanTableViewCell : UITableViewCell

@property (nonatomic , retain) UIView *BageView;


@property (nonatomic, retain)UIImageView *StaticImageView;


@property (nonatomic , retain) UIView *SecondBageView;

@property (nonatomic , retain) UIView *ThirdBageView;


@property (nonatomic , retain) UILabel *NameLabel;

@property (nonatomic , retain) UILabel *NameDetailLabel;

@property (nonatomic , retain) UILabel *MyJiFenLabel;

@property(nonatomic, retain)DuiHuanModel *DuiHuanModel;

@property(nonatomic, retain)UIView *bottomView;

- (void)configUI:(NSIndexPath *)indexPath;

- (void)setDuiHuanModel:(DuiHuanModel *)DuiHuanModel;


+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object;

@end
