//
//  AnimationManager.m
//  CustomPresentationDemo
//
//  Created by 王召洲 on 16/9/26.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#import "AnimationManager.h"

@interface AnimationManager ()
{
    CustomAnimationType _type;
    CGRect sourceRect;
}
@end

@implementation AnimationManager

-(instancetype)initWithAnimationWithType:(CustomAnimationType)type fromRect:(CGRect)rect {
    self = [super init];
    
    if (self) {
        _type = type;
        sourceRect = rect;
    }
    return self;
}
+(instancetype)customAnimationWithType:(CustomAnimationType)type fromRect:(CGRect)rect {
    
    AnimationManager *manager = [[self alloc]initWithAnimationWithType:type fromRect:rect];
    return manager;
}
#pragma mark -必须要实现的方法 两个
/**
 *  返回动画时间
 *
 *  @param transitionContext 动画上下文
 *
 *  @return 时间
 */
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    return _type == CustomAnimationTypePresent ? 0.3:0.2;
}
/**
 *  对动画上下文操作，完成动画
 *
 *  @param transitionContext <#transitionContext description#>
 */
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    switch (_type) {
        case CustomAnimationTypePresent:
            [self handlePresentAnimation:transitionContext];
            break;
        case CustomAnimationTypeDismiss:
            [self handleDismissAnimation:transitionContext];
            break;
        default:
            break;
    }
}
// 入场动画
-(void)handlePresentAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    // 获取转场前后的两个控制器对象
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    // 创建快照
    UIView *snapShot = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    snapShot.frame = fromVC.view.frame;
    snapShot.tag = 1;
    fromVC.view.hidden = YES;
    NSLog(@"snapshot ->  %@",snapShot);
    
    [containerView addSubview:snapShot];
    [containerView addSubview:toVC.view];
    
    toVC.view.frame = sourceRect;
    
    // 具体动画
   // [UIView animateWithDuration:<#(NSTimeInterval)#> delay:<#(NSTimeInterval)#> usingSpringWithDamping:<#(CGFloat)#> initialSpringVelocity:<#(CGFloat)#> options:<#(UIViewAnimationOptions)#> animations:<#^(void)animations#> completion:<#^(BOOL finished)completion#>]
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        
        toVC.view.frame = CGRectMake(0, 300, [UIScreen mainScreen].bounds.size.width, 200);
        toVC.view.transform = CGAffineTransformMakeRotation(M_PI_4);
        snapShot.transform = CGAffineTransformMakeScale(0.9, 0.92);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
        //
    }];
    
    
    
    
}
// 出场动画
-(void)handleDismissAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    // 获取快照
    UIView *snapShot = [containerView viewWithTag:1];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        snapShot.transform = CGAffineTransformIdentity;
        fromVC.view.frame = sourceRect;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
        
        toVC.view.hidden = NO;
        [snapShot removeFromSuperview];
    }];
    
    
}
@end
