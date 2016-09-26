//
//  ViewController.m
//  CustomPresentationDemo
//
//  Created by 王召洲 on 16/9/26.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#import "ViewController.h"
#import "viewControllerB.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    for (int i = 0; i < 3; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, 50, 80);
        btn.center = CGPointMake(30+ i* 60, 60);
        btn.backgroundColor = [UIColor colorWithRed: arc4random_uniform(256)/255.0  green:arc4random_uniform(256)/255.0 blue: arc4random_uniform(256)/255.0 alpha:1 ];
        [btn addTarget:self action:@selector(btnTaped:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:btn];
    }
}
-(void)btnTaped:(UIButton *)sender {
    CGRect rect = sender.frame;
    
    NSLog(@"frame --> %@",NSStringFromCGRect(rect));
    // 弹出第二个视图控制器
    
    viewControllerB *vc = [[viewControllerB alloc]initWithSourceRect:rect];
    
    [self presentViewController:vc animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
