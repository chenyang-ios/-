//
//  ViewController.m
//  登录注册
//
//  Created by user2 on 16/5/17.
//  Copyright © 2016年 com.chenyang.www. All rights reserved.
//
/*
 kCATransitionFade 交叉淡化过渡
 kCATransitionMoveIn 新视图移到旧视图上面
 kCATransitionPush 新视图把旧视图推出去
 kCATransitionReveal 将旧视图移开,显示下面的新视图
 私有api
 
 pageCurl 向上翻一页
 pageUnCurl 向下翻一页
 rippleEffect 滴水效果
 suckEffect 收缩效果 如一块布被抽走
 cube 立方体效果
 oglFlip 上下翻转效果
 startProgress 开始的进度（0-1）（从那个开始）
 endProgress 结束的进度（0-1）
 

 */
#import "ViewController.h"
#import "LoginViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.frame = CGRectMake(200, 300, 100, 50);
    button.center = self.view.center;
    [button setTitle:@"登录" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor orangeColor];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(Login) forControlEvents:UIControlEventTouchUpInside];
    
    
   }

-(void)Login{
    

    LoginViewController *login = [[LoginViewController alloc]init];
        CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
    animation.type =kCATransitionReveal;
    [self.navigationController.view.layer  addAnimation:animation forKey:@"12"];
    [self.navigationController pushViewController:login animated:YES];
    


    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
