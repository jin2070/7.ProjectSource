//
//  UIViewController+Alpha.m
//  TestViewAction
//
//  Created by pc on 2018/7/30.
//  Copyright © 2018年 Jinchuncheng. All rights reserved.
//
//增加UIViewController的功能，
#import "UIViewController+Alpha.h"
#import "UINavigationBar+Alpha.h"

//重新设定ControllView下面的UINavigationController.
@implementation UINavigationController (Alpha)
/// UINavigationBar
-(void)navigationBar:(UINavigationBar *)navigationBar didPopItem:(UINavigationItem *)item {
    navigationBar.tintColor = self.topViewController.navTintColor;
    navigationBar.barTintColor = self.topViewController.navBarTintColor;
    navigationBar.navAlpha = self.topViewController.navAlpha;
}
-(BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPushItem:(UINavigationItem *)item {
    navigationBar.tintColor = self.topViewController.navTintColor;
    navigationBar.barTintColor = self.topViewController.navBarTintColor;
    navigationBar.navAlpha = self.topViewController.navAlpha;
    return YES;
}
 
//-(void)navigationBar:(UINavigationBar *)navigationBar didPopItem:(nonnull UINavigationItem *)item

@end

#pragma mark - UIViewController + NavAlpha
//---设定objec_set的key值，都是为了，设定getter时，调用本来设定的值。
//--public参数必须设定set与get, 因在category不好调用数值设定getter时的返回值，需要用到objc_setAssociated, 也要加#import "objc/runtime.h"
static char *vcAlphaKey = "vcAlphaKey";
static char *vcColorKey = "vcColorKey";
static char *vcNavtintColorKey = "vcNavtintColorKey";
static char *vcTitleColorKey = "vcTitleColorKey";

static char *overViewKey="overViewKey  afasfdkalksdfafa";
static char *overViewKeySecond="qwrtfalk asdfkajsdf;ja";

@implementation UIViewController (Alpha)

-(CGFloat)navAlpha {
    if (objc_getAssociatedObject(self, vcAlphaKey) == nil) {
        return 1;
    }
    return [objc_getAssociatedObject(self, vcAlphaKey) floatValue];
}
-(UIColor *)navBarTintColor {
    UIColor *color = objc_getAssociatedObject(self, vcColorKey);
    if (color == nil) {
        color = [UINavigationBar appearance].barTintColor;
    }
    return color;
}
-(UIColor *)navTintColor {
    UIColor *color = objc_getAssociatedObject(self, vcNavtintColorKey);
    if (color == nil) {
        color = [UINavigationBar appearance].tintColor;
    }
    return color;
}
- (UIColor *)navTitleColor {
    UIColor *color = objc_getAssociatedObject(self, vcTitleColorKey);
    
    if (color == nil) {
  //      self.navigationController.navigationBar.titleTextAttributes
        color = self.navigationController.navigationBar.titleTextAttributes[NSForegroundColorAttributeName];
    }
    return color;
}

-(void)setNavAlpha:(CGFloat)navAlpha {
    CGFloat alpha = MAX(MIN(navAlpha, 1), 0);// 0~1
    self.navigationController.navigationBar.navAlpha = alpha;
    objc_setAssociatedObject(self, vcAlphaKey, @(alpha), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/// backgroundColor

-(void)setNavBarTintColor:(UIColor *)navBarTintColor {
    self.navigationController.navigationBar.barTintColor = navBarTintColor;
    objc_setAssociatedObject(self, vcColorKey, navBarTintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/// tintColor

-(void)setNavTintColor:(UIColor *)tintColor {
    self.navigationController.navigationBar.tintColor = tintColor;
    objc_setAssociatedObject(self, vcNavtintColorKey, tintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// titleColor


- (void)setNavTitleColor:(UIColor *)navTitleColor {
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = navTitleColor;
    [self.navigationController.navigationBar setTitleTextAttributes:textAttrs];
    objc_setAssociatedObject(self, vcTitleColorKey, navTitleColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
   // NSLog(@"navTitleColor %@,title %@",self,navTitleColor);
  //  UIColor *color = objc_getAssociatedObject(self, vcTitleColorKey);
  //  NSLog(@"navTitleColor %@,title %@",self,color);
}


-(void)PrintWord
{
 
    NSArray *arr = [[NSArray alloc] initWithObjects:@"one",@"two",@"three",@"four", nil];
    NSString *overViewString = @"hello world"; // [NSString stringWithFormat:@"%@,%@",@"five",@"six"];
    NSArray *overView = [[NSArray alloc] initWithObjects:@"Forest",@"Mountan",@"lake",@"sea", nil];
    // 设置关联对象
     objc_setAssociatedObject(arr, &overViewKey, overView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
 
    //NSLog(@"%@==%@",arr,overView); // 正常打印结果 ,如果arr 没有被释放,就算overView被释放了, 也可以用到 overView.因为它们两关联起来了
    
    // 上面已经将 arr 和 overView 关联上了, 在这里 通过 objc_getAssociatedObject :arr , 和关键字 overViewKey ,将关联对象获取出来
//    NSString *associatedObj = objc_getAssociatedObject(arr, &overViewKey);
  //  NSLog(@"associatedObj:%@",associatedObj); // 打印结果: associatedObj:five,six
    
    // 释放 关联对象
    // 第三个参数, 设为 nil, 则将 arr 与 nil 关联... 也等同于 : 没关联任何对象
    objc_setAssociatedObject(arr, &overViewKeySecond, overViewString, OBJC_ASSOCIATION_ASSIGN);
   // NSString *associatedObjb = objc_getAssociatedObject(arr, &overViewKeySecond);
   // NSLog(@"associatedObj:%@",associatedObjb); // 打印结果: associatedObj:five,six
    // 移除 所有关联对象 : 这个方法 相当于 初始化 arr 对象一样(并不是初始化arr这个指针所指向的内存地址)
    objc_removeAssociatedObjects(arr);
   // NSString *associatedObjc = objc_getAssociatedObject(arr, &overViewKey);
    //NSLog(@"associatedObj:%@",associatedObjc); // 打印结果: associatedObj:five,six
  //  NSLog(@"this is function from category");
}
 
@end
