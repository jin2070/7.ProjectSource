//
//  MyThread.m
//  TestViewAction
//
//  Created by pc on 2018/8/29.
//  Copyright © 2018年 Jinchuncheng. All rights reserved.
//

#import "MyThread.h"

@implementation MyThread
-(void)dealloc{
    NSLog(@"%@线程被释放了", self.name);
}
@end
