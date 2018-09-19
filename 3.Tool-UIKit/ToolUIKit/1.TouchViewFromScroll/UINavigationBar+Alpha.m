//
//  UINavigationBar+Alpha.m
//  TestViewAction
//
//  Created by pc on 2018/7/30.
//  Copyright © 2018年 Jinchuncheng. All rights reserved.
//

#import "UINavigationBar+Alpha.h"
#define IOS10 [[[UIDevice currentDevice]systemVersion] floatValue] >= 10.0
@implementation UINavigationBar (Alpha)

static char *navAlphaKey = "navAlphaKey";
//public参数必须设定set与get, 因在category不好调用数值设定getter时的返回值，需要用到objc_setAssociated, 也要加#import "objc/runtime.h"
//这个get,就是为了成立public属性，作用是没有
-(CGFloat)navAlpha {
    if (objc_getAssociatedObject(self, navAlphaKey) == nil) {
        return 1;
    }
    return [objc_getAssociatedObject(self, navAlphaKey) floatValue];
}
-(void)setNavAlpha:(CGFloat)navAlpha {
    CGFloat alpha = MAX(MIN(navAlpha, 1), 0);// 必须在 0~1的范围
    
    UIView *barBackground = self.subviews[0];
    if (self.translucent == NO || [self backgroundImageForBarMetrics:UIBarMetricsDefault] != nil) {
        barBackground.alpha = alpha;
        
    } else {
        
        if (IOS10) {
            UIView *effectFilterView = barBackground.subviews.lastObject;
            effectFilterView.alpha = alpha;
        } else {
            UIView *effectFilterView = barBackground.subviews.firstObject;
            effectFilterView.alpha = alpha;
        }
    }
    /// 黑线
    UIImageView *shadowView = [barBackground valueForKey:@"_shadowView"];
    if (alpha < 0.01) {
        shadowView.hidden = YES;
    } else {
        shadowView.hidden = NO;
        shadowView.alpha = alpha;
    }
    
    objc_setAssociatedObject(self, navAlphaKey, @(alpha), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end
