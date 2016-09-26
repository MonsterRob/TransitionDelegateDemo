//
//  viewControllerB.m
//  CustomPresentationDemo
//
//  Created by 王召洲 on 16/9/26.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#import "viewControllerB.h"
#import "AnimationManager.h"
@interface viewControllerB ()<UIViewControllerTransitioningDelegate>
{
    CGRect _rect;
}
@end

@implementation viewControllerB

- (instancetype)initWithSourceRect:(CGRect)rect
{
    self = [super init];
    if (self) {
        // 使用自定义的动画
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate = self;
        _rect = rect;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed: arc4random_uniform(256)/255.0  green:arc4random_uniform(256)/255.0 blue: arc4random_uniform(256)/255.0 alpha:1 ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
// 出场动画
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [AnimationManager customAnimationWithType:(CustomAnimationTypeDismiss) fromRect:_rect];
}
// 入场动画
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
    return [AnimationManager customAnimationWithType:(CustomAnimationTypePresent) fromRect:_rect];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
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
