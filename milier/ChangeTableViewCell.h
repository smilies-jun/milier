//
//  ChangeTableViewCell.h
//  milier
//
//  Created by amin on 17/4/24.
//  Copyright © 2017年 yj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangeTableViewCell : UITableViewCell
@property (nonatomic , retain) UILabel *NameLabel;

@property (nonatomic , retain) UILabel *ChangeValueLabel;
@property (nonatomic , retain) UILabel *ChangeValueNumberLabel ;

@property (nonatomic , retain) UILabel *OneDayChangeLabel;
@property (nonatomic , retain) UILabel *OneDayChangeNumberLabel;

@property (nonatomic , retain) UILabel *ReguarLabel;
@property (nonatomic , retain) UILabel *RegularNumberLabel;

@property (nonatomic , retain) UILabel *OutLabel;
@property (nonatomic , retain) UILabel *OutSailLabel;
@property (nonatomic , retain) UILabel *IsOrNoLabel;

@property (nonatomic , retain) UIImageView *StateImageView;

- (void)configUI:(NSIndexPath *)indexPath;

@end
