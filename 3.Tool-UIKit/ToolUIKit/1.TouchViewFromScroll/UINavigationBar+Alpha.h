//
//  UINavigationBar+Alpha.h
//  TestViewAction
//
//  Created by pc on 2018/7/30.
//  Copyright © 2018年 Jinchuncheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@interface UINavigationBar (Alpha)
//设定public透明参数与外界联系
@property (nonatomic, assign) CGFloat navAlpha;
@end
