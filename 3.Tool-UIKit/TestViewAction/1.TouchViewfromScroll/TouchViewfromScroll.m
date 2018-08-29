//
//  TouchViewfromScroll.m
//  TestViewAction
//
//  Created by pc on 2018/7/20.
//  Copyright © 2018年 Jinchuncheng. All rights reserved.
//

#import "TouchViewfromScroll.h"
#import "UIScrollView+TouchDraw.h"

@interface SPItem : UIButton  //自定义button,
@property (nonatomic, assign) CGFloat imageRatio;
@property (nonatomic, assign) SPItemImagePosition imagePosition;
@property(nonatomic)CGPoint buttonMovePoint;
@end
@implementation SPItem  ///Button Implementation
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self initialize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        
        [self initialize];
        
    }
    return self;
}

- (void)initialize {
    _imageRatio = 0.5;
    _imagePosition = SPItemImagePositionDefault;
}

- (void)setHighlighted:(BOOL)highlighted {}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    if (!self.currentTitle) { // 如果没有文字，则图片占据整个button，空格算一个文字
        return [super imageRectForContentRect:contentRect];
    }
    switch (self.imagePosition) {
        case SPItemImagePositionDefault:
        case SPItemImagePositionLeft: {
            _imageRatio = _imageRatio == 0.0 ? 0.5 : _imageRatio;
            CGFloat imageW =  contentRect.size.width * _imageRatio;
            CGFloat imageH = contentRect.size.height;
            return CGRectMake(0, 0, imageW, imageH);
        }
            break;
        case SPItemImagePositionTop: {
            _imageRatio = _imageRatio == 0.0 ? 2.0/3.0 : _imageRatio;
            CGFloat imageW = contentRect.size.width;
            CGFloat imageH = contentRect.size.height * _imageRatio;
            return CGRectMake(0, 0, imageW, imageH);
        }
            break;
        case SPItemImagePositionRight: {
            _imageRatio = _imageRatio == 0.0 ? 0.5 : _imageRatio;
            CGFloat imageW =  contentRect.size.width * _imageRatio;
            CGFloat imageH = contentRect.size.height;
            CGFloat imageX = contentRect.size.width - imageW;
            return CGRectMake(imageX, 0, imageW, imageH);
        }
            break;
        case SPItemImagePositionBottom: {
            _imageRatio = _imageRatio == 0.0 ? 2.0/3.0 : _imageRatio;
            CGFloat imageW =  contentRect.size.width;
            CGFloat imageH = contentRect.size.height * _imageRatio;
            CGFloat imageY = contentRect.size.height - imageH;
            return CGRectMake(0, imageY, imageW, imageH);
        }
            break;
        default:
            break;
    }
    return CGRectZero;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    if (!self.currentImage) {  // 如果没有图片
        return [super titleRectForContentRect:contentRect];
    }
    switch (self.imagePosition) {
        case SPItemImagePositionDefault:
        case SPItemImagePositionLeft: {
            _imageRatio = _imageRatio == 0.0 ? 0.5 : _imageRatio;
            CGFloat titleX = contentRect.size.width * _imageRatio;
            CGFloat titleW = contentRect.size.width - titleX;
            CGFloat titleH = contentRect.size.height;
            return CGRectMake(titleX, 0, titleW, titleH);
        }
            break;
        case SPItemImagePositionTop: {
            _imageRatio = _imageRatio == 0.0 ? 2.0/3.0 : _imageRatio;
            CGFloat titleY = contentRect.size.height * _imageRatio;
            CGFloat titleW = contentRect.size.width;
            CGFloat titleH = contentRect.size.height - titleY;
            return CGRectMake(0, titleY, titleW, titleH);
        }
            break;
        case SPItemImagePositionRight: {
            _imageRatio = _imageRatio == 0.0 ? 0.5 : _imageRatio;
            CGFloat titleW = contentRect.size.width * (1-_imageRatio);
            CGFloat titleH = contentRect.size.height;
            return CGRectMake(0, 0, titleW, titleH);
        }
            break;
        case SPItemImagePositionBottom: {
            _imageRatio = _imageRatio == 0.0 ? 2.0/3.0 : _imageRatio;
            CGFloat titleW = contentRect.size.width;
            CGFloat titleH = contentRect.size.height * (1 - _imageRatio);
            return CGRectMake(0, 0, titleW, titleH);
        }
            break;
        default:
            break;
    }
    return CGRectZero;
    
}

