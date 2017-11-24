//
//  oneDinqQiViewController.h
//  milier
//
//  Created by amin on 2017/11/22.
//  Copyright © 2017年 yj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YNTestBaseViewController.h"

@interface oneDinqQiViewController : YNTestBaseViewController<UITableViewDataSource , UITableViewDelegate>{
    int page;
    BOOL isFirstCome; //第一次加载帖子时候不需要传入此关键字，当需要加载下一页时：需要传入加载上一页时返回值字段“maxtime”中的内容。
    int totalPage;//总页数
    BOOL isJuhua;//是否正在下拉刷新或者上拉加载。default NO。
}

@end
