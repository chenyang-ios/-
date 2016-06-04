//
//  RegisteredViewController.m
//  登录注册
//
//  Created by user2 on 16/5/18.
//  Copyright © 2016年 com.chenyang.www. All rights reserved.
//

#import "RegisteredViewController.h"
#import <BmobSDK/Bmob.h>

@interface RegisteredViewController ()<UITextFieldDelegate>
{
     UITextField *registerTextField;//注册输入框
     int  time;//更新验证码时间
     NSTimer *timer;//更新验证码定时器
}
@end

@implementation RegisteredViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"注册";
    self.view.backgroundColor = [UIColor  colorWithRed:0.9077 green:0.908 blue:0.8715 alpha:1.0];
    
    time = 60;
    [self interface];
    
}
-(void)interface{
    
    NSArray *placeholderList = @[@"输入手机号",@"输入验证码",@"输入密码",@"确认密码",@"输入验证码"];
    for (int i = 0; i<4; i++) {
        
        UIImageView *leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        leftImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"register%d",i]];
        //图片自适应
        leftImageView.contentMode = UIViewContentModeScaleAspectFit;
        
        
        registerTextField = [[UITextField alloc]initWithFrame:CGRectMake(30, 150+45*i, (self.view.bounds.size.width)-60, 40)];
        registerTextField.borderStyle = UITextBorderStyleRoundedRect;
        registerTextField.placeholder = placeholderList[i];
        registerTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        registerTextField.leftView = leftImageView;
        registerTextField.layer.cornerRadius =20;
        registerTextField.layer.masksToBounds = YES;
        registerTextField.leftViewMode = UITextFieldViewModeAlways;
        registerTextField.tag = 100+i;
        registerTextField.delegate = self;
        
        switch (registerTextField.tag) {
            case 102:{
                
                registerTextField.secureTextEntry = YES;
                registerTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
                break;
            }
               
            case 103:{
                
                registerTextField.secureTextEntry = YES;
                registerTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
                break;
            }
            case 101:{
                
                registerTextField.keyboardType = UIKeyboardTypeNumberPad;
                
                UIButton *securityButton = [UIButton buttonWithType:UIButtonTypeCustom];
                securityButton.frame = CGRectMake(0, 0, 120, 40);
                [securityButton setTitle:@"获取验证码" forState:UIControlStateNormal];
                [securityButton setTitleColor:[UIColor colorWithRed:0.894 green:0.400 blue:0.216 alpha:1.000] forState:UIControlStateNormal];
                [securityButton addTarget:self action:@selector(clickSecurity:) forControlEvents:UIControlEventTouchUpInside];
                securityButton.tag = 105;
                registerTextField.rightView = securityButton;
                registerTextField.rightViewMode = UITextFieldViewModeAlways;
                
                break;
            }

            default:
                break;
        }
        
        [self.view addSubview:registerTextField];
    }
    
    
    UIButton *submitButton = [UIButton  buttonWithType:UIButtonTypeCustom];
    submitButton.frame = CGRectMake(100, 350, (self.view.frame.size.width)-180, 40);
    submitButton.backgroundColor = [UIColor colorWithRed:0.9888 green:0.6955 blue:0.2063 alpha:1.0];
    submitButton.layer.cornerRadius  = 20;
    
    submitButton.layer.masksToBounds = YES;
    
    [submitButton setTitle:@"一键注册并登陆" forState:UIControlStateNormal];
    
    [submitButton  addTarget:self action:@selector(clicksubmit:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:submitButton];
    
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewTapped:)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
    
    
}
//推键盘
-(void)viewTapped:(UITapGestureRecognizer *)tap{
    
    
    [self.view endEditing:YES];
    
}
- (void)clicksubmit:(UIButton *)sender{

    UITextField *phoneNumberTF = [self.view viewWithTag:100];
     UITextField *securityTF = [self.view viewWithTag:101];
    UITextField *pswTF = [self.view viewWithTag:102];
    UITextField *repswTF = [self.view viewWithTag:103];
  
   
   
    pswTF.text.length==0?[self showAlectControllerWithTitle:@"提示" Message:@"请输入密码"]:nil;
    repswTF.text!=pswTF.text?[self showAlectControllerWithTitle:@"提示" Message:@"二次密码输入不一致 请重新输入"]:nil;
    phoneNumberTF.text.length!=11?[self showAlectControllerWithTitle:@"提示  " Message:@"请输入正确的11位手机号码"]:nil;
    securityTF.text.length!=6?[self showAlectControllerWithTitle:@"提示" Message:@"请输入6位验证码"]:nil;
    
    
    BmobUser  *buser = [[BmobUser alloc]init];
    buser.password = repswTF.text;
    buser.mobilePhoneNumber = phoneNumberTF.text;
    //一键注册并登录
    [buser signUpOrLoginInbackgroundWithSMSCode:securityTF.text block:^(BOOL isSuccessful, NSError *error) {
        if (!error) {
            NSLog(@"一键注册登陆成功");
            UIAlertController *alect = [UIAlertController alertControllerWithTitle:@"注册登陆成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
            [alect addAction:[UIAlertAction actionWithTitle:@"回到首页" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                
                [defaults setBool:YES forKey:@"isLogin"];
                
                [self.navigationController popToRootViewControllerAnimated:YES];
                
            }]];
            [self presentViewController:alect animated:YES completion:nil];
        }else{
            NSLog(@"注册时的错误信息%@",error);
            
            [self showAlectControllerWithTitle:@"提示" Message:@"注册失败 请核验验证码"];
            
        }
        
    }];

    
}
- (void)showAlectControllerWithTitle:(NSString *)title Message:(NSString *)message{
    
    UIAlertController *alect = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alect addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alect animated:YES completion:nil];
    
}
//验证码响应
- (void)clickSecurity:(UIButton *)sender{
    
    sender.userInteractionEnabled = NO;
    sender.selected = YES;
    
    UITextField *phoneNumberTF = [self.view viewWithTag:100];
    
    //请求验证码
    
    [BmobSMS requestSMSCodeInBackgroundWithPhoneNumber:phoneNumberTF.text andTemplate:nil resultBlock:^(int number, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
            [self showAlectControllerWithTitle:@"获取验证码失败" Message:[NSString stringWithFormat:@"%@",error]];
        } else {
            [self showAlectControllerWithTitle:@"获取验证码成功" Message:nil];
            timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTitle) userInfo:nil repeats:YES];
            [timer fire];

            
        }
    }];

    
    
    
    
  
    
}
-(void)updateTitle{
    
    UIButton *button = [self.view viewWithTag:105];
    
    if (time ==0) {
        
        time = 60;
        
        button.userInteractionEnabled = YES;
        button.selected = NO;
        
        [timer invalidate];
        
        return;
        
    }
    
    [button  setTitle:[NSString  stringWithFormat:@"请%d秒后重试",time] forState:UIControlStateSelected];
    
    time--;
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
