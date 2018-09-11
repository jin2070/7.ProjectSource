//
//  RunloopViewClass.m
//  TestViewAction
//
//  Created by pc on 2018/8/29.
//  Copyright © 2018年 Jinchuncheng. All rights reserved.
//

#import "RunloopViewClass.h"
#import "MyThread.h"
@interface RunloopViewClass()
@property(nonatomic,weak)NSThread *subThread;

@end
@implementation RunloopViewClass
-(void)CreateAThread
{
    NSLog(@"%@----开辟子线程",[NSThread currentThread]);
    
    NSThread *tmpThread = [[MyThread alloc] initWithTarget:self selector:@selector(subThreadTodo) object:nil];
    //subThread用weak声明，用weak声明，用weak声明
    self.subThread = tmpThread;
    self.subThread.name = @"subThread";
    [self.subThread start];
}

- (void)subThreadTodo
{
    
    NSLog(@"%@----开始执行子线程任务",[NSThread currentThread]);
    
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
    
    [runLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    NSLog(@"%@----执行子线程任务结束",[NSThread currentThread]);
}
//我们希望放在子线程中执行的任务
- (void)wantTodo{
    //断点2
    NSLog(@"当前线程:%@执行任务处理数据", [NSThread currentThread]);
    
}
//屏幕点击事件
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //断点1
    //在子线程中去响应wantTodo方法
    [self performSelector:@selector(wantTodo) onThread:self.subThread withObject:nil waitUntilDone:NO];
}
-(void)CreateBThread
{
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
