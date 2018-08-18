//
//  TouchScrollViewFunction.m
//  TestViewAction
//
//  Created by pc on 2018/7/19.
//  Copyright © 2018年 Jinchuncheng. All rights reserved.
//

#import "TouchScrollViewFunction.h"
//#import "UIScrollView+UITouchEvent.h"
@implementation TouchScrollViewFunction

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event

{
    
    [[self nextResponder] touchesBegan:touches withEvent:event];
    
    [super touchesBegan:touches withEvent:event];
    NSLog(@"can i send messege");
}



-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event

{
    
    [[self nextResponder] touchesMoved:touches withEvent:event];
    
    [super touchesMoved:touches withEvent:event];
     NSLog(@"i am sending messege");
    
}



- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event

{
    
    [[self nextResponder] touchesEnded:touches withEvent:event];
    
    [super touchesEnded:touches withEvent:event];
    
}
/*
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self nextResponder] touchesBegan:touches withEvent:event];
 
    [super touchesBegan:touches withEvent:event];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self nextResponder] touchesMoved:touches withEvent:event];
    NSLog(@"i am sending messege");
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self nextResponder] touchesEnded:touches withEvent:event];
    [super touchesEnded:touches withEvent:event];
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[self nextResponder] touchesCancelled:touches withEvent:event];
    [super touchesEnded:touches withEvent:event];
}

*/
@end