- (void)setImagePosition:(SPItemImagePosition)imagePosition {
    _imagePosition = imagePosition;
    switch (imagePosition) {
        case SPItemImagePositionDefault:
        case SPItemImagePositionLeft:
            self.imageView.contentMode = UIViewContentModeScaleAspectFit;
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
            break;
        case SPItemImagePositionTop:
            
            self.imageView.contentMode = UIViewContentModeScaleAspectFit;
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
            
            break;
        case SPItemImagePositionRight:
            self.imageView.contentMode = UIViewContentModeScaleAspectFit;
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
            break;
        case SPItemImagePositionBottom:
            self.imageView.contentMode = UIViewContentModeScaleAspectFit;
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
            break;
        default:
            break;
    }
    [self setNeedsDisplay];
}

- (void)setImageRatio:(CGFloat)imageRatio {
    _imageRatio = imageRatio;
    [self setNeedsDisplay];
}
#pragma mark TouchButtonResponser
//---button键拖动时，图像一起移动
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  //  NSLog(@"Button touches moved");
    [super touchesMoved:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    // 获取目前的点和，上一个点位置
    CGPoint currentPoint = [touch locationInView:self];
    CGPoint prePoint = [touch previousLocationInView:self];
    CGFloat offsetX = currentPoint.x - prePoint.x;
    CGFloat offsetY = currentPoint.y - prePoint.y;
    _buttonMovePoint=CGPointMake(offsetX, offsetY);
    
    //CGPoint preP=[touch pr]
  //  NSLog(@"move:f%f",self.buttonMovePoint.y);
    //通知启动，通知UIView需要移动，根据通知传递数值
    // 1.添加字典, 将拖动的距离数据打包到字典中
    NSNumber *numPoint=[NSNumber numberWithFloat:offsetY];//用通知传送Point
   //  NSLog(@"numPoint:%@",numPoint);
    NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:numPoint,@"name",@"111401",@"number", nil];
    
    // 2.创建通知
    //通知的名字是key,必须通知与接听一致，userInfo可以设置为nil;
    NSNotification *notiButton =[NSNotification notificationWithName:@"NotiButtonTouch" object:nil userInfo:dict];
   
    // 3.通过 通知中心 发送 通知
    [[NSNotificationCenter defaultCenter] postNotification:notiButton];
}
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    BOOL isInside = [super pointInside:point withEvent:event];
   // NSLog(@"Button is inside: %@", isInside?@"Yes":@"No");
    return isInside;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
  //  NSLog(@"Button hit: %@", view);
    return view;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
 //   NSLog(@"Button touches began");
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
 //   NSLog(@"Button touches ended");
    [super touchesEnded:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
   // NSLog(@"Button touches cancelled");
    [super touchesCancelled:touches withEvent:event];
}
//redifine button TouchResponser

@end
//----Main Implementation
@interface TouchViewfromScroll()
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIView *secondView;
@property(nonatomic)CGPoint beginPoint;
@property(nonatomic,strong)UIScrollView *scrollviewFunction;
@property(nonatomic,weak)SPItem *buttonFunction;
@end
@implementation TouchViewfromScroll

#pragma mark - ScrollMove
//Scrollview拖动时响应动作
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //控制移动view和Scrollview的范围
    CGRect frame = self.scrollView.frame;
    CGRect frameOfview=self.frame;

   // frame.origin.y = self.beginPoint.y;
    frame.size.height=50;
    self.scrollView.frame = frame;
 
    frameOfview.origin.y=-self.scrollView.contentOffset.y+400;
    if(frameOfview.origin.y<159){
        frameOfview.origin.y=180;
    }
 //  NSLog(@"scrollview :X = %f,Y = %f",self.scrollView.contentOffset.y,scrollView.contentOffset.y);
    self.frame=frameOfview;
  //  [self.scrollviewFunction setNeedsDisplay];

}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //  NSLog(@"willbegin :X = %f,Y = %f",scrollView.contentOffset.x,scrollView.contentOffset.y);
}

