//
//  UIVDelegate.h
//  TestViewAction
//
//  Created by pc on 2018/7/31.
//  Copyright © 2018年 Jinchuncheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DaChuDelegate <NSObject>
@optional
- (void)tackCookAfterCookDone;  //菜做好了
-(void)takeWaterAfterCookDone;
@end

@interface UIVDelegate : UIView
@property (nonatomic, weak) id <DaChuDelegate> delegate;  //弱引导，防止循环调用
- (void)kaiShiZuoCai; //开始做菜
@end
