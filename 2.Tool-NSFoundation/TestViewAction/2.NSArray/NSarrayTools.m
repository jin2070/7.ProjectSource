//
//  NSarrayTools.m
//  TestViewAction
//
//  Created by pc on 2018/8/30.
//  Copyright © 2018年 Jinchuncheng. All rights reserved.
//

#import "NSarrayTools.h"

@implementation NSarrayTools
-(void)ShowTime
{
    [self A_Test];
}
-(void)A_Test
{
    //使用arrayWithObjects创建NSArray
    NSArray *arr = [NSArray arrayWithObjects:@"ABC",@"DEF",@"GHI",nil];
    //NSArray *arr = [[NSArray alloc] initWithObjects:@"ABC",@"DEF",@"GHI",nil];
    NSLog(@"arr = %@",arr);
    
    //使用arrayWithArray创建NSArray
    NSArray *arr1 = [NSArray arrayWithArray:arr];
    //NSArray *arr1 = [[NSArray alloc]initWithArray:arr];
    NSLog(@"arr1 = %@",arr1);
    
    //使用@创建NSArray,只能创建不可变数组
    NSArray *arr2 = @[@"123",@"456",@"789"];
    NSLog(@"arr2 = %@",arr2);
    
    //返回元素个数
    NSLog(@"arr count = %ld",[arr count]);
    
    //返回指定位置id
    NSString *str = [arr objectAtIndex:1];
    NSLog(@"str = %@",str);
    
    //访问数组的第一个元素
    NSString *strF = [arr firstObject];
    NSLog(@"strF = %@",strF);
    
    //访问数组的最后一个元素
    NSString *strL = [arr lastObject];
    NSLog(@"strL = %@",strL);
    
    //判断数组内是否含有某一个对象
    if ([arr2 containsObject:@"456"]) {
        NSLog(@"数组arr2内含有对象456");
    }
    
    //获取某个对象在数组中的下标值
    NSUInteger index = [arr indexOfObject:@"ABC"];
    NSLog(@"ABC下标值为%ld",index);
    
    //数组的遍历
    for (NSInteger i = 0; i < [arr count]; i++) {
        NSLog(@"arr[%ld] = %@",i,arr[i]);
    }
    
    //快速枚举法(快速遍历)
    for (id arr2Q in arr2) {
        NSLog(@"arr2Q = %@",arr2Q);
    }

}
@end
