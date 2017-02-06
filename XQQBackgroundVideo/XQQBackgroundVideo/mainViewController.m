//
//  mainViewController.m
//  XQQBackgroundVideo
//
//  Created by XQQ on 16/8/15.
//  Copyright © 2016年 UIP. All rights reserved.
//

#import "mainViewController.h"
#import "XQQBackgroundVieo.h"

#define iphoneWidth  [UIScreen mainScreen].bounds.size.width
#define iphoneHeight [UIScreen mainScreen].bounds.size.height

@interface mainViewController ()<UITextFieldDelegate>
/**
 *  背景
 */
@property (nonatomic,strong) XQQBackgroundVieo * backgroundVideo;
/**
 *  用户名
 */
@property(nonatomic, strong)  UITextField  *  userName;
/**
 *  密码
 */
@property(nonatomic, strong)  UITextField  *  password;

@end

@implementation mainViewController


- (void)viewDidLoad{
    [super viewDidLoad];
    /**
     添加视频背景
     */
    self.backgroundVideo = [[XQQBackgroundVieo alloc]initOnViewController:self withURL:@"test.mp4"];
    [self.backgroundVideo setBackground];
    /**
     * 添加输入框
     */
    _userName = [[UITextField alloc]initWithFrame:CGRectMake(30, 100, iphoneWidth - 60, 44)];
    _userName.textAlignment = NSTextAlignmentCenter;
    _userName.delegate = self;
    _userName.backgroundColor = [UIColor grayColor];
    _userName.placeholder = @"请输入用户名";
    _userName.alpha = 0.7;
    [self.view addSubview:_userName];
    
    _password = [[UITextField alloc]initWithFrame:CGRectMake(30, 160, iphoneWidth - 60, 44)];
    _password.textAlignment = NSTextAlignmentCenter;
    _password.delegate = self;
    _password.backgroundColor = [UIColor grayColor];
    _password.alpha = 0.7;
    _password.placeholder = @"请输入密码";
    [self.view addSubview:_password];
}


#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_password resignFirstResponder];
    [_userName resignFirstResponder];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
