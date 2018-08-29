//
//  ViewController.m
//  TestViewAction
//
//  Created by pc on 2018/7/19.
//  Copyright © 2018年 Jinchuncheng. All rights reserved.
//

#import "ViewController.h"
//1.TouchViewfromScroll
#import "TouchViewfromScroll.h"
#import "Base.h"
//2.Delegate
#import "UIVDelegate.h"
//3.Category
#import "UIViewController+Alpha.h"
//4.Block
#import "BlockSample.h"
//5.Frameworks
#import <YuXinSDK/YuXinSDK.h>
#import <King/Walking.h>
//6.DrawingMethod
#import "DrawingMethod.h"
//7.ButtonsMethods
#import "ButtonActions.h"

@interface ViewController ()<UIScrollViewDelegate,DaChuDelegate>
@property(nonatomic,strong)TouchViewfromScroll *touchView;//1.TouchViewfromScroll
@property(nonatomic,strong)Base *scrollViewTable;//1.TouchViewfromScroll
@property(nonatomic,strong)BlockSample *blocksample;//4.Block
@property (nonatomic, strong) UIScrollView *scrollView;


@end

@implementation ViewController

-(void)viewDidLoad
{
 
  //  DrawingSomothing *drawsome=[[DrawingSomothing alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [self initializeClass:7];
}
-(void)initializeClass:(NSInteger)select
{
    switch (select) {
        case 1://1.TouchViewfromScroll
            [self A_TouchScrollView];
            break;
        case 2:
            [self B_ResturandOpen];
            break;
        case 5://5.Frameworks
            [self E_Delegae];
            break;
        case 6://6.DrawingMethod
            [self F_DrawingMethod];
            break;
        case 7:
            [self G_ButtonsMethods];
            break;
        default:
            break;
    }
    
}

//1.TouchViewfromScroll
-(void)A_TouchScrollView
{
    self.title = @"金彭星";

    _touchView=[[TouchViewfromScroll alloc] initWithFrame:CGRectMake(0, 400,400, 200)];
    _touchView.backgroundColor=[UIColor grayColor];
    [self.view addSubview:self.touchView];
}
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
-(void)E_Delegae
{
    Walking *walking=[[Walking alloc]init];
    [walking sayHello];
}
//6.DrawingMethod
-(void)F_DrawingMethod
{
    DrawingMethod *drawing=[[DrawingMethod alloc] initWithFrame:CGRectMake(20, 50, 350, 400)];
    [self.view addSubview:drawing];
}
//7.ButtonsMethods
-(void)G_ButtonsMethods
{
    ButtonActions *buttonsAction=[[ButtonActions alloc] initWithFrame:CGRectMake(50, 50, 350, 350)];
    buttonsAction.backgroundColor=[UIColor yellowColor];
    [self.view addSubview:buttonsAction];
}
 

@end
