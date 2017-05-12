//
//  ProuctModel.h
//  milier
//
//  Created by amin on 17/4/15.
//  Copyright © 2017年 yj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProuctModel : NSObject

@property(nonatomic,strong)NSString *productCategoryId;

@property(nonatomic,strong)NSString *interestRate;

@property(nonatomic,strong)NSString *riskLevel;

@property(nonatomic,strong)NSString *productId;

@property(nonatomic,strong)NSString *name;

@property(nonatomic,strong)NSString *minimumInvestmentAmount;

@property(nonatomic,strong)NSString *modeOfRepayment;

@property(nonatomic,strong)NSString *progress;

@property(nonatomic,strong)NSString *investmentHorizon;

@property(nonatomic,strong)NSString *progressMessage;

@property(nonatomic,strong)NSString *state;

@end
