//
//  MyPopView.m
//  milier
//
//  Created by amin on 17/4/14.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "MyPopView.h"

@implementation MyPopView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
     Drawing code
}
*/
- (void)drawRect:(CGRect)rect {
    [self curtainView];
}
- (SnailCurtainView *)curtainView {
    
    SnailCurtainView *curtainView = [[SnailCurtainView alloc] init];
    curtainView.width = [UIScreen width];
    [curtainView.closeButton setImage:[UIImage imageNamed:@"qzone_close"] forState:UIControlStateNormal];
    NSArray *imageNames = @[@"说说", @"照片", @"视频", @"签到", @"大头贴"];
    NSMutableArray *models = [NSMutableArray arrayWithCapacity:imageNames.count];
    for (NSString *imageName in imageNames) {
        UIImage *image = [UIImage imageNamed:[@"qzone_" stringByAppendingString:imageName]];
        [models addObject:[SnailIconLabelModel modelWithTitle:imageName image:image]];
    }
    curtainView.models = models;
    return curtainView;
}
@end
