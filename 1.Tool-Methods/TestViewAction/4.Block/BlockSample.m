//
//  BlockSample.m
//  TestViewAction
//
//  Created by pc on 2018/7/29.
//  Copyright © 2018年 Jinchuncheng. All rights reserved.
//
//测试block
#import "BlockSample.h"

typedef int(^hellloBlock)(int,int);
@implementation BlockSample
-(instancetype)init
{
    self=[super init];
  //  [self runBlockFunction];
    return self;
}
-(void)runBlockFunction
{
    int multiplier = 7;
    int (^myBlock)(int) = ^(int num) {
      //  NSLog(@"i am from block");
        return num * multiplier;
    };
     myBlock(2);
    hellloBlock helloblock=^(int i,int j){
        return i*j;
    };
    helloblock(5,5);
  //hellloBlock helloblock=
   NSLog(@"i am from block %d",helloblock(5,6));
}


void (^one) (void);//没有返回值，没有输入参数；
int (^two) (void);//有返回值，没有输入参数；
void (^three) (int);//没有返回值，有输入参数；
int (^four) (int ,int);//有返回值，有输入参数；

- (void)testBlock {
    //定义闭包函数；
    one = ^(void){
        NSLog(@"执行了one");
    };
    one = ^(void){
        NSLog(@"repeat assign number");
    };
    two = ^(void){
        NSLog(@"执行了two");
        return 2;
    };
    
    three = ^(int a){
        NSLog(@"执行了three");
    };
    
    four = ^(int a,int b){
        NSLog(@"执行了four, 第 %d 个",a*b);
        return a + b;
    };
    
    //调用闭包函数；
    one();
    two();
    three(1);
    four(2,3);
    
  //  NSLog(@"%d",two());
  //  NSLog(@"%d",four(2,3));

    
    
 //   NSString *strBlock = @"NSStackBlock";
    [self startWithBlock:^{
        int i,j,c;
        i=5;
        j=12;
        c=i*j;
     //   NSLog(@"%@,number is %d",strBlock,c);
    }];
}
//----使用block参数
- (void)startWithBlock:(void(^)(void))block {
    block();
}

@end