#pragma  mark - Initialize Load
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initialize];
    }
    return self;
}
- (void)initialize
{
    //secondView Init
    UIView *secondView=[[UIView alloc] init];
    secondView.backgroundColor=[UIColor lightGrayColor];//中间大的，浅灰色
    _secondView=secondView;
  
    //下面scrollview,用重新定义touch拖动
    //最下面黄色，里面图不转动
    UIScrollView *scrollviewFunction=[[UIScrollView alloc] init];
    //需要设置图片 UIImage
    UIImageView  *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(100, 10, 120, 150)];
    [imageView setImage:[UIImage imageNamed:@"city.jpeg"]]; //       UIImage *image=UIImage
    scrollviewFunction.backgroundColor=[UIColor yellowColor];//最下面黄色，里面图不转动
    scrollviewFunction.contentSize=CGSizeMake(0, 0);  //关键参数，可以锁定内容滑动，上下左右方向也可以选择
    scrollviewFunction.alwaysBounceVertical=NO;
    scrollviewFunction.pagingEnabled=YES;
    scrollviewFunction.scrollEnabled=YES;
    scrollviewFunction.showsVerticalScrollIndicator=NO;  //滑动条边不显示
    scrollviewFunction.alwaysBounceVertical=NO;  //不弹跳
    _scrollviewFunction=scrollviewFunction;
    [self.scrollviewFunction addSubview:imageView];    
    //    _scrollView.delegate=self;
    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];//增加一个按键
    button.backgroundColor=[UIColor redColor];
    [button setTitle:@"hello" forState:UIControlStateNormal];
    [self.scrollviewFunction insertSubview:button atIndex:0];
    
    
    //上边的scroll，用scrollview拖动用
    ///中间的蓝色的图，里面有图可以转动
    UIScrollView *scrollView=[[UIScrollView alloc] init];
    //需要设置图片 UIImage
    UIImageView  *imageViewOfscroll=[[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 220, 220)];
    [imageViewOfscroll setImage:[UIImage imageNamed:@"city.jpeg"]];
    scrollView.backgroundColor=[UIColor blueColor];  ///中间的蓝色的图，里面有图可以转动
    scrollView.contentSize=CGSizeMake(0,300);  //范围
    scrollView.alwaysBounceVertical=NO;
    scrollView.pagingEnabled=YES;
    scrollView.scrollEnabled=YES;
    scrollView.showsVerticalScrollIndicator=NO;  //滑动条边不显示
    scrollView.alwaysBounceVertical=NO;  //不弹跳
    _scrollView=scrollView;
    _scrollView.delegate=self;
    self.beginPoint=self.scrollView.frame.origin;
    [self.scrollView addSubview:imageViewOfscroll];

    SPItem *buttonFunction=[[SPItem alloc] init];
    buttonFunction.backgroundColor=[UIColor yellowColor];
    [buttonFunction setTitle:@"触摸" forState:UIControlStateNormal];
    _buttonFunction=buttonFunction;
    [self.buttonFunction setTitle:@"触摸" forState:UIControlStateNormal];
    [self.buttonFunction setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    
    [self.secondView addSubview:self.scrollviewFunction];
    [self addSubview:self.secondView];
    [self addSubview:self.scrollView];
    [self.scrollviewFunction addSubview:self.buttonFunction];
    
    [self.scrollviewFunction PrintTest];
 //   [self addSubview:self.scrollviewFunction];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(abserveScrollTouch:) name:@"NotiAnyname"object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observeButtonTouch:) name:@"NotiButtonTouch"object:nil];
}
#pragma mark - KVO
//收听子控件button的touch point变化的时候
-(void)observeButtonTouch:(NSNotification *)notification{
    //测试观察接收userinfo，并导出通知里的CGFloat信息
  //  NSLog(@"%@",notification.userInfo);
    NSNumber *acceptNum=[notification.userInfo objectForKey:@"name"];
    NSLog(@"number is %@",acceptNum);
  // CGFloat acciptFloatNum=[acceptNum floatValue];
    //NSLog(@"nsnumber is right?%f",acciptFloatNum);
    //   NSLog(@"—接收到通知—");
    //控制移动view和Scrollview的范围
    CGPoint acciptPoint=self.buttonFunction.buttonMovePoint;
    //    CGRect frame = self.scrollView.frame;
    CGRect FirstViewframe=self.frame;
    
    FirstViewframe.origin.y+=acciptPoint.y;
  //  NSLog(@"acciptPoint.y = %f",acciptPoint.y );
 //   NSLog(@"Firstframe.y =------------ %f",FirstViewframe.origin.y );
    self.frame=FirstViewframe;
    
}
//收听子控件scrollview的touch point变化的时候
-(void)abserveScrollTouch:(NSNotification *)notification{
    //控制移动view和Scrollview的范围
    
    CGPoint acciptPoint=self.scrollviewFunction.FscrollMovepoint;
    CGRect FirstViewframe=self.frame;
    
    FirstViewframe.origin.y+=acciptPoint.y;
 //   frameOfview.origin.y=self.scrollviewFunction.FscrollMovepoint.y+400;
//    NSLog(@"acciptPoint.y = %f",acciptPoint.y );
//    NSLog(@"Firstframe.y =------------ %f",FirstViewframe.origin.y );
    self.frame=FirstViewframe;
    
}
#pragma mark - Layout
-(void)layoutSubviews
{
    _secondView.frame=CGRectMake(0, 50, 350,  260);
    _scrollviewFunction.frame = CGRectMake(20, 50, 300, 90);
    _scrollView.frame = CGRectMake(0, 20, 300, 50);
    _buttonFunction.frame=CGRectMake(110, 20, 40, 30);

 //   NSLog(@"hello====");
    
}


@end
