//
//  LoginViewController.m
//  登录注册
//
//  Created by user2 on 16/5/17.
//  Copyright © 2016年 com.chenyang.www. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisteredViewController.h"
#import <BmobSDK/Bmob.h>

@interface LoginViewController ()<UITextFieldDelegate>
{
    
    UIButton *button;
    UITextField *textfield;
}
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"用户登录";
    self.view.backgroundColor =[UIColor colorWithRed:0.9077 green:0.908 blue:0.8715 alpha:1.0];
    [self  interface];
}

-(void)interface{
    
    UIImage *image = [UIImage imageNamed:@"log.jpg"];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(120, 100, 80, 80)];
    imageView.image = image;
    imageView.layer.cornerRadius = 40;
    imageView.layer.masksToBounds=YES;
    [self.view addSubview:imageView];
    
    NSArray *array = @[@"请输入手机号/账号",@"请输入密码"];
    for (int i =0; i<2; i++) {
        
      textfield = [[UITextField alloc]initWithFrame:CGRectMake(30, 230+60*i, (self.view.bounds.size.width)-60, 40)];
            textfield.borderStyle = UITextBorderStyleRoundedRect;
            textfield.clearButtonMode = UITextFieldViewModeWhileEditing;
            textfield.textAlignment = NSTextAlignmentLeft;
            textfield.backgroundColor = [UIColor whiteColor];
            textfield.placeholder = array[i];
            textfield.textColor = [UIColor blackColor];
            textfield.layer.cornerRadius =25;
            textfield.layer.masksToBounds = YES;
            textfield.delegate = self;
            textfield.tag = 200+i;
            [self.view addSubview:textfield];

        
        
    }
    switch (textfield.tag) {
        case 200:{
            
            textfield.keyboardType = UIKeyboardTypeNumberPad;
            break;
        }
        case 201:{
            
            textfield.secureTextEntry = YES;

            break;
        }

        default:
            break;
    }
    
//    //请输入手机号账号
//    UITextField *textfield = [[UITextField alloc]initWithFrame:CGRectMake(30, 230, (self.view.bounds.size.width)-60, 40)];
//    textfield.borderStyle = UITextBorderStyleRoundedRect;
//    textfield.clearButtonMode = UITextFieldViewModeWhileEditing;
//    textfield.textAlignment = NSTextAlignmentLeft;
//    textfield.backgroundColor = [UIColor whiteColor];
//    textfield.placeholder = @"请输入手机号";
//    textfield.textColor = [UIColor blackColor];
//    textfield.layer.cornerRadius =25;
//    textfield.layer.masksToBounds = YES;
//    textfield.delegate = self;
//    textfield.tag = 200;
//    [self.view addSubview:textfield];
//    
//    
//    //请输入密码
//    UITextField *textfield1 = [[UITextField alloc]initWithFrame:CGRectMake(30, 290, (self.view.bounds.size.width)-60, 40)];
//    textfield1.borderStyle = UITextBorderStyleRoundedRect;
//    textfield1.clearButtonMode = UITextFieldViewModeWhileEditing;
//    textfield1.textAlignment = NSTextAlignmentLeft;
//    textfield1.backgroundColor = [UIColor whiteColor];
//    textfield1.layer.cornerRadius =25;
//    textfield1.layer.masksToBounds = YES;
//    textfield1.placeholder = @"请输入密码";
//    textfield1.textColor = [UIColor blackColor];
//    textfield1.delegate = self;
//    textfield1.tag = 201;
//    [self.view addSubview:textfield1];

