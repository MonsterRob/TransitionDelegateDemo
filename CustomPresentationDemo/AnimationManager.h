//
//  AnimationManager.h
//  CustomPresentationDemo
//
//  Created by 王召洲 on 16/9/26.
//  Copyright © 2016年 wyzc. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,CustomAnimationType){
    CustomAnimationTypePresent=0,
    CustomAnimationTypeDismiss,
    
};

@interface AnimationManager : NSObject<UIViewControllerAnimatedTransitioning>

+ (instancetype)customAnimationWithType:(CustomAnimationType)type fromRect:(CGRect)rect;

@end
