//
//  StageModel.h
//  milier
//
//  Created by amin on 2017/5/27.
//  Copyright © 2017年 yj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StageModel : NSObject

@property(nonatomic,strong)NSString *minimumInvestmentAmount;

@property(nonatomic,strong)NSString *minimumInvestmentDays;

@property(nonatomic,strong)NSString *name;

@property(nonatomic,strong)NSString *oid;

@property(nonatomic,strong)NSArray *productCategoryIds;

@property(nonatomic,strong)NSString *type;

@property(nonatomic,strong)NSString *value;

@property(nonatomic,strong)NSString *expireTime;

@property(nonatomic,strong)NSString *state;
@end
