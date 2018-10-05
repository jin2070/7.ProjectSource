//
//  UserDefualtsTest.m
//  TestViewAction
//
//  Created by pc on 2018/10/2.
//  Copyright © 2018年 Jinchuncheng. All rights reserved.
//

#import "UserDefualtsTest.h"

@implementation UserDefualtsTest
-(void)A_ShowTime
{

    NSDictionary *dict = @{@"甲":@1, @"乙":@2, @"丙":@3, @"丁":@4};
    [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"testKey"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self B_saveNSUserDefaults];
    [self C_readNSUserDefaults];
}
-(void)B_saveNSUserDefaults
{
    NSString *myString = @"enuola";
    int myInteger = 100;
    float myFloat = 50.0f;
    double myDouble = 20.0;
    NSDate *myDate = [NSDate date];
    NSArray *myArray = [NSArray arrayWithObjects:@"hello", @"world", nil];
    NSDictionary *myDictionary = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"enuo", @"20", nil] forKeys:[NSArray arrayWithObjects:@"name", @"age", nil]];
    
    //将上述数据全部存储到NSUserDefaults中
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //存储时，除NSNumber类型使用对应的类型意外，其他的都是使用setObject:forKey:
    [userDefaults setInteger:myInteger forKey:@"myInteger"];
    [userDefaults setFloat:myFloat forKey:@"myFloat"];
    [userDefaults setDouble:myDouble forKey:@"myDouble"];
    
    [userDefaults setObject:myString forKey:@"myString"];
    [userDefaults setObject:myDate forKey:@"myDate"];
    [userDefaults setObject:myArray forKey:@"myArray"];
    [userDefaults setObject:myDictionary forKey:@"myDictionary"];
    
    //这里建议同步存储到磁盘中，但是不是必须的
    [userDefaults synchronize];
    

}
//从NSUserDefaults中读取数据
-(void)C_readNSUserDefaults
{
   // NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    NSUserDefaults *userPass = [NSUserDefaults standardUserDefaults];
    NSUserDefaults *userP = [NSUserDefaults standardUserDefaults];
    
    //读取数据到各个label中
    //读取整型int类型的数据
    NSInteger myInteger = [userPass integerForKey:@"myInteger"];
    NSInteger myIntegers = [userP integerForKey:@"myInteger"];
   NSLog(@"myIneter  %@",[NSString stringWithFormat:@"%zd",myInteger]);
    NSLog(@"myIneter  %@",[NSString stringWithFormat:@"%zd",myIntegers]);
    
    
    //读取浮点型float类型的数据
    float myFloat = [userPass floatForKey:@"myFloat"];
     NSLog(@"myFloat  %@",[NSString stringWithFormat:@"%f",myFloat]);
    
    //读取double类型的数据
    double myDouble = [userPass doubleForKey:@"myDouble"];
   NSLog(@"myDouble  %@",[NSString stringWithFormat:@"%f",myDouble]);
    
    //读取NSString类型的数据
    NSString *myString = [userPass stringForKey:@"myString"];
   NSLog(@"myString  %@",myString);
    
    //读取NSDate日期类型的数据
    NSDate *myDate = [userPass valueForKey:@"myDate"];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSLog(@"myData  %@",myDate);
    
    //读取数组NSArray类型的数据
    NSArray *myArray = [userPass arrayForKey:@"myArray"];
    NSString *myArrayString = [[NSString alloc] init];
    for(NSString *str in myArray)
    {
        NSLog(@"str= %@",str);
        myArrayString = [NSString stringWithFormat:@"%@  %@", myArrayString, str];
        [myArrayString stringByAppendingString:str];
        //        [myArrayString stringByAppendingFormat:@"%@",str];
        NSLog(@"myArrayString=%@",myArrayString);
    }
   
    
    //读取字典类型NSDictionary类型的数据
    NSDictionary *myDictionary = [userPass dictionaryForKey:@"myDictionary"];
    NSString *myDicString = [NSString stringWithFormat:@"name:%@, age:%ld",[myDictionary valueForKey:@"name"], [[myDictionary valueForKey:@"age"] integerValue]];
    NSLog(@"myDicString  %@",myDicString);
    
}

@end
