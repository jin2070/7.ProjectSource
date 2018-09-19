//
//  UIViewController+Alpha.h
//  TestViewAction
//
//  Created by pc on 2018/7/30.
//  Copyright © 2018年 Jinchuncheng. All rights reserved.
//

#import <UIKit/UIKit.h>
//增加UIViewController的功能，

@interface UINavigationController (Alpha)

@end

@interface UIViewController (Alpha)
// navAlpha
@property (nonatomic, assign) CGFloat navAlpha;

// navbackgroundColor
@property (null_resettable, nonatomic, strong) UIColor *navBarTintColor;

// tintColor
@property (null_resettable, nonatomic, strong) UIColor *navTintColor;

// titleColor
@property (null_resettable, nonatomic, strong) UIColor *navTitleColor;


-(void)PrintWord;
@end
