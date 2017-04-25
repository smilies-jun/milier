//
//  UserSetViewController.m
//  milier
//
//  Created by amin on 17/4/21.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "UserSetViewController.h"
#import "UserViewController.h"
#import "UserSetView.h"
#import "ModifyLoginViewController.h"
#import "ModifySailViewController.h"
#import <AwAlertViewlib/AwAlertViewlib.h>

@interface UserSetViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>{
    UserSetView *ImageSetView;
    UserSetView *PassSetView;
    UserSetView *SailSetView;
    UserSetView *BundSetView;
    UIImageView *YinHangImageView;
    UILabel *YinHangLabel;
    UILabel *SaleLabel;
    UILabel *SureLabel;
    AwAlertView *awlertView;
}

@end

@implementation UserSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"帐号设置";
    self.view.backgroundColor = [UIColor grayColor];
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(0, 7, 18, 18);
    [leftBtn setImage:[UIImage imageNamed:@"backarrow@2x.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(UserSetClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    [self ConfigUI];
}
- (void)ConfigUI{
    ImageSetView = [[UserSetView alloc]init];
    ImageSetView.userInteractionEnabled = YES;
    UITapGestureRecognizer *ImageTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ImageSetClick)];
    [ImageSetView addGestureRecognizer:ImageTap];
    [self.view addSubview:ImageSetView];
    [ImageSetView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self.view.mas_top).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(40);
    }];
    PassSetView = [[UserSetView alloc]init];
    UITapGestureRecognizer *LoginTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(LoginSetClick)];
    [PassSetView addGestureRecognizer:LoginTap];
    PassSetView.userInteractionEnabled = YES;
    [self.view addSubview:PassSetView];
    [PassSetView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(ImageSetView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(40);
    }];
    SailSetView = [[UserSetView alloc]init];
    SailSetView.userInteractionEnabled = YES;
    UITapGestureRecognizer *SailTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SailSetClick)];
    [SailSetView addGestureRecognizer:SailTap];
    [self.view addSubview:SailSetView];
    [SailSetView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(PassSetView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(40);
    }];
    BundSetView = [[UserSetView alloc]init];
    BundSetView.userInteractionEnabled = YES;
    UITapGestureRecognizer *BundTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(BundClick)];
    [BundSetView addGestureRecognizer:BundTap];
    [self.view addSubview:BundSetView];
    [BundSetView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(SailSetView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(40);
    }];
    SaleLabel = [[UILabel alloc]init];
    SaleLabel.text = @"退出账号";
    SaleLabel.userInteractionEnabled = YES;
    SaleLabel.backgroundColor = [UIColor orangeColor];
    SaleLabel.textAlignment = NSTextAlignmentCenter;
    SaleLabel.textColor = [UIColor whiteColor];
    SaleLabel.layer.cornerRadius = 10;
    SaleLabel.layer.masksToBounds = YES;
    [self.view addSubview:SaleLabel];
    [SaleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(40);
        make.top.mas_equalTo(BundSetView.mas_bottom).offset(20);
        make.width.mas_equalTo(SCREEN_WIDTH - 80);
        make.height.mas_equalTo(30);
    }];
    
    UITapGestureRecognizer *SaleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SetBackBtn
                                                                                                          )];
    [SaleLabel addGestureRecognizer:SaleTap];
}
-(void)BundClick{
    //绑定银行卡
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 320)];
    view.backgroundColor=[UIColor whiteColor];
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 5.0f;
    view.alpha = 0.9;
    UILabel *WarningLabel = [[UILabel alloc]init];
    WarningLabel.text = @"提示";
    WarningLabel.textColor = [UIColor orangeColor];
    WarningLabel.font = [UIFont systemFontOfSize:13];
    WarningLabel.frame = CGRectMake(10, 10, 40, 20);
    WarningLabel.textAlignment = NSTextAlignmentLeft;
    [view addSubview:WarningLabel];
    UIImageView *CanCelView = [[UIImageView alloc]init];
    CanCelView.image = [UIImage imageNamed:@"close"];
    CanCelView.frame = CGRectMake(SCREEN_WIDTH - 30, 10, 20, 20);
    [view addSubview:CanCelView];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor grayColor];
    lineView.frame = CGRectMake(0, 40, SCREEN_WIDTH, 1);
    [view addSubview:lineView];
    
    
    UIImageView *TiShiImageView = [[UIImageView alloc]init];
    TiShiImageView.image = [UIImage imageNamed:@"businessloans"];
    [view addSubview:TiShiImageView];
    [TiShiImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view.mas_centerX);
        make.top.mas_equalTo(lineView.mas_bottom).offset(40);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(60);
    }];
    
    UILabel *MessageLabel = [[UILabel alloc]init];
    MessageLabel.text = @"若需修改默认银行卡";
    MessageLabel.textAlignment = NSTextAlignmentCenter;
    MessageLabel.textColor = [UIColor orangeColor];
    MessageLabel.font = [UIFont systemFontOfSize:14];
    [view addSubview:MessageLabel];
    [MessageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(TiShiImageView.mas_centerX);
        make.top.mas_equalTo(TiShiImageView.mas_bottom).offset(10);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(30);
    }];
    
    UILabel *KeFuLabel = [[UILabel alloc]init];
    KeFuLabel.text = @"请联系客服400-6261-677";
    KeFuLabel.textAlignment = NSTextAlignmentCenter;
    KeFuLabel.textColor = [UIColor orangeColor];
    KeFuLabel.font = [UIFont systemFontOfSize:14];
    [view addSubview:KeFuLabel];
    [KeFuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(TiShiImageView.mas_centerX);
        make.top.mas_equalTo(MessageLabel.mas_bottom).offset(5);
        make.width.mas_equalTo(180);
        make.height.mas_equalTo(30);
    }];
    
    YinHangImageView = [[UIImageView alloc]init];
    YinHangImageView.image = [UIImage imageNamed:@"businessloans"];
    [view addSubview:YinHangImageView];
    [YinHangImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(KeFuLabel.mas_left);
        make.top.mas_equalTo(KeFuLabel.mas_bottom).offset(5);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
        
    }];
    YinHangLabel = [[UILabel alloc]init];
    YinHangLabel.text = @"工商银行（2098）";
    YinHangLabel.textColor = [UIColor blueColor];
    YinHangLabel.textAlignment = NSTextAlignmentLeft;
    YinHangLabel.font = [UIFont systemFontOfSize:13];
    [view addSubview:YinHangLabel];
    [YinHangLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(YinHangImageView.mas_right).offset(5);
        make.top.mas_equalTo(KeFuLabel.mas_bottom).offset(5);
        make.width.mas_equalTo(130);
        make.height.mas_equalTo(30);
    }];
    SureLabel = [[UILabel alloc]init];
    SureLabel.text = @"确定";
    SureLabel.userInteractionEnabled = YES;
    SureLabel.backgroundColor = [UIColor orangeColor];
    SureLabel.textAlignment = NSTextAlignmentCenter;
    SureLabel.textColor = [UIColor whiteColor];
    SureLabel.layer.cornerRadius = 10;
    SureLabel.layer.masksToBounds = YES;
    [view addSubview:SureLabel];
    [SureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(TiShiImageView.mas_centerX);
        make.top.mas_equalTo(YinHangLabel.mas_bottom).offset(20);
        make.width.mas_equalTo(SCREEN_WIDTH - 80);
        make.height.mas_equalTo(30);
    }];
    
    UITapGestureRecognizer *SureTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SureBackBtn
                                                                                                          )];
    [SureLabel addGestureRecognizer:SureTap];
    awlertView=[[AwAlertView alloc]initWithContentView:view];
    awlertView.hidden = NO;
    awlertView.isUseHidden=YES;
    [awlertView showAnimated:YES];
}
- (void)SureBackBtn{
    [awlertView dismissAnimated:NO];
    NSLog(@"3");
}
- (void)LoginSetClick{
   ModifyLoginViewController *loginVC = [[ModifyLoginViewController alloc]init];
   [self.navigationController   pushViewController:loginVC animated:NO];
}
- (void)SailSetClick{
    ModifySailViewController *SailVC = [[ModifySailViewController alloc]init];
    [self.navigationController   pushViewController:SailVC animated:NO];
}
- (void)ImageSetClick{
    /**
     *  弹出提示框
     */
    //初始化提示框
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    //按钮：从相册选择，类型：UIAlertActionStyleDefault
    [alert addAction:[UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //初始化UIImagePickerController
        UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
        //获取方式1：通过相册（呈现全部相册），UIImagePickerControllerSourceTypePhotoLibrary
        //获取方式2，通过相机，UIImagePickerControllerSourceTypeCamera
        //获取方法3，通过相册（呈现全部图片），UIImagePickerControllerSourceTypeSavedPhotosAlbum
        PickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //允许编辑，即放大裁剪
        PickerImage.allowsEditing = YES;
        //自代理
        PickerImage.delegate = self;
        //页面跳转
        [self presentViewController:PickerImage animated:YES completion:nil];
    }]];
    //按钮：拍照，类型：UIAlertActionStyleDefault
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        /**
         其实和从相册选择一样，只是获取方式不同，前面是通过相册，而现在，我们要通过相机的方式
         */
        UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
        //获取方式:通过相机
        PickerImage.sourceType = UIImagePickerControllerSourceTypeCamera;
        PickerImage.allowsEditing = YES;
        PickerImage.delegate = self;
        [self presentViewController:PickerImage animated:YES completion:nil];
    }]];
    //按钮：取消，类型：UIAlertActionStyleCancel
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}
//PickerImage完成后的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //定义一个newPhoto，用来存放我们选择的图片。
    UIImage *newPhoto = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    NSLog(@"new = %@",newPhoto);
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)SetBackBtn{
    NSLog(@"退出帐号");
}
- (void)UserSetClick{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[UserViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }

}
#pragma mark - 隐藏当前页面所有键盘-
- (void)HideKeyBoardClick{
    for (UIView *KeyView in self.view.subviews) {
        [self dismissAllKeyBoard:KeyView];
        
    }
    
}

- (BOOL)dismissAllKeyBoard:(UIView *)view{
    
    if([view isFirstResponder])
    {
        [view resignFirstResponder];
        return YES;
    }
    for(UIView *subView in view.subviews)
    {
        if([self dismissAllKeyBoard:subView])
        {
            return YES;
        }
    }
    return NO;
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
