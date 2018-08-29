//
//  DrawingMethod.m
//  TestViewAction
//
//  Created by pc on 2018/8/28.
//  Copyright © 2018年 Jinchuncheng. All rights reserved.
//

#import "DrawingMethod.h"

@implementation DrawingMethod
-(void)drawRect:(CGRect)rect
{
    CGRect frame = CGRectMake(50, 100, 100, 100);
    /*画填充圆
     */
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[UIColor whiteColor] set];
    
    // CGContextFillRect(context, rect);
    
    CGContextAddEllipseInRect(context, frame);
    [[UIColor orangeColor] set];
    CGContextFillPath(context);
    
    /*边框圆
     */
    CGContextSetRGBStrokeColor(context, 255/255.0, 106/255.0, 0/255.0, 1);
    CGContextSetLineWidth(context, 5);
    CGContextAddArc(context, 50, 70, 20, 0, 2*M_PI, 0);
    CGContextDrawPath(context, kCGPathStroke);
    
    /*画直线
     */
    CGRect markFrame = CGRectMake(100, 250, 200, 200);
    [[UIColor orangeColor] set];
    CGContextSetLineWidth(context, 4);
    CGPoint points[5];
    points[0] = CGPointMake(markFrame.origin.x,markFrame.origin.y);
    points[1] = CGPointMake(markFrame.origin.x+markFrame.size.width/4, markFrame.origin.y+markFrame.size.height/2);
    points[2] = CGPointMake(markFrame.origin.x+markFrame.size.width/2, markFrame.origin.y+5);
    points[3] = CGPointMake(markFrame.origin.x+markFrame.size.width/4*3,markFrame.origin.y+markFrame.size.height/2);
    points[4] = CGPointMake(markFrame.origin.x+markFrame.size.width, markFrame.origin.y);
    
    CGContextAddLines(context, points, 5);
    CGContextDrawPath(context, kCGPathStroke);
    //边框圆
    CGContextSetLineWidth(context, 5);
    CGContextAddArc(context, markFrame.origin.x+markFrame.size.width/2, markFrame.origin.y+markFrame.size.height/2, markFrame.size.height/2-2, 0, 2*M_PI, 0);
    CGContextDrawPath(context, kCGPathStroke);
    
    /*曲线
     */
    [[UIColor redColor] set];
    
    CGContextSetLineWidth(context, 4.0);
    CGContextSetStrokeColorWithColor(context, [UIColor orangeColor].CGColor);
    CGContextMoveToPoint(context, 300, 370);
    CGContextAddCurveToPoint(context,  193, 320, 100, 370, 100, 370);
    CGContextStrokePath(context);
    
    //画文字
    [self drawText:context];
    
}

-(void)CopyContextJustSave
{
    
    
    
}
-(void)drawText:(CGContextRef)context{
    
    
    //文字样式
    UIFont *font = [UIFont systemFontOfSize:18];
    NSDictionary *dict = @{NSFontAttributeName:font,
                           NSForegroundColorAttributeName:[UIColor blueColor]};
    
    [@"hello world" drawInRect:CGRectMake(120 , 60, 500, 50) withAttributes:dict];
    [@"金彭星 找到10个为什么了吗？" drawInRect:CGRectMake(20 , 20, 500, 50) withAttributes:dict];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
