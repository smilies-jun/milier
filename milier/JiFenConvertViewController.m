//
//  JiFenConvertViewController.m
//  milier
//
//  Created by amin on 17/4/24.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "JiFenConvertViewController.h"
#import "DuiHuanTableViewCell.h"

@interface JiFenConvertViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *DuiHuanArray;
    NSMutableArray *SectionArray;
}

@property (nonatomic,strong)NSMutableArray *sectionArray;
@property (nonatomic,strong)NSMutableArray *flagArray;
@property(strong, nonatomic)MyTableView *tableView;

@end

@implementation JiFenConvertViewController
static NSString * const cellId = @"CovertcellID";

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
    
    SectionArray = [[NSMutableArray alloc]init];
    DuiHuanArray = [[NSMutableArray alloc]init];
    self.tableView.noContentViewTapedBlock = ^{
        [self getNetworkData:YES];
    };

    [self getNetworkData:YES];
    [self makeData];
}

- (void)zj_viewDidLoadForIndex:(NSInteger)index {
    
    self.tableView = [[MyTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setTableFooterView:[UIView new]];

    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadoconNew)];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadconMore)];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
    [self.view addSubview:self.tableView];
}
- (void)zj_viewDidAppearForIndex:(NSInteger)index {
    [self getNetworkData:YES];
    [self.tableView reloadData];
}
- (void)loadoconNew{
    [self getNetworkData:YES];
    
}
- (void)loadconMore{
    [self getNetworkData:NO];
    
}
/**
 *  停止刷新
 */
-(void)endRefresh{
    
    if (page == 1) {
        [self.tableView.mj_header endRefreshing];
    }
    [self.tableView.mj_footer endRefreshing];
}

-(void)getNetworkData:(BOOL)isRefresh
{
    if (isRefresh) {
        page = 1;
        isFirstCome = YES;
    }else{
        page++;
    }
    //1. 网贷基金，2. 特色产品，3. 企业贷款、4. 个人贷款，5. 购车贷款、6. 债权转让，7. 新手专享，8. 金米宝， 0. 定期（包含1 3 4 5 6 7）
    NSString *tokenID = NSuserUse(@"Authorization");
  //  NSString *userID = NSuserUse(@"userId");
    
    NSString *url;
    if (isRefresh) {
        url = [NSString stringWithFormat:@"%@/commodityOrders?page=1&rows=20",HOST_URL];
    }else{
        url = [NSString stringWithFormat:@"%@/commodityOrders?page=%d&rows=20",HOST_URL,page];
        
    }
    if (page ==1) {
        [DuiHuanArray removeAllObjects];
        [SectionArray removeAllObjects];
    }
    [[DateSource sharedInstance]requestHtml5WithParameters:nil  withUrl:url withTokenStr:tokenID  usingBlock:^(NSDictionary *result, NSError *error) {
         //é NSLog(@"left result = %@",result);
        for (NSDictionary *dic in [result objectForKey:@"items"]) {
            DuiHuanModel *model = [[DuiHuanModel alloc]init];
            model.dataDictionary = dic;
            [DuiHuanArray addObject:model];
            int  rows;
            NSString *ChangeStr = [dic objectForKey:@"commodityDescArray"];
            rows = (int)[ChangeStr integerValue];
            [SectionArray addObject:[NSString stringWithFormat:@"%d",rows]];

        }
        if (DuiHuanArray.count) {
            [self makeData];
            [self.tableView reloadData];
            [self endRefresh];
        }else{
            [self.tableView showEmptyViewWithType:NoContentTypeNetwork];
 
        }
        
       
        // UserDic = [result objectForKey:@"data"];
        // [self reloadData];
    }];
}




/**
 *  处理数据  _sectionArray里面存储数组
 */
