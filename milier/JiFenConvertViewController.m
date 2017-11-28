//
//  JiFenConvertViewController.m
//  milier
//
//  Created by amin on 17/4/24.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "JiFenConvertViewController.h"
#import "DuiHuanTableViewCell.h"
#import "NoDateTableViewCell.h"

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
    self.tableView.backgroundColor = colorWithRGB(0.93, 0.93, 0.93);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadoconNew)];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadconMore)];
    
    [self getNetworkData:YES];
    [self makeData];
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
        }
        if ([[result objectForKey:@"items"]count]==0) {
            [self reset];
        }
         [self endRefresh];
        // UserDic = [result objectForKey:@"data"];
        // [self reloadData];
    }];
}

- (void)reset{
    [self.tableView reloadData];
    
    // 拿到当前的上拉刷新控件，变为没有更多数据的状态
    [self.tableView.mj_footer endRefreshingWithNoMoreData];
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
    if (DuiHuanArray.count) {

        return _sectionArray.count;

    }else{
        return 1;
 
    }
}
//设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (DuiHuanArray.count) {
        NSArray *arr = _sectionArray[section];
        return arr.count;
    }else{
        return 1;
    }
  
}
//组头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (DuiHuanArray.count) {
        return 100;
    }else{
        return 0;
    }


}
//cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (DuiHuanArray.count) {
        if ([_flagArray[indexPath.section] isEqualToString:@"0"])
            return 0;
        else
            if (SectionArray.count) {
                NSLog(@"self = %@",[SectionArray objectAtIndex:indexPath.section] );
                
                CGFloat statuesFloat = [DuiHuanTableViewCell tableView:tableView rowHeightForObject:[SectionArray objectAtIndex:indexPath.section]];
                
                return statuesFloat+20;
            }else{
                return 100;
            }
    }else{
        return SCREEN_HEIGHT-64-49-60-150;
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
        sectionLabel.frame = CGRectMake(0, 0, self.view.frame.size.width, 105);
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
            make.left.mas_equalTo(sectionLabel.mas_left).offset(12);
            make.centerY.mas_equalTo(sectionLabel.mas_centerY);
            make.width.mas_equalTo(90);
            make.height.mas_equalTo(90);
        }];
        
        UILabel *NameLabel = [[UILabel alloc]init];
        NameLabel.text =[NSString stringWithFormat:@"%@",model.commodityName];
        NameLabel.textAlignment = NSTextAlignmentLeft;
        NameLabel.textColor = colorWithRGB(0.27, 0.27, 0.27);
        NameLabel.numberOfLines = 0;
        NameLabel.font = [UIFont systemFontOfSize:15];
        [sectionLabel addSubview:NameLabel];
        [NameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(NameImageView.mas_right).offset(15);
            make.top.mas_equalTo(sectionLabel.mas_top).offset(12);
            make.width.mas_equalTo(SCREEN_WIDTH- 120);
            make.height.mas_equalTo(20);
        }];
        
        UILabel *NameDetailLabel = [[UILabel alloc]init];
        NameDetailLabel.text = [NSString stringWithFormat:@"积分:%@",model.commodityScore];
        NameDetailLabel.numberOfLines = 0;
        NameDetailLabel.textColor = colorWithRGB(0.95, 0.6, 0.11);
        NameDetailLabel.lineBreakMode = NSLineBreakByCharWrapping;
        NameDetailLabel.font = [UIFont systemFontOfSize:15];
        [sectionLabel addSubview:NameDetailLabel];
        [NameDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(NameImageView.mas_right).offset(15);
            make.top.mas_equalTo(NameLabel.mas_bottom);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(20);
        }];
        
        UILabel *MyJiFenLabel = [[UILabel alloc]init];
        NSString *timeStr = [self getTimeStr:model.createTime withForMat:@"yyyy-MM-dd"];
        MyJiFenLabel.text=[NSString stringWithFormat:@"%@",timeStr];
        MyJiFenLabel.textColor = colorWithRGB(0.27, 0.27, 0.27);
        //    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
        //    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:MyJiFenLabel.text attributes:attribtDic];
        //    MyJiFenLabel.attributedText = attribtStr;
        MyJiFenLabel.font = [UIFont systemFontOfSize:14];
        [sectionLabel   addSubview:MyJiFenLabel];
        [MyJiFenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(NameImageView.mas_right).offset(15);
            make.top.mas_equalTo(NameDetailLabel.mas_bottom);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(20);
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
            make.left.mas_equalTo(NameImageView.mas_right).offset(15);
            make.top.mas_equalTo(MyJiFenLabel.mas_bottom);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(15);
        }];
        
        
        UIImageView *RowImageView = [[UIImageView alloc]init];
        RowImageView.image = [UIImage imageNamed:@"down_arrow_gray"];
        RowImageView.frame = CGRectMake(SCREEN_WIDTH - 60, 45, 18, 18);
        [sectionLabel addSubview:RowImageView];
        
        
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
    if (DuiHuanArray.count) {
        static NSString *identifier = @"duihuanWupinglidentifier";
        
        DuiHuanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[DuiHuanTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
            [cell configUI:indexPath];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (DuiHuanArray.count) {
            DuiHuanModel *model = [DuiHuanArray objectAtIndex:indexPath.section];
            cell.DuiHuanModel = model;
        }
        
        
        return cell;
    }else{
        static NSString *identifier = @"nodateduihuanTotalidentifier";
        
        NoDateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[NoDateTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
            [cell configUI:indexPath];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    
        
        return cell;
    }
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //    SectionViewController *sVC = [[SectionViewController alloc] init];
    //    sVC.rowLabelText = [NSString stringWithFormat:@"第%ld组的第%ld个cell",(long)indexPath.section,(long)indexPath.row];
    //    [self presentViewController:sVC animated:YES completion:nil];
}
- (void)sectionClick:(UITapGestureRecognizer *)tap{
    int index = tap.view.tag - 100;
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
