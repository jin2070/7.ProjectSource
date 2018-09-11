//
//  ViewController.m
//  TestViewAction
//
//  Created by pc on 2018/7/19.
//  Copyright © 2018年 Jinchuncheng. All rights reserved.
//

#import "ViewController.h"
//1.RunLoop
#import "RunloopViewClass.h"
//2.Thread
#import "ThreadStudy.h"
//3.Delegate
#import "UIVDelegate.h"

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
 
    [self initializeClass:2];
}
-(void)initializeClass:(NSInteger)select
{
    switch (select) {
        case 1://1.RunLoop
            [self A_RunloopCause];
            break;
        case 2:
            [self B_Thread];
            break;
        case 3://Delegate
            [self C_ResturandOpen];
            break;
        case 4: //Block
            [self D_Block];
            break;
        case 5://5.Frameworks
            [self E_Framework];
            break;

        default:
            break;
    }
    
}

//1.RunLoop
-(void)A_RunloopCause
{
    RunloopViewClass *runlooViewclass=[[RunloopViewClass alloc] initWithFrame:CGRectMake(30, 50, 300, 350)];
                                       runlooViewclass.backgroundColor=[UIColor grayColor];
    [runlooViewclass CreateAThread];
    [self.view addSubview:runlooViewclass];
}
//2.Thread
-(void)B_Thread
{
    ThreadStudy *threadView=[[ThreadStudy alloc] initWithFrame:CGRectMake(30, 50, 300, 400)];
    threadView.backgroundColor=[UIColor blueColor];
    [self.view addSubview:threadView];

}

//3.Delegate
- (void)C_ResturandOpen{
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
//4.Block
-(void)D_Block
{
    BlockSample *blocksample=[[BlockSample alloc] init];
    [blocksample runBlockFunction];
    [blocksample testBlock];
}

//5.Frameworks
-(void)E_Framework
{
    Walking *walking=[[Walking alloc]init];
    [walking sayHello];
}

 

@end
