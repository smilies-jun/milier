//
//  MyNewDinQiDetailViewController.h
//  milier
//
//  Created by amin on 2017/7/28.
//  Copyright © 2017年 yj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyNewDinQiDetailViewController : UIViewController{
    int page;
    BOOL isFirstCome; //第一次加载帖子时候不需要传入此关键字，当需要加载下一页时：需要传入加载上一页时返回值字段“maxtime”中的内容。
    int totalPage;//总页数
    BOOL isJuhua;//是否正在下拉刷新或者上拉加载。default NO。
}

/**
 *  获取网络数据
 *  @param isRefresh 是否是下拉刷新
 */
-(void)getNetworkData:(BOOL)isRefresh;

@property (nonatomic, retain)NSString *oid;

@property (nonatomic, retain)NSString *Type;

@property (nonatomic, retain)NSString *State;
@end
