//
//  MessageTableViewCell.h
//  milier
//
//  Created by amin on 2017/5/19.
//  Copyright © 2017年 yj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageTableViewCell : UITableViewCell

@property (nonatomic,retain)UILabel *Messagelabel;
@property (nonatomic, assign) CGFloat rowHeight;
- (void)configUI:(NSIndexPath *)indexPath;
@end
