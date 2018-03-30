//
//  ApplyAllMoneyViewController.m
//  milier
//
//  Created by amin on 2017/6/1.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "ApplyAllMoneyViewController.h"
#import "YNPageScrollViewController.h"
#import "SDCycleScrollView.h"
#import "AllMoneyViewController.h"
#import "SepartViewController.h"
#import "OutViewController.h"
#import "YWDLoginViewController.h"
#import "ThirdViewController.h"
#import "ActivityDetailViewController.h"
#import "AutoScrollLabel.h"
#import "HelpMoneyViewController.h"
@interface ApplyAllMoneyViewController ()<UITableViewDelegate, UITableViewDataSource,YNPageScrollViewControllerDataSource,SDCycleScrollViewDelegate,YNPageScrollViewControllerDelegate>{
    UIButton *ClickBtn;
    NSDictionary *MyDic;
    int ApplyOrNo;
    NSMutableArray *PhoneArray;
    NSMutableArray *MoneyArray;
    AutoScrollLabel *autoScrollLabel;

}

@end

@implementation ApplyAllMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"全民理财师";
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
      [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor blackColor]}];
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(0, 7, 18, 18);
    [leftBtn setImage:[UIImage imageNamed:@"backarrow@2x.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(AllTap) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    ApplyOrNo = 0;
    PhoneArray = [[NSMutableArray alloc]init];
    MoneyArray = [[NSMutableArray alloc]init];
    [self configUI];
    
}
- (void)configUI{
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    if ([_type integerValue] == 1) {
         scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64-20- 60);
    }else{
         scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64-20);
    }
   
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.contentSize = CGSizeMake(0, SCREEN_HEIGHT + 620);
    [self.view addSubview:scrollView];
    
    
    UIImageView *TopImageView = [[UIImageView alloc]init];
    TopImageView.image = [UIImage imageNamed:@"licaishipic"];
    TopImageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 160);
    [scrollView addSubview:TopImageView];

    UILabel *label = [[UILabel alloc]init];
    label.text = @"本网站（www.milibanking.com）现推出“米粒儿金融全民理财师专项活动”（以下简称：“本活动”），您在自愿加入本活动之前，请您务必认真阅读和理解《米粒儿金融全民理财师专项活动协议书》（以下简称：“本《协议》”）中规定的所有权利和限制。您完全接受本《协议》项下的全部条款。本《协议》是本活动参与人员与米粒儿金融之间的法律协议。\n一、加入本活动人员：米粒儿金融用户\n二、活动生效时间：20___年___月___日\n三、参与条件：\n1. www.milibanking.com在投资用户；\n2.自愿加入本活动，成为本活动期间的“理财师”；\n>3.自愿接受米粒儿金融全民理财师专项活动的全部规则，并点击“接受”、“认可”、“加入”等确认键，加入到本活动，签署本《协议》；\n4.本活动仅限网络等线上宣传推广，禁止一切线下操作。\n四、米粒儿金融用户参与本活动成功后，可在其账户系统中查看资格审批情况（以系统显示为准）。\n五、本次活动奖励支付：\n1.成功报名并参与本活动；\n2.邀请好友使用本人“邀请码”注册并投资，系统自动发送相应奖励；\3.奖励按T+1日结算并发放至米粒儿金融账户。\n4.奖励标准：\n每日奖励金额=当日存量*0.8%/365；\n当日存量是指理财师本人及推荐的客户（使用理财师邀请码注册）当日米粒儿账户内资金总额（不含活期产品），当日存量以当日23:59:59的数值为准。\n六、 权利义务：\n1. 参与本活动的用户不得以任何非法目的使用www.milibanking.com网站提供的本活动、相关产品。\n2.参与本活动的用户应当诚实履行对本协议，除法律、法规另有规定外，不得向第三方泄露本协议全部或部分内容。\n3.参与本活动的用户按照本活动的相关规则，有权获得相应的奖励。\n    七、 资格取消：\n1. 参与本活动的用户存在异常情况或做出有损本网站行为发生时，本网站有权随时取消理财师资格，而无需对用户或任何第三方承担任何责任。\n六、免责条款\n1.由于国家的有关法律、法规、规章、政策或者交易所规则的调整和改变、紧急措施的出台及其他不可抗力而导致双方承担风险和损失的，双方互不承担责任。\n七、 争议解决\n1. 本协议适用中华人民共和国法律。\n    2. 因本协议引起的或与本协议有关的任何争议，各方应友好协商解决；协商不成的，任何一方均可将有关争议提交至本网站所在地法院进行诉讼。\n八、 其他\n1.若本协议中的任何条款无论因何种原因完全或部分无效，不影响本协议其他条款的效力及约束力。\n2.本协议未尽事宜，双方可另行签订补充协议，该补充协议作为本协议的组成部分，具有同等法律效力。\n3.根据《合同法》规定，本协议采用电子文本形式制成并签订，并在本网站为此设立的专用服务器上保存，对双方均具有法律约束力。\n4. 与本协议相关的其他具体操作规则以本网站展示为准，并作为本协议的附件，如具体规则与本协议不一致的，以具体规则为准。乙方同意本协议即视为同意本协议相关附件。\n5.本网站在法律允许的最大范围内对本协议享有解释权与修改权。";
    label.numberOfLines = 0 ;
    label.font = [UIFont systemFontOfSize:14];
    label.frame = CGRectMake(10, 160, SCREEN_WIDTH-20, SCREEN_HEIGHT+430);
    [scrollView addSubview:label];
    
    ClickBtn = [[UIButton alloc]init];
    [ClickBtn setBackgroundImage:[UIImage imageNamed:@"uncheck"] forState:UIControlStateNormal];
    ClickBtn.selected = YES;
    [ClickBtn setBackgroundImage:[UIImage imageNamed:@"check"] forState:UIControlStateSelected];
    [ClickBtn addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ClickBtn];
    [ClickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-60);
        make.width.mas_equalTo(18);
        make.height.mas_equalTo(18);
    }];
    
    UILabel *nameLabel =[[UILabel alloc]init];
    nameLabel.font = [UIFont systemFontOfSize:13];
    NSMutableAttributedString *ConnectStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"我同意《服务协议》"]];
    NSRange conectRange = {4,4};
    [ConnectStr addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:conectRange];
    nameLabel.attributedText = ConnectStr;
    [self.view addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ClickBtn.mas_right).offset(10);
        make.centerY.mas_equalTo(ClickBtn.mas_centerY);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(30);
    }];
    
    
    UIButton *reginBtn = [[UIButton alloc]init];
    [reginBtn setBackgroundColor:colorWithRGB(0.95, 0.6, 0.11)];
    reginBtn.layer.masksToBounds = YES;
    reginBtn.layer.cornerRadius = 20.0f;
    [reginBtn setTitle:@"成为全民理财师" forState:UIControlStateNormal];
    [reginBtn addTarget:self action:@selector(agreeClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:reginBtn];
    [reginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-10);
        make.width.mas_equalTo(SCREEN_WIDTH - 40);
        make.height.mas_equalTo(40);
    }];

}
- (void)agreeClicked{
    if (ClickBtn.selected) {
        NSString *userID = NSuserUse(@"userId");
        if ([userID integerValue] > 0) {
            NSString *url = [NSString stringWithFormat:@"%@/brokers",HOST_URL];
            
            NSMutableDictionary *dic = [[NSMutableDictionary   alloc]initWithObjectsAndKeys:userID, @"userId",nil];
            NSString *tokenID = NSuserUse(@"Authorization");
            [[DateSource sharedInstance]requestHomeWithParameters:dic withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
                if ([[result objectForKey:@"statusCode"]integerValue] == 201) {
                    MyDic = [result objectForKey:@"data"];
                    UIViewController *allvc = nil;
                    allvc = [self getAllMoneyViewController];
                    [self.navigationController   pushViewController:allvc animated:NO];
                }else{
                    NSString *message = [result objectForKey:@"message"];
                    normal_alert(@"提示", message, @"确定");
                }
                
            }];
            
        }else{
            YWDLoginViewController *loginVC = [[YWDLoginViewController alloc] init];
            UINavigationController *loginNagition = [[UINavigationController alloc]initWithRootViewController:loginVC];
            loginNagition.navigationBarHidden = YES;
            [self presentViewController:loginNagition animated:NO completion:nil];
            
        }
 
    }else{
        normal_alert(@"提示", @"请先同意协议", @"确定");
    }
    
}
- (void)clicked:(UIButton *)btn{
    if (btn.selected) {
        btn.selected = NO;
    }else{
        btn.selected = YES;
    }
}

