//
//  NoticeTableViewCell.h
//  milier
//
//  Created by amin on 2018/3/29.
//  Copyright © 2018年 yj. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NoticeModel.h"


@interface NoticeTableViewCell : UITableViewCell
@property(nonatomic,strong)NoticeModel *noticelModel;


@property (nonatomic , retain) UILabel *NoticeLabel;

@property (nonatomic , retain) UIImageView *NoticeImageView;

- (void)configUI:(NSIndexPath *)indexPath;
- (void)setNoticelModel:(NoticeModel *)noticelModel;

@end
