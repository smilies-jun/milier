//
//  DinQiDetailTableViewCell.h
//  milier
//
//  Created by amin on 17/4/25.
//  Copyright © 2017年 yj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DinQiModel.h"

@interface DinQiDetailTableViewCell : UITableViewCell

@property (nonatomic , retain) UIImageView *SailTimeImageView;

@property (nonatomic , retain) UILabel *SailNameLabel;

@property (nonatomic , retain) UILabel *LookSailLabel;


@property (nonatomic , retain) UIImageView *LimitTimeImageView;

@property (nonatomic , retain) UILabel *LimitNameLabel;

@property (nonatomic , retain) UILabel *LookLimitLabel;

@property (nonatomic , retain) UIView *BageView;

@property (nonatomic, retain)UIImageView *StaticImageView;

- (void)configUI:(NSIndexPath *)indexPath;


/**
 *  设置cell的数据，提供接口
 *
 *  @param status 状态字符串
 */
- (void)setCellDataWithStatusName:(NSString *)status;

/**
 *  传入每一行cell数据，返回行高，提供接口
 *
 *  @param tableView 当前展示的tableView
 *  @param object cell的展示数据内容
 */
+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object;
@end