- (UIViewController *)getAllMoneyViewController{
    //配置信息
    YNPageScrollViewMenuConfigration *configration = [[YNPageScrollViewMenuConfigration alloc]init];
    configration.scrollViewBackgroundColor = [UIColor redColor];
    configration.itemLeftAndRightMargin = 10;
    configration.itemMargin = 30;
    configration.itemFont = [UIFont systemFontOfSize:13];
    configration.lineColor = colorWithRGB(0.96, 0.6, 0.11);
    configration.lineHeight = 2;
    configration.itemMaxScale = 1.2;
    configration.scrollViewBackgroundColor = colorWithRGB(1, 0.87, 0.25);
    configration.pageScrollViewMenuStyle = YNPageScrollViewMenuStyleSuspension;
    configration.scrollViewBackgroundColor = [UIColor whiteColor];
    configration.selectedItemColor = colorWithRGB(0.96, 0.6, 0.11);
    //设置平分不滚动   默认会居中
    // configration.aligmentModeCenter = YES;
    //configration.showConver = YES;
    //configration.converColor = colorWithRGB(1,0.87, 0.01);
    //设置平分不滚动   默认会居中
    // configration.aligmentModeCenter = YES;
    //configration.showScrollLine = NO;
    configration.scrollMenu = YES;
    configration.showGradientColor = NO;//取消渐变
    configration.showNavigation = YES;
    configration.showTabbar = YES;//设置显示tabbar
    configration.showPersonTab = NO;
    
    AllMoneyViewController *vc = [AllMoneyViewController pageScrollViewControllerWithControllers:[self getViewController] titles:@[@"分成列表",@"转出记录"] Configration:configration];
    // 头部是否能伸缩效果   要伸缩效果就不要有下拉刷新控件 默认NO*/
    vc.HeaderViewCouldScale = YES;
    
    
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 245)];
    imageView.backgroundColor = colorWithRGB(1, 0.87, 0.25);
    imageView.userInteractionEnabled = YES;
    UIImageView *TopImageView = [[UIImageView alloc]init];
    TopImageView.image = [UIImage imageNamed:@"licaishipic"];
    TopImageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 160);
    [imageView addSubview:TopImageView];
    
    NSMutableString *MySTR = [[NSMutableString   alloc]init];
    for (int i = 0; i<[PhoneArray count] ; i++) {
        NSString *str = [NSString stringWithFormat:@"%@获得单笔分成%@元    ",[PhoneArray objectAtIndex:i],[MoneyArray objectAtIndex:i]];
        
        [MySTR appendString:str];
    }
    autoScrollLabel = [[AutoScrollLabel alloc]initWithFrame:CGRectMake(0, 160, SCREEN_WIDTH, 40)];
    autoScrollLabel.backgroundColor = [UIColor whiteColor];
    autoScrollLabel.text = [NSString stringWithFormat:@"%@",MySTR];
    autoScrollLabel.textColor = [UIColor blackColor];
    [imageView addSubview:autoScrollLabel];
    
    UILabel *MyScorLabel = [[UILabel alloc]init];
    if ( [[MyDic objectForKey:@"totalIncome"]doubleValue]) {
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"我的总分成:%.2f元", [[MyDic objectForKey:@"totalIncome"]floatValue]]];
        // 需要改变的第一个文字的位置
        NSUInteger firstLoc = [[noteStr string] rangeOfString:@"成"].location+2;
        // 需要改变的最后一个文字的位置
        NSUInteger secondLoc = [[noteStr string] rangeOfString:@"元"].location+1;
        // 需要改变的区间
        NSRange range = NSMakeRange(firstLoc, secondLoc - firstLoc);
        // 改变颜色
        [noteStr addAttribute:NSForegroundColorAttributeName value:colorWithRGB(0.96, 0.6, 0.12) range:range];
        
        [MyScorLabel setAttributedText:noteStr];
        //MyScorLabel.text =[NSString stringWithFormat:@"我的总分成:%.2f元", [[MyDic objectForKey:@"totalIncome"]floatValue]];
    }else{
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"我的总分成:0元"]];
        // 需要改变的第一个文字的位置
        NSUInteger firstLoc = [[noteStr string] rangeOfString:@"成"].location+2;
        // 需要改变的最后一个文字的位置
        NSUInteger secondLoc = [[noteStr string] rangeOfString:@"元"].location+1;
        // 需要改变的区间
        NSRange range = NSMakeRange(firstLoc, secondLoc - firstLoc);
        // 改变颜色
        [noteStr addAttribute:NSForegroundColorAttributeName value:colorWithRGB(0.96, 0.6, 0.12) range:range];
        
        [MyScorLabel setAttributedText:noteStr];
        //MyScorLabel.text =[NSString stringWithFormat:@"我的总分成:0元"];
        
    }
    MyScorLabel.font = [UIFont systemFontOfSize:14];
    [imageView addSubview:MyScorLabel];
    [MyScorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView.mas_left).offset(10);
        make.top.mas_equalTo(autoScrollLabel.mas_bottom).offset(5);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(20);
    }];
    
    UILabel *DetailLabel = [[UILabel alloc]init];
    DetailLabel.text = @"全民理财师，躺着把钱赚";
    DetailLabel.font = [UIFont systemFontOfSize:14];
    DetailLabel.textAlignment = NSTextAlignmentRight;
    [imageView addSubview:DetailLabel];
    [DetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(imageView.mas_right).offset(-10);
        make.top.mas_equalTo(autoScrollLabel.mas_bottom).offset(5);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(20);
    }];
    UILabel *myMoneyLabel = [[UILabel alloc]init];
    myMoneyLabel.backgroundColor = [UIColor whiteColor];
    if ([[MyDic objectForKey:@"assets"]doubleValue]) {
        // myMoneyLabel.text =[NSString stringWithFormat:@" 我的分成余额:%.2f元", [[MyDic objectForKey:@"assets"]floatValue]];
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" 我的分成余额:%.2f元", [[MyDic objectForKey:@"assets"]floatValue]]];
        // 需要改变的第一个文字的位置
        NSUInteger firstLoc = [[noteStr string] rangeOfString:@"额"].location+2;
        // 需要改变的最后一个文字的位置
        NSUInteger secondLoc = [[noteStr string] rangeOfString:@"元"].location+1;
        // 需要改变的区间
        NSRange range = NSMakeRange(firstLoc, secondLoc - firstLoc);
        // 改变颜色
        [noteStr addAttribute:NSForegroundColorAttributeName value:colorWithRGB(0.96, 0.6, 0.12) range:range];
        
        [myMoneyLabel setAttributedText:noteStr];
    }else{
        //myMoneyLabel.text =[NSString stringWithFormat:@"  我的分成余额:0元"];
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"  我的分成余额:0元"]];
        // 需要改变的第一个文字的位置
        NSUInteger firstLoc = [[noteStr string] rangeOfString:@"额"].location+2;
        // 需要改变的最后一个文字的位置
        NSUInteger secondLoc = [[noteStr string] rangeOfString:@"元"].location+1;
        // 需要改变的区间
        NSRange range = NSMakeRange(firstLoc, secondLoc - firstLoc);
        // 改变颜色
        [noteStr addAttribute:NSForegroundColorAttributeName value:colorWithRGB(0.96, 0.6, 0.12) range:range];
        
        [myMoneyLabel setAttributedText:noteStr];
    }
    myMoneyLabel.font = [UIFont systemFontOfSize:14];
    [imageView addSubview:myMoneyLabel];
    [myMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView.mas_left);
        make.top.mas_equalTo(MyScorLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(40);
    }];
    
    UIImageView *helpImageView = [[UIImageView alloc]init];
    helpImageView.image = [UIImage imageNamed:@"help_lcs"];
    helpImageView.userInteractionEnabled = YES;
    [imageView addSubview:helpImageView];
    [helpImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(imageView.mas_right).offset(-80);
        make.top.mas_equalTo(MyScorLabel.mas_bottom).offset(20);
        make.width.mas_equalTo(17);
        make.height.mas_equalTo(17);
    }];
    
    UITapGestureRecognizer *helpTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(HelpClick)];
    [helpImageView addGestureRecognizer:helpTap];
    
    UILabel *helpLabel = [[UILabel alloc]init];
    helpLabel.text = @"帮助";
    [imageView addSubview:helpLabel];
    [helpLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(helpImageView.mas_right);
        make.top.mas_equalTo(MyScorLabel.mas_bottom).offset(20);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(17);
    }];
    
    //里面有默认高度 等ScrollView的高度 //里面设置了背景颜色与tableview相同
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0)];
    
    
    vc.pageIndex = 0;
    
    vc.placeHoderView = footerView;
    vc.headerView = imageView;
    
    vc.dataSource = self;
    
    
    
    return vc;
    
}

