//
//  TadayExamTableViewCell.h
//  ExaminationPower
//
//  Created by 纵索科技 on 16/9/24.
//  Copyright © 2016年 贺乾龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TadayExamTableViewCell : UITableViewCell
@property (strong, nonatomic)  UILabel *titleLabel;
@property (strong, nonatomic)  UIButton *selectBtn;
@property (strong, nonatomic)  UILabel *connentLabel;
@property (strong, nonatomic)  UIButton *sureBtn;
@property (nonatomic,assign)BOOL isSelected;
-(void)UpdateCellWithState:(BOOL)select;

@end
