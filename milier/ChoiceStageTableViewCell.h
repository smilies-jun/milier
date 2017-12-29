//
//  ChoiceStageTableViewCell.h
//  milier
//
//  Created by amin on 2017/5/12.
//  Copyright © 2017年 yj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChooseStageModel.h"

@interface ChoiceStageTableViewCell : UITableViewCell



- (void)configUI:(NSIndexPath *)indexPath;
@property (nonatomic,strong)UIImageView *TotalImageView;

@property (nonatomic,strong)UILabel *TitleLable;
@property (nonatomic,strong)UILabel *DaoQiTitleLable;
@property (nonatomic,strong)UILabel *DetailLable;
@property (nonatomic,strong)UIImageView *IConImageView;

@property (nonatomic,strong)ChooseStageModel *stageModel;


- (void)setStageModel:(ChooseStageModel *)stageModel;

@end