- (void)HelpClick{
    HelpMoneyViewController  *MoreVC = [[HelpMoneyViewController alloc]init];
    [self presentViewController:MoreVC animated:YES completion:nil];
    
    
}
- (void)ComeClick{
    NSString *userID = NSuserUse(@"userId");
    NSString *tokenID = NSuserUse(@"Authorization");
    NSString *urlType = [NSString stringWithFormat:@"%@/brokers/%@/turn",HOST_URL,userID];
    
    [[DateSource sharedInstance]requestHomeWithParameters:nil withUrl:urlType withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
        if ([[result objectForKey:@"statusCode"]integerValue] == 201) {
            [self agreeClicked];
            normal_alert(@"提示", @"转入成功", @"确定");
        }else{
            NSString *message = [result objectForKey:@"message"];
            normal_alert(@"提示", message, @"确定");
            
        }
    }];
    
    
}
- (UITableView *)pageScrollViewController:(YNPageScrollViewController *)pageScrollViewController scrollViewForIndex:(NSInteger)index{
    
    YNTestBaseViewController *VC= (YNTestBaseViewController *)pageScrollViewController.currentViewController;
    return [VC tableView];
    
};

- (BOOL)pageScrollViewController:(YNPageScrollViewController *)pageScrollViewController headerViewIsRefreshingForIndex:(NSInteger)index{
    
    YNTestBaseViewController *VC= (YNTestBaseViewController *)pageScrollViewController.currentViewController;
    return [[[VC tableView] mj_header ] isRefreshing];
}

- (void)pageScrollViewController:(YNPageScrollViewController *)pageScrollViewController scrollViewHeaderAndFooterEndRefreshForIndex:(NSInteger)index{
    
    YNTestBaseViewController *VC= pageScrollViewController.viewControllers[index];
    [[[VC tableView] mj_header] endRefreshing];
    [[[VC tableView] mj_footer] endRefreshing];
}

- (NSArray *)getViewController{
    
    SepartViewController *one = [[SepartViewController alloc]init];
    
    OutViewController   *two = [[OutViewController alloc]init];
    
    
    return @[one,two];
}


- (void)AllTap{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[ThirdViewController  class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
    
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[ActivityDetailViewController  class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
