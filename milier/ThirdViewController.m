//
//  ThirdViewController.m
//  milier
//
//  Created by amin on 17/2/21.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "ThirdViewController.h"
#import "CustomMoreView.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>


@interface ThirdViewController (){
    CustomMoreView *AboutUsView;
    CustomMoreView *SafeView;
    CustomMoreView *NewPersonView;
    CustomMoreView *HelpView;
    CustomMoreView *AllView;
    CustomMoreView *ShareView;
    CustomMoreView *DuiHuanView;
    CustomMoreView *TellUsView;
}

@end

@implementation ThirdViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"个人";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"更多";
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor blackColor]}];
    self.view.backgroundColor = colorWithRGB(0.97, 0.97, 0.97);
    [self ConfigUI];
}
- (void)ConfigUI{
    AboutUsView = [[CustomMoreView alloc]init];
    AboutUsView.NameLabel.text = @"关于我们";
    AboutUsView.StaticImageView.image = [UIImage imageNamed:@"about"];
    [self.view addSubview:AboutUsView];
    [AboutUsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self.view.mas_top).offset(74);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(40);
    }];
    
    SafeView  = [[CustomMoreView alloc]init];
    SafeView.StaticImageView.image = [UIImage imageNamed:@"safe"];

    SafeView.NameLabel.text = @"安全保障";
    [self.view addSubview:SafeView];
    [SafeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(AboutUsView.mas_bottom).offset(0.5);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(40);
    }];
    
    NewPersonView  = [[CustomMoreView alloc]init];
    NewPersonView.StaticImageView.image = [UIImage imageNamed:@"novice"];

    NewPersonView.NameLabel.text = @"新手指引";
    [self.view addSubview:NewPersonView];
    [NewPersonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(SafeView.mas_bottom).offset(0.5);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(40);
    }];
    HelpView  = [[CustomMoreView alloc]init];
    HelpView.StaticImageView.image = [UIImage imageNamed:@"help"];

    HelpView.NameLabel.text = @"投资帮助";
    [self.view addSubview:HelpView];
    [HelpView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(NewPersonView.mas_bottom).offset(0.5);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(40);
    }];
    AllView   = [[CustomMoreView alloc]init];
    AllView.StaticImageView.image = [UIImage imageNamed:@"financing"];

    AllView.NameLabel.text = @"全民理财师";
    [self.view addSubview:AllView];
    [AllView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(HelpView.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(40);
    }];
    ShareView  = [[CustomMoreView alloc]init];
    ShareView.StaticImageView.image = [UIImage imageNamed:@"share"];
    ShareView.userInteractionEnabled = YES;
    UITapGestureRecognizer *shareTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ShareClick)];
    [ShareView addGestureRecognizer:shareTap];
    ShareView.NameLabel.text = @"分享领礼包";
    [self.view addSubview:ShareView];
    [ShareView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(AllView.mas_bottom).offset(0.5);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(40);
    }];
    DuiHuanView  = [[CustomMoreView alloc]init];
    DuiHuanView.StaticImageView.image = [UIImage imageNamed:@"gift"];

    DuiHuanView.NameLabel.text = @"积分换礼品";
    [self.view addSubview:DuiHuanView];
    [DuiHuanView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(ShareView.mas_bottom).offset(0.5);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(40);
    }];
    TellUsView  = [[CustomMoreView alloc]init];
    TellUsView.StaticImageView.image = [UIImage imageNamed:@"feedback"];

    TellUsView.NameLabel.text = @"意见反馈";
    [self.view addSubview:TellUsView];
    [TellUsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(DuiHuanView.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(40);
    }];
    
    
}


-(void)ShareClick{
    //先构造分享参数：
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                     images:@[[UIImage imageNamed:@"erweima"]]
                                        url:[NSURL URLWithString:@"http://mob.com"]
                                      title:@"分享标题"
                                       type:SSDKContentTypeAuto];
    //有的平台要客户端分享需要加此方法，例如微博
    [shareParams SSDKEnableUseClientShare];
    //调用分享的方法
    SSUIShareActionSheetController *sheet = [ShareSDK showShareActionSheet:self.view
                                                                     items:nil
                                                               shareParams:shareParams
                                                       onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                                                           switch (state) {
                                                               case SSDKResponseStateSuccess:
                                                                   NSLog(@"分享成功!");
                                                                   break;
                                                               case SSDKResponseStateFail:
                                                                   NSLog(@"分享失败%@",error);
                                                                   break;
                                                               case SSDKResponseStateCancel:
                                                                   NSLog(@"分享已取消");
                                                                   break;
                                                               default:
                                                                   break;
                                                           }
                                                       }];
    //删除和添加平台示例
    //[sheet.directSharePlatforms removeObject:@(SSDKPlatformTypeWechat)];//(默认微信，QQ，QQ空间都是直接跳客户端分享，加了这个方法之后，可以跳分享编辑界面分享)
    [sheet.directSharePlatforms addObject:@(SSDKPlatformTypeSinaWeibo)];//（加了这个方法之后可以不跳分享编辑界面，直接点击分享菜单里的选项，直接分享）
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
