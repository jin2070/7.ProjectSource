//
//  ViewController.m
//  TestViewAction
//
//  Created by pc on 2018/7/19.
//  Copyright © 2018年 Jinchuncheng. All rights reserved.
//

#import "ViewController.h"
//1.TouchViewfromScroll

//2.Delegate
#import "UIVDelegate.h"
//3.Category
#import "UIViewController+Alpha.h"
//4.Block
#import "BlockSample.h"
//5.Frameworks
#import <YuXinSDK/YuXinSDK.h>
#import <King/Walking.h>


@interface ViewController ()<UIScrollViewDelegate,DaChuDelegate>

@property(nonatomic,strong)BlockSample *blocksample;//4.Block
@property (nonatomic, strong) UIScrollView *scrollView;


@end

@implementation ViewController

-(void)viewDidLoad
{
 
  //  DrawingSomothing *drawsome=[[DrawingSomothing alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [self initializeClass:2];
}
-(void)initializeClass:(NSInteger)select
{
    switch (select) {

        case 2://Delegate
            [self B_ResturandOpen];
            break;
        case 5://5.Frameworks
            [self E_Framework];
            break;

        default:
            break;
    }
    
}

//1.TouchViewfromScroll

//2.Delegate
- (void)B_ResturandOpen{
    NSLog(@"新的一天开始了");
    
    UIVDelegate *resturand = [[UIVDelegate alloc] initWithFrame:CGRectMake(30, 60, 300, 400)];
    //   UIVDelegate *uiviewdelgate=[[UIVDelegate alloc] i
    resturand.backgroundColor=[UIColor lightGrayColor];
    [self.view addSubview:resturand];
    resturand.delegate = self;//说明老王充当代理的角色，负责接收菜好了的信号。
    [resturand StartToCook];//大厨开始做菜
}
- (void)takeRicefterCookDone{
    NSLog(@"米饭可以上了");//这里可以通知服务员去上菜了
}
-(void)takeWaterAfterCookDone
{
    NSLog(@"上菜前倒茶");//这里可以通知服务员去倒水了
}


//5.Frameworks
-(void)E_Framework
{
    Walking *walking=[[Walking alloc]init];
    [walking sayHello];
}

 

@end
