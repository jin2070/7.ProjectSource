//
//  TouchViewFunction.m
//  TestViewAction
//
//  Created by pc on 2018/7/19.
//  Copyright © 2018年 Jinchuncheng. All rights reserved.
//

#import "TouchViewFunction.h"
#import "TouchScrollViewFunction.h"
@interface TouchViewFunction()<UIScrollViewDelegate>
@property(nonatomic)CGPoint beginPoint;
@property(nonatomic,strong)UIScrollView *scrollView;
@end

@implementation TouchViewFunction

#pragma  mark -touch



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    UITouch *touch=[touches anyObject];
    self.beginPoint=[touch locationInView:self];
    NSLog(@"can i send a messege");
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
   // [[self nextResponder] touchesMoved:touches withEvent:event];
    UITouch *touch = [touches anyObject];
   
    CGPoint currentLocation = [touch locationInView:self];
    CGRect frame = self.frame;
    frame.origin.x += currentLocation.x - self.beginPoint.x;
    frame.origin.y += currentLocation.y - self.beginPoint.y;
    self.frame = frame;
}

#pragma  mark -init scrollview
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initialize];
    }
    return self;
}
- (void)initialize {
    self.beginPoint=CGPointMake(0, 0);
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 50, 300, 120)];
    self.scrollView.backgroundColor = [UIColor yellowColor];
    self.scrollView.delaysContentTouches=NO;
  //  UIView *subView=[[UIView alloc] initWithFrame:CGRectMake(0, 50, 600, 130)];
  //  subView.backgroundColor=[UIColor blueColor];
 //   [scrollView addSubview:subView];
    
    // 1. 默认 CGSizeZero == CGSizeMake(0, 0)
    // contentSize 设置可以滚动的范围
    
    self.scrollView.contentSize = CGSizeMake(1000, 1000);
   /*
    // 2. 默认 CGPointZero
    // contentOffset 偏移量, 滚动的位置
    // 不设置contentSize, contentOffset也可以改变
    // 问题: 改变contentOffset什么变了?
    // 答案: 改变contentOffset, 实质上是对scrollView的bounds进行了改变.(改变子视图的坐标)
    NSLog(@"scrollView frame is : %@", NSStringFromCGRect(scrollView.frame));
    NSLog(@"scrollView bounds is : %@", NSStringFromCGRect(scrollView.bounds));
    scrollView.contentOffset = CGPointMake(0, 20);
    NSLog(@"scrollView frame is : %@", NSStringFromCGRect(scrollView.frame));
    NSLog(@"scrollView bounds is : %@", NSStringFromCGRect(scrollView.bounds));
    */
    /*
    // 3. contentInset
    // 添加滚动区域四周的滚动范围
    // UIEdgeInsets age = {10, 10, 10, 10};
    scrollView.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
    // 4. directionalLockEnabled
    
    // 锁定垂直或水平滚动(45度角, 锁会失效)
    scrollView.directionalLockEnabled = YES;
    
    // 5. bounces 回弹效果
    // 边缘弹动动画关闭 NO
    // scrollView.bounces = NO;
    // 6. alwaysBounceVertical 在没有垂直方向的滚动范围时(0), 保证垂直方向的回弹效果
    
    scrollView.alwaysBounceVertical = YES;
    // 7. alwaysBounceHorizontal 在没有水平方向的滚动范围时(0), 保证垂直方向的回弹效果
    scrollView.alwaysBounceHorizontal = YES;
    // 8. pagingEnabled 按页滚动
   
    scrollView.pagingEnabled = YES;
    // 9. scrollEnabled 滚动视图能否滚动, 默认为YES, NO(不可以滚)
    scrollView.scrollEnabled = YES;
    // 10. showsHorizontalScrollIndicator 是否显示水平滚动指示器
    scrollView.showsHorizontalScrollIndicator = YES;
    // 11. showsVerticalScrollIndicator 是否显示垂直滚动的指示器
    scrollView.showsVerticalScrollIndicator = YES;
    // 12. 滚动指示器的边距
    scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 100, 0, 0);
    // 13. indicatorStyle 滚动指示器的颜色(深色背景丶浅色背景)
    scrollView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
    // 14.
    // scrollView.tracking 用户有没有开始拖动
    // scrollView.tracking
    // scrollView.dragging 用户是否正在拖动
    // scrollView.dragging
    // scrollView.decelerating 是否减速中
    // scrollView.decelerating
    // 14. scrollsToTop 滚动视图, 双击状态栏手势是否存在
    scrollView.scrollsToTop = NO;
    // 15. 代理
    
    scrollView.delegate = self;
    // 16. 键盘消失模式(一般用这个UIScrollViewKeyboardDismissModeOnDrag)
    scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    // 测试:
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 60, 260, 110)];
    textField.backgroundColor = [UIColor cyanColor];
    [scrollView addSubview:textField];
    // 17. 缩放系数
    // 如果想进行视图放大缩小, 必须实现viewForZoomingInScrollview:
    scrollView.minimumZoomScale = 2;
    scrollView.maximumZoomScale = 6;
    [scrollView setNeedsLayout];
     */
     [self addSubview:self.scrollView];
    [self layoutIfNeeded];
}

