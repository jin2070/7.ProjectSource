//
//  ThreadStudy.m
//  TestViewAction
//
//  Created by pc on 2018/8/29.
//  Copyright © 2018年 Jinchuncheng. All rights reserved.
//

#import "ThreadStudy.h"

@implementation ThreadStudy
-(void)CreateAThread
{

}

- (void)subThreadTodo
{
    

}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 创建了默认优先级的Serial Queue
    dispatch_queue_t serialQueue = dispatch_queue_create("com.Sky.serialTest", NULL);
    // 获取一个低优先级Concurrent Queue
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
    // 将Serial Queue优先级变为低
    dispatch_set_target_queue(serialQueue, globalQueue);
    
    dispatch_queue_t queue0 = dispatch_queue_create("com.test.queue0", NULL);
    dispatch_queue_t queue1 = dispatch_queue_create("com.test.queue1", NULL);
    dispatch_queue_t queue2 = dispatch_queue_create("com.test.queue2", NULL);
    dispatch_set_target_queue(queue1, queue2);
    dispatch_set_target_queue(queue0, queue1);
    
    dispatch_async(queue0, ^{
        NSLog(@"queue0");
    });
    dispatch_async(queue1, ^{
        NSLog(@"---queue1");
    });
    dispatch_async(queue2, ^{
        NSLog(@"--------queue2");
    });
    
    
}
-(void)Amethod
{
    //方式一：
    //object 为子线程方法的参数
    NSThread *thread1 = [[NSThread alloc]initWithTarget:self selector:@selector(method:)object:@"方式一启动"];
    //需要启动一下
    [thread1 start];
    
    //方式二：
    //自动启动
    [NSThread detachNewThreadSelector:@selector(method:) toTarget:self withObject:@"方式二启动"];
    
    //方式三：
    [self performSelectorInBackground:@selector(method:) withObject:@"方式三启动"];
}
-(void)method:(NSString*)name{
    
    
    
    for (int i=0; i<10; i++) {
        
        NSLog(@"我是%@,i=%d",name,i);
        
    }
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