//    NSArray *array1 = @[@"新用户注册",@"找回密码"];
//    for (int k = 0; k<2; k++) {
//        
//        button = [UIButton buttonWithType:UIButtonTypeCustom];
//        button.frame = CGRectMake(30+150*k, 360, 100, 40);
//        button.backgroundColor = [UIColor colorWithRed:0.9888 green:0.6955 blue:0.2063 alpha:1.0];
//        [button setTitle:array1[k] forState:UIControlStateNormal];
//        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        button.layer.cornerRadius =20;
//        button.tag = 202+k;
//        button.layer.masksToBounds = YES;
//        button.titleLabel.font = [UIFont boldSystemFontOfSize:20];
//        [self.view addSubview:button];
//        [button  addTarget:self action:@selector(Registered) forControlEvents:UIControlEventTouchUpInside];
//
//    }
//    
//    switch (button.tag) {
//        case 202:{
//            //登录
//           [button  addTarget:self action:@selector(Registered) forControlEvents:UIControlEventTouchUpInside];
//            
//            
//            break;
//        }
//        case 203:{
//            //找回密码
//            [button  addTarget:self action:@selector(find:) forControlEvents:UIControlEventTouchUpInside];
//            
//            
//            break;
//        }
//
//        default:
//            break;
//    }
   
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(75, 360, 150, 40);
    button.backgroundColor = [UIColor colorWithRed:0.9888 green:0.6955 blue:0.2063 alpha:1.0];
    [button setTitle:@"登录" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.layer.cornerRadius =20;
    button.layer.masksToBounds = YES;
    button.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [self.view addSubview:button];
    [button  addTarget:self action:@selector(clickLogin:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(200, 320, 100, 40);
//    button1.backgroundColor = [UIColor colorWithRed:0.9888 green:0.6955 blue:0.2063 alpha:1.0];
    [button1 setTitle:@"找回密码" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button1.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    [self.view addSubview:button1];

    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 460, self.view.frame.size.width, 1)];
    view.backgroundColor = [UIColor colorWithRed:0.7434 green:0.7434 blue:0.7434 alpha:1.0];
    [self.view addSubview:view];
    
    
    UIBarButtonItem *right = [[UIBarButtonItem  alloc]initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(Registered)];
    right.tintColor = [UIColor blueColor];
    self.navigationItem.rightBarButtonItem = right;
    
}

//登录响应
- (void)clickLogin:(UIButton *)sender{
    
    UITextField *phoneNumberTF = [self.view viewWithTag:200];
    UITextField *pswTF = [self.view viewWithTag:201];
    [BmobUser loginInbackgroundWithAccount:phoneNumberTF.text andPassword:pswTF.text block:^(BmobUser *user, NSError *error) {
        
        
        if (user) {
            NSLog(@"登陆成功:%@",user);
            NSLog(@"%@",user.mobilePhoneNumber);
            
            UIAlertController *alect = [UIAlertController alertControllerWithTitle:@"登陆成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
            [alect addAction:[UIAlertAction actionWithTitle:@"回到首页" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setBool:YES forKey:@"isLogin"];
                
                [self.navigationController popToRootViewControllerAnimated:YES];
            }]];
            [self presentViewController:alect animated:YES completion:nil];
            
            
            
        }
        else{
            NSLog(@"%@",error);
            if (phoneNumberTF.text.length==0) {
                [self showAlectControllerWithTitle:@"提示" Message:@"用户名不能为空"];
            }
            if (pswTF.text.length==0) {
                [self showAlectControllerWithTitle:@"提示" Message:@"密码不能为空"];
            }
            [self showAlectControllerWithTitle:@"提示" Message:@"用户名或者密码错误"];
        }
    }];

    
}
- (void)showAlectControllerWithTitle:(NSString *)title Message:(NSString *)message {
    UIAlertController *alect = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alect addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alect animated:YES completion:nil];
}
-(void)find:(UIButton *)sender{
    
    
    
}
-(void)viewTapped:(UITapGestureRecognizer *)tap{
    
    
    [self.view endEditing:YES];
    
}

-(void)Registered{
    
    RegisteredViewController *registered = [[RegisteredViewController alloc]init];
    
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
    animation.type =kCATransitionReveal;
    [self.navigationController.view.layer  addAnimation:animation forKey:@"12"];
    [self.navigationController pushViewController:registered animated:YES];
    
    //
}
//取消输入框第一响应
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    return [textField resignFirstResponder];
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
