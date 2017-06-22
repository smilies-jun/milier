//
//  DetailTypeTableViewCell.h
//  milier
//
//  Created by amin on 2017/6/22.
//  Copyright © 2017年 yj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailTypeTableViewCell : UITableViewCell
@property (nonatomic , retain) UILabel *TitleLabel;

@property (nonatomic , retain) UILabel *TypeLabel;

@property (nonatomic , retain) UILabel *TimeLabel;

- (void)configUI:(NSIndexPath *)indexPath;

@end
