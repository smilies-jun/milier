//
//  JiFenRecordTableViewCell.h
//  milier
//
//  Created by amin on 17/5/3.
//  Copyright © 2017年 yj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JiFenModel.h"


@interface JiFenRecordTableViewCell : UITableViewCell

@property (nonatomic , retain) UILabel *NameLabel;

@property (nonatomic , retain) UILabel *NameDetailLabel;

@property (nonatomic , retain) UILabel *MyJiFenLabel;

@property (nonatomic, retain)JiFenModel *JiFenModel;

- (void)configUI:(NSIndexPath *)indexPath;

- (void)setJiFenModel:(JiFenModel *)JiFenModel;
@end
