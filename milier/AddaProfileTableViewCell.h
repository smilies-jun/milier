//
//  AddaProfileTableViewCell.h
//  milier
//
//  Created by amin on 17/4/24.
//  Copyright © 2017年 yj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddaProfileTableViewCell : UITableViewCell

@property (nonatomic , retain) UILabel *NameLabel;

@property (nonatomic , retain) UILabel *DetailLabel;

- (void)configUI:(NSIndexPath *)indexPath;

@end
