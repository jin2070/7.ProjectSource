//
//  UIScrollView+TouchDraw.m
//  TestViewAction
//
//  Created by pc on 2018/7/30.
//  Copyright © 2018年 Jinchuncheng. All rights reserved.
//

#import "UIScrollView+TouchDraw.h"

@implementation UIScrollView (TouchDraw)
static char *moveKey="moveKey";
-(CGPoint)FscrollMovepoint
{
    
    if(objc_getAssociatedObject(self, moveKey)==nil)
    {
        return CGPointZero;
        
    }
    
    return [objc_getAssociatedObject(self, moveKey) CGPointValue];
}
-(void)setFscrollMovepoint:(CGPoint)FscrollMovepoint
{
    CGPoint movePoint=FscrollMovepoint;
  //  NSLog(@"movepoint %f",movePoint.y);
    objc_setAssociatedObject(self, moveKey, @(movePoint), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self nextResponder] touchesMoved:touches withEvent:event];
    [super touchesMoved:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    // 获取目前的点和，上一个点位置
    CGPoint currentPoint = [touch locationInView:self];
    CGPoint prePoint = [touch previousLocationInView:self];
    CGFloat offsetX = currentPoint.x - prePoint.x;
    CGFloat offsetY = currentPoint.y - prePoint.y;
    self.FscrollMovepoint=CGPointMake(offsetX, offsetY);
    
    //CGPoint preP=[touch pr]
    //NSLog(@"move:f%f",self.FscrollMovepoint.y);
    
    //通知启动
    // 1.添加字典, 将数据包到字典中
    NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:@"name",@"xiaoming",@"111401",@"number", nil];
    
    // 2.创建通知
    //通知的名字是key,必须通知与接听一致，userInfo可以设置为nil;
    NSNotification *notification =[NSNotification notificationWithName:@"NotiAnyname" object:nil userInfo:dict];
    //    NSNotification *nohell=[NSNotification notificationWithName:@"hell" object:<#(nullable id)#>]
    // 3.通过 通知中心 发送 通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}
-(void)PrintTest
{
  //  NSLog(@"why is value");
}

@end
