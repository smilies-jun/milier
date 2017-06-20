//
//  BoundTableViewCell.h
//  milier
//
//  Created by amin on 2017/5/18.
//  Copyright © 2017年 yj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShareModel.h"

@interface BoundTableViewCell : UITableViewCell
@property (nonatomic, retain)ShareModel *ShareModel;

@property (nonatomic , retain) UIImageView *userImageView;

@property (nonatomic , retain) UILabel *NameLabel;

@property (nonatomic , retain) UILabel *DetailLabel;

@property (nonatomic , retain) UILabel *TypeLabel;

@property (nonatomic , retain) UIButton *AlertBtn;

- (void)configUI:(NSIndexPath *)indexPath;

- (void)setShareModel:(ShareModel *)ShareModel;

@end
