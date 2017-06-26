//
//  MessageTableViewCell.m
//  milier
//
//  Created by amin on 2017/5/19.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "MessageTableViewCell.h"

@implementation MessageTableViewCell
- (void)configUI:(NSIndexPath *)indexPath{
    UIView *BottomlineView = [[UIView alloc]init];
    BottomlineView.backgroundColor = colorWithRGB(0.87, 0.87, 0.87);
    BottomlineView.frame = CGRectMake(25, 0, SCREEN_WIDTH-50, 0.5);
    [self addSubview:BottomlineView];

    _Messagelabel = [[UILabel alloc]init];
    _Messagelabel.numberOfLines = 0;
    _Messagelabel.font = [UIFont systemFontOfSize:14];
    _Messagelabel.text =@"例如：headerView有3个label，分别是标题，内容，作者如果一个内容label不确定，可以通过传入的内容获取高度。但是有一个View中有多个label高度不确定，如何处理。第一次发帖们不会加图…";
    _Messagelabel.textColor = colorWithRGB(0.4, 0.4, 0.4);
    CGRect rect = [_Messagelabel.text boundingRectWithSize:CGSizeMake(self.frame.size.width - 20, 99999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :   [UIFont systemFontOfSize:14.0]} context:nil];
    _Messagelabel.frame = CGRectMake(30, 10, SCREEN_WIDTH-60, rect.size.height);
    _rowHeight = rect.size.height+10;
    [self addSubview:_Messagelabel];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