#pragma  mark -drawRect
-(void)drawRect:(CGRect)rect
{
    //一个不透明类型的Quartz 2D绘画环境,相当于一个画布,你可以在上面任意绘画
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    /*写文字*/
    NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:[UIFont boldSystemFontOfSize:15.0], NSFontAttributeName, [UIColor redColor], NSForegroundColorAttributeName, nil];
    [@"画圆：" drawInRect:CGRectMake(10, 20, 80, 20) withAttributes:dic];
    [@"画线及孤线：" drawInRect:CGRectMake(10, 80, 100, 20) withAttributes:dic];
    [@"画矩形：" drawInRect:CGRectMake(10, 120, 80, 20) withAttributes:dic];
    [@"画扇形和椭圆：" drawInRect:CGRectMake(10, 160, 110, 20) withAttributes:dic];
    [@"画三角形：" drawInRect:CGRectMake(10, 220, 80, 20) withAttributes:dic];
    [@"画圆角矩形：" drawInRect:CGRectMake(10, 260, 100, 20) withAttributes:dic];
    [@"画贝塞尔曲线：" drawInRect:CGRectMake(10, 300, 100, 20) withAttributes:dic];
    [@"图片：" drawInRect:CGRectMake(10, 340, 80, 20) withAttributes:dic];
    
    /*画圆*/
    //边框圆
    CGContextSetRGBStrokeColor(context,1,1,1,1.0);//画笔线的颜色
    CGContextSetLineWidth(context, 1.0);//线的宽度
    //void CGContextAddArc(CGContextRef c,CGFloat x, CGFloat y,CGFloat radius,CGFloat startAngle,CGFloat endAngle, int clockwise)1弧度＝180°/π （≈57.3°） 度＝弧度×180°/π 360°＝360×π/180 ＝2π 弧度
    // x,y为圆点坐标，radius半径，startAngle为开始的弧度，endAngle为 结束的弧度，clockwise 0为顺时针，1为逆时针。
    CGContextAddArc(context, 100, 20, 15, 0, 2*M_PI, 0); //添加一个圆
    CGContextDrawPath(context, kCGPathStroke); //绘制路径
    
    //填充圆，无边框
    UIColor*aColor = [UIColor colorWithRed:1 green:0.0 blue:0 alpha:1];
    CGContextSetFillColorWithColor(context, aColor.CGColor);//填充颜色
    CGContextAddArc(context, 150, 30, 30, 0, 2*M_PI, 0); //添加一个圆
    CGContextDrawPath(context, kCGPathFill);//绘制填充
    
    //画大圆并填充颜色
    CGContextSetLineWidth(context, 3.0);//线的宽度
    CGContextAddArc(context, 250, 40, 40, 0, 2*M_PI, 0); //添加一个圆
    //kCGPathFill填充非零绕数规则,kCGPathEOFill表示用奇偶规则,kCGPathStroke路径,kCGPathFillStroke路径填充,kCGPathEOFillStroke表示描线，不是填充
    CGContextDrawPath(context, kCGPathFillStroke); //绘制路径加填充
    
    /*画线及孤线*/
    //画线
    CGPoint aPoints[2];//坐标点
    aPoints[0] =CGPointMake(100, 80);//坐标1
    aPoints[1] =CGPointMake(130, 80);//坐标2
    //CGContextAddLines(CGContextRef c, const CGPoint points[],size_t count)
    //points[]坐标数组，和count大小
    CGContextAddLines(context, aPoints, 2);//添加线
    CGContextDrawPath(context, kCGPathStroke); //根据坐标绘制路径
    
    //画笑脸弧线
    //左
    CGContextSetRGBStrokeColor(context, 0, 0, 1, 1);//改变画笔颜色
    CGContextMoveToPoint(context, 140, 80);//开始坐标p1
    //CGContextAddArcToPoint(CGContextRef c, CGFloat x1, CGFloat y1,CGFloat x2, CGFloat y2, CGFloat radius)
    //当前所在点与（x1，y1）形成直线l1，（x1,y1）与(x2,y2)形成直线l2,radius为圆的半径，圆与l1、l2相切，最终弧线为切点之间的部分（该方法只能画角度小于180度的弧线，超过180可以用画圆的方法画）
    CGContextAddArcToPoint(context, 148, 68, 156, 80, 10);
    CGContextStrokePath(context);//绘画路径
    
    //右
    CGContextMoveToPoint(context, 160, 80);//开始坐标p1
    //CGContextAddArcToPoint(CGContextRef c, CGFloat x1, CGFloat y1,CGFloat x2, CGFloat y2, CGFloat radius)
    //当前所在点与（x1，y1）形成直线l1，（x1,y1）与(x2,y2)形成直线l2,radius为圆的半径，圆与l1、l2相切，最终弧线为切点之间的部分（该方法只能画角度小于180度的弧线，超过180可以用画圆的方法画）
    CGContextAddArcToPoint(context, 168, 68, 176, 80, 10);
    CGContextStrokePath(context);//绘画路径
    
    //下
    CGContextMoveToPoint(context, 150, 90);//开始坐标p1
    //CGContextAddArcToPoint(CGContextRef c, CGFloat x1, CGFloat y1,CGFloat x2, CGFloat y2, CGFloat radius)
    //当前所在点与（x1，y1）形成直线l1，（x1,y1）与(x2,y2)形成直线l2,radius为圆的半径，圆与l1、l2相切，最终弧线为切点之间的部分（该方法只能画角度小于180度的弧线，超过180可以用画圆的方法画）
    CGContextAddArcToPoint(context, 158, 102, 166, 90, 10);
    CGContextStrokePath(context);//绘画路径
    //注，如果还是没弄明白怎么回事，请参考：http://donbe.blog.163.com/blog/static/138048021201052093633776/
    
    /*画矩形*/
    CGContextStrokeRect(context,CGRectMake(100, 120, 10, 10));//画方框
    CGContextFillRect(context,CGRectMake(120, 120, 10, 10));//填充框
    //矩形，并填弃颜色
    CGContextSetLineWidth(context, 2.0);//线的宽度
    aColor = [UIColor blueColor];//blue蓝色
    CGContextSetFillColorWithColor(context, aColor.CGColor);//填充颜色
    aColor = [UIColor yellowColor];
    CGContextSetStrokeColorWithColor(context, aColor.CGColor);//线框颜色
    CGContextAddRect(context,CGRectMake(140, 120, 60, 30));//画方框
    CGContextDrawPath(context, kCGPathFillStroke);//绘画路径
    
    //矩形，并填弃渐变颜色
    //关于颜色参考http://blog.sina.com.cn/s/blog_6ec3c9ce01015v3c.html
    //http://blog.csdn.net/reylen/article/details/8622932
    //第一种填充方式，第一种方式必须导入类库quartcore并#import <QuartzCore/QuartzCore.h>，这个就不属于在context上画，而是将层插入到view层上面。那么这里就设计到Quartz Core 图层编程了。
    CAGradientLayer *gradient1 = [CAGradientLayer layer];
    gradient1.frame = CGRectMake(240, 120, 60, 30);
    gradient1.colors = [NSArray arrayWithObjects:(id)[UIColor whiteColor].CGColor,
                        (id)[UIColor grayColor].CGColor,
                        (id)[UIColor blackColor].CGColor,
                        (id)[UIColor yellowColor].CGColor,
                        (id)[UIColor blueColor].CGColor,
                        (id)[UIColor redColor].CGColor,
                        (id)[UIColor greenColor].CGColor,
                        (id)[UIColor orangeColor].CGColor,
                        (id)[UIColor brownColor].CGColor,nil];
    [self.layer insertSublayer:gradient1 atIndex:0];
    //第二种填充方式
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
    CGFloat colors[] =
    {
        1,1,1, 1.00,
        1,1,0, 1.00,
        1,0,0, 1.00,
        1,0,1, 1.00,
        0,1,1, 1.00,
        0,1,0, 1.00,
        0,0,1, 1.00,
        0,0,0, 1.00,
    };
    CGGradientRef gradient = CGGradientCreateWithColorComponents
    (rgb, colors, NULL, sizeof(colors)/(sizeof(colors[0])*4));//形成梯形，渐变的效果
    CGColorSpaceRelease(rgb);
    
    //画线形成一个矩形
    //CGContextSaveGState与CGContextRestoreGState的作用
    /*
     CGContextSaveGState函数的作用是将当前图形状态推入堆栈。之后，您对图形状态所做的修改会影响随后的描画操作，但不影响存储在堆栈中的拷贝。在修改完成后，您可以通过CGContextRestoreGState函数把堆栈顶部的状态弹出，返回到之前的图形状态。这种推入和弹出的方式是回到之前图形状态的快速方法，避免逐个撤消所有的状态修改；这也是将某些状态（比如裁剪路径）恢复到原有设置的唯一方式。
     */
    CGContextSaveGState(context);
    CGContextMoveToPoint(context, 220, 90);
    CGContextAddLineToPoint(context, 240, 90);
    CGContextAddLineToPoint(context, 240, 110);
    CGContextAddLineToPoint(context, 220, 110);
    CGContextClip(context);//context裁剪路径,后续操作的路径
    //CGContextDrawLinearGradient(CGContextRef context,CGGradientRef gradient, CGPoint startPoint, CGPoint endPoint,CGGradientDrawingOptions options)
    //gradient渐变颜色,startPoint开始渐变的起始位置,endPoint结束坐标,options开始坐标之前or开始之后开始渐变
    CGContextDrawLinearGradient(context, gradient,CGPointMake
                                (220,90) ,CGPointMake(240,110),
                                kCGGradientDrawsAfterEndLocation);
    CGContextRestoreGState(context);// 恢复到之前的context
    
    //再写一个看看效果
    CGContextSaveGState(context);
    CGContextMoveToPoint(context, 260, 90);
    CGContextAddLineToPoint(context, 280, 90);
    CGContextAddLineToPoint(context, 280, 100);
    CGContextAddLineToPoint(context, 260, 100);
    CGContextClip(context);//裁剪路径
    //说白了，开始坐标和结束坐标是控制渐变的方向和形状
    CGContextDrawLinearGradient(context, gradient,CGPointMake
                                (260, 90) ,CGPointMake(260, 100),
                                kCGGradientDrawsAfterEndLocation);
    CGContextRestoreGState(context);// 恢复到之前的context
    
    //下面再看一个颜色渐变的圆
    CGContextDrawRadialGradient(context, gradient, CGPointMake(300, 100), 0.0, CGPointMake(300, 100), 10, kCGGradientDrawsBeforeStartLocation);
    
    /*画扇形和椭圆*/
    //画扇形，也就画圆，只不过是设置角度的大小，形成一个扇形
    aColor = [UIColor colorWithRed:0 green:1 blue:1 alpha:1];
    CGContextSetFillColorWithColor(context, aColor.CGColor);//填充颜色
    //以10为半径围绕圆心画指定角度扇形
    CGContextMoveToPoint(context, 160, 180);
    CGContextAddArc(context, 160, 180, 30,  -60 * M_PI / 180, -120 * M_PI / 180, 1);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke); //绘制路径
    
    //画椭圆
    CGContextAddEllipseInRect(context, CGRectMake(160, 180, 20, 8)); //椭圆
    CGContextDrawPath(context, kCGPathFillStroke);
    
    /*画三角形*/
    //只要三个点就行跟画一条线方式一样，把三点连接起来
    CGPoint sPoints[3];//坐标点
    sPoints[0] =CGPointMake(100, 220);//坐标1
    sPoints[1] =CGPointMake(130, 220);//坐标2
    sPoints[2] =CGPointMake(130, 160);//坐标3
    CGContextAddLines(context, sPoints, 3);//添加线
    CGContextClosePath(context);//封起来
    CGContextDrawPath(context, kCGPathFillStroke); //根据坐标绘制路径
    
    /*画圆角矩形*/
    //比较复杂的方法
    float fw = 180;
    float fh = 280;
    CGContextMoveToPoint(context, fw, fh-20);  // 开始坐标右边开始
    CGContextAddArcToPoint(context, fw, fh, fw-20, fh, 10);  // 右下角角度
    CGContextAddArcToPoint(context, 120, fh, 120, fh-20, 10); // 左下角角度
    CGContextAddArcToPoint(context, 120, 250, fw-20, 250, 10); // 左上角
    CGContextAddArcToPoint(context, fw, 250, fw, fh-20, 10); // 右上角
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke); //根据坐标绘制路径
    //通过贝塞尔曲线简易绘画
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextSetLineWidth(context, 3);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(240, 200, 100, 100) byRoundingCorners:(UIRectCornerTopLeft |UIRectCornerTopRight |UIRectCornerBottomRight) cornerRadii:CGSizeMake(10, 10)];
    [path stroke];
    
    /*画贝塞尔曲线*/
    //二次曲线
    CGContextMoveToPoint(context, 120, 300);//设置Path的起点
    CGContextAddQuadCurveToPoint(context,190, 310, 120, 390);//设置贝塞尔曲线的控制点坐标和终点坐标
    CGContextStrokePath(context);
    //三次曲线函数
    CGContextMoveToPoint(context, 200, 300);//设置Path的起点
    CGContextAddCurveToPoint(context,250, 280, 250, 400, 280, 300);//设置贝塞尔曲线的控制点坐标和控制点坐标终点坐标
    CGContextStrokePath(context);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