- (void)makeData{
    _sectionArray = [NSMutableArray array];
    _flagArray  = [NSMutableArray array];
    NSInteger num = DuiHuanArray.count;
    for (int i = 0; i < num; i ++) {
        NSMutableArray *rowArray = [NSMutableArray array];
        for (int j = 0; j < 1; j ++) {
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
        if (SectionArray.count) {
            NSLog(@"self = %@",[SectionArray objectAtIndex:indexPath.section] );
            
            CGFloat statuesFloat = [DuiHuanTableViewCell tableView:tableView rowHeightForObject:[SectionArray objectAtIndex:indexPath.section]];
            
            return statuesFloat;
        }else{
            return 100;
        }
    
}

- (NSString *)getTimeStr:(NSString *)MyTimeStr withForMat:(NSString *)formatStr{
    NSTimeInterval interval=[MyTimeStr doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:formatStr];
    NSString * timeStr = [NSString stringWithFormat:@"%@",[objDateformat stringFromDate: date]];
    return timeStr;
}
//组头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (DuiHuanArray.count) {
        DuiHuanModel *model = [DuiHuanArray objectAtIndex:section];
        UIView *sectionLabel = [[UIView alloc] init];
        sectionLabel.frame = CGRectMake(0, 0, self.view.frame.size.width, 100);
        //sectionLabel.textColor = [UIColor orangeColor];
        //sectionLabel.text = [NSString stringWithFormat:@"组%ld",(long)section];
        //sectionLabel.textAlignment = NSTextAlignmentCenter;
        sectionLabel.tag = 100 + section;
        sectionLabel.userInteractionEnabled = YES;
        sectionLabel.backgroundColor = [UIColor whiteColor];
        
        
        UIImageView *NameImageView = [[UIImageView alloc]init];
        [NameImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.commodityImage]] placeholderImage:[UIImage imageNamed:@""]];
        //®´    NameImageView.backgroundColor = [UIColor grayColor];
        [sectionLabel addSubview:NameImageView];
        [NameImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(sectionLabel.mas_left).offset(14);
            make.centerY.mas_equalTo(sectionLabel.mas_centerY);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(60);
        }];
        
        UILabel *NameLabel = [[UILabel alloc]init];
        NameLabel.text =[NSString stringWithFormat:@"%@",model.commodityName];
        NameLabel.textAlignment = NSTextAlignmentLeft;
        NameLabel.textColor = [UIColor blackColor];
        NameLabel.font = [UIFont systemFontOfSize:14];
        [sectionLabel addSubview:NameLabel];
        [NameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(NameImageView.mas_right).offset(10);
            make.top.mas_equalTo(sectionLabel.mas_top).offset(20);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(15);
        }];
        
        UILabel *NameDetailLabel = [[UILabel alloc]init];
        NameDetailLabel.text = [NSString stringWithFormat:@"积分:%@",model.commodityScore];
        NameDetailLabel.numberOfLines = 0;
        NameDetailLabel.lineBreakMode = NSLineBreakByCharWrapping;
        NameDetailLabel.font = [UIFont systemFontOfSize:14];
        [sectionLabel addSubview:NameDetailLabel];
        [NameDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(NameImageView.mas_right).offset(10);
            make.top.mas_equalTo(NameLabel.mas_bottom);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(25);
        }];
        
        UILabel *MyJiFenLabel = [[UILabel alloc]init];
        NSString *timeStr = [self getTimeStr:model.createTime withForMat:@"yyyy-MM-dd"];
        MyJiFenLabel.text=[NSString stringWithFormat:@"%@",timeStr];
        //    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
        //    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:MyJiFenLabel.text attributes:attribtDic];
        //    MyJiFenLabel.attributedText = attribtStr;
        MyJiFenLabel.font = [UIFont systemFontOfSize:14];
        [sectionLabel   addSubview:MyJiFenLabel];
        [MyJiFenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(NameImageView.mas_right).offset(10);
            make.top.mas_equalTo(NameDetailLabel.mas_bottom);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(15);
        }];
        
        
        UILabel *ProductLabel = [[UILabel alloc]init];
        switch ([model.state integerValue]) {
            case 1:
                ProductLabel.text= @"未发货";
                
                break;
            case 2:
                ProductLabel.text= @"已发货";
                
                break;
            case 3:
                ProductLabel.text= @"关闭";
                
                break;
            default:
                break;
        }
        ProductLabel.font = [UIFont systemFontOfSize:14];
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
  
    }else{
        return nil;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"duihuanTotalidentifier";
    
    DuiHuanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[DuiHuanTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        [cell configUI:indexPath];
    }
    if (DuiHuanArray.count) {
        DuiHuanModel *model = [DuiHuanArray objectAtIndex:indexPath.row];
        cell.DuiHuanModel = model;
    }
    
    
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
  
}




@end
