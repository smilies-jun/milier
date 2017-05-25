//
//  BoundViewController.m
//  milier
//
//  Created by amin on 17/4/26.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "BoundViewController.h"
#import "BoundTableViewCell.h"


@interface BoundViewController ()

@end

@implementation BoundViewController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.tableView.backgroundColor = colorWithRGB(1, 0.89, 0.53);
    
    
}

#pragma mark - UITableViewDelegate  UITableViewDataSource

//header-height
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    return 0;
    
}
//header-secion
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return [UIView new];
}

//footer-hegiht
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

//footer-section
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [UIView new];
}


//sections-tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
//rows-section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 20;
}
//cell-height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}

//cell-tableview
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"productidentifier";
    
    BoundTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[BoundTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        [cell configUI:indexPath];
        cell.backgroundColor = colorWithRGB(1, 0.89, 0.53);

    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
    
}




@end
