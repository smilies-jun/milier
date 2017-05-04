//
//  JiFenConvertViewController.m
//  milier
//
//  Created by amin on 17/4/24.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "JiFenConvertViewController.h"
#import "DuiHuanTableViewCell.h"

@interface JiFenConvertViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)NSMutableArray *sectionArray;
@property (nonatomic,strong)NSMutableArray *flagArray;

@end

@implementation JiFenConvertViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"消息";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    
    //    [self.navigationController.navigationBar setTranslucent:NO];
    //    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.000 green:0.800 blue:0.800 alpha:1.000]];
    //    // 导航栏标题字体颜色
    //    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11],NSForegroundColorAttributeName:[UIColor orangeColor]}];
    //    // 导航栏左右按钮字体颜色
    //    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //
    //    self.navigationItem.title = @"米粒儿金融";
    //    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    [self makeData];
}


/**
 *  处理数据  _sectionArray里面存储数组
 */
- (void)makeData{
    _sectionArray = [NSMutableArray array];
    _flagArray  = [NSMutableArray array];
    NSInteger num = 10;
    for (int i = 0; i < num; i ++) {
        NSMutableArray *rowArray = [NSMutableArray array];
        for (int j = 0; j < 2; j ++) {
            [rowArray addObject:[NSString stringWithFormat:@"%d",j]];
        }
        [_sectionArray addObject:rowArray];
        [_flagArray addObject:@"0"];
    }
}
//设置组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _sectionArray.count;
}
//设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr = _sectionArray[section];
    return arr.count;
}
//组头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 100;
}
//cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_flagArray[indexPath.section] isEqualToString:@"0"])
        return 0;
    else
        return 44;
}
//组头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *sectionLabel = [[UIView alloc] init];
    sectionLabel.frame = CGRectMake(0, 0, self.view.frame.size.width, 100);
    //sectionLabel.textColor = [UIColor orangeColor];
    //sectionLabel.text = [NSString stringWithFormat:@"组%ld",(long)section];
    //sectionLabel.textAlignment = NSTextAlignmentCenter;
    sectionLabel.tag = 100 + section;
    sectionLabel.userInteractionEnabled = YES;
    sectionLabel.backgroundColor = [UIColor whiteColor];
    
    
    UIImageView *NameImageView = [[UIImageView alloc]init];
    NameImageView.backgroundColor = [UIColor greenColor];
    [sectionLabel addSubview:NameImageView];
    [NameImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(sectionLabel.mas_left).offset(10);
        make.centerY.mas_equalTo(sectionLabel.mas_centerY);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(60);
    }];
    
    UILabel *NameLabel = [[UILabel alloc]init];
    NameLabel.text =@"苏泊尔双层电动锅";
    NameLabel.textAlignment = NSTextAlignmentLeft;
    NameLabel.textColor = [UIColor blackColor];
    NameLabel.font = [UIFont systemFontOfSize:10];
    [sectionLabel addSubview:NameLabel];
    [NameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(NameImageView.mas_right).offset(10);
        make.top.mas_equalTo(sectionLabel.mas_top).offset(20);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(15);
    }];
    
   UILabel *NameDetailLabel = [[UILabel alloc]init];
    NameDetailLabel.text = @"的，什么烦恼吗可能都撒到那时你的安克林斯曼的";
    NameDetailLabel.numberOfLines = 0;
    NameDetailLabel.lineBreakMode = NSLineBreakByCharWrapping;
    NameDetailLabel.font = [UIFont systemFontOfSize:10];
    [sectionLabel addSubview:NameDetailLabel];
    [NameDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(NameImageView.mas_right).offset(10);
        make.top.mas_equalTo(NameLabel.mas_bottom);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(25);
    }];
    
    UILabel *MyJiFenLabel = [[UILabel alloc]init];
    MyJiFenLabel.text= @"积分：232232";
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:MyJiFenLabel.text attributes:attribtDic];
    MyJiFenLabel.attributedText = attribtStr;
    MyJiFenLabel.font = [UIFont systemFontOfSize:10];
    [sectionLabel   addSubview:MyJiFenLabel];
    [MyJiFenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(NameImageView.mas_right).offset(10);
        make.top.mas_equalTo(NameDetailLabel.mas_bottom);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(15);
    }];
    
    
   UILabel *ProductLabel = [[UILabel alloc]init];
    ProductLabel.text= @"积分：2343545456";
    ProductLabel.font = [UIFont systemFontOfSize:10];
    [sectionLabel   addSubview:ProductLabel];
    [ProductLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(NameImageView.mas_right).offset(10);
        make.top.mas_equalTo(MyJiFenLabel.mas_bottom);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(15);
    }];
    
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sectionClick:)];
    [sectionLabel addGestureRecognizer:tap];
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor grayColor];
    lineView.frame = CGRectMake(0, 99, SCREEN_WIDTH, 0.5);
    [sectionLabel addSubview:lineView];
    
    return sectionLabel;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"DuihuanCell";
    DuiHuanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[DuiHuanTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identify];
        [cell configUI:indexPath];
    }
    cell.clipsToBounds = YES;//这句话很重要 不信你就试试
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //    SectionViewController *sVC = [[SectionViewController alloc] init];
    //    sVC.rowLabelText = [NSString stringWithFormat:@"第%ld组的第%ld个cell",(long)indexPath.section,(long)indexPath.row];
    //    [self presentViewController:sVC animated:YES completion:nil];
}
- (void)sectionClick:(UITapGestureRecognizer *)tap{
    int index = tap.view.tag % 100;
    
    NSMutableArray *indexArray = [[NSMutableArray alloc]init];
    NSArray *arr = _sectionArray[index];
    for (int i = 0; i < arr.count; i ++) {
        NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:index];
        [indexArray addObject:path];
    }
    //展开
    if ([_flagArray[index] isEqualToString:@"0"]) {
        _flagArray[index] = @"1";
        [self.tableView reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationBottom];  //使用下面注释的方法就 注释掉这一句
    } else { //收起
        _flagArray[index] = @"0";
        [self.tableView reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationTop]; //使用下面注释的方法就 注释掉这一句
    }
    //	NSRange range = NSMakeRange(index, 1);
    //	NSIndexSet *sectionToReload = [NSIndexSet indexSetWithIndexesInRange:range];
    //	[_tableView reloadSections:sectionToReload withRowAnimation:UITableViewRowAnimationAutomatic];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
    [super viewWillDisappear:animated];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
