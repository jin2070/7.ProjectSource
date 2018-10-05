//
//  ViewController.m
//  ToolUIKit
//
//  Created by pc on 2018/9/16.
//  Copyright © 2018年 Jinchuncheng. All rights reserved.
//

#import "ViewController.h"
//1.TouchViewfromScroll
#import "TouchViewfromScroll.h"
#import "Base.h"
//2.TableView
#import "A-TableView.h"
//3.UItextMethod
#import "UITextMethod.h"
//4.DefineSizeLocationPointMove
#import "DefineSizeLocation.h"
//7.ButtonsMethods
#import "ButtonActions.h"

@interface ViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)TouchViewfromScroll *touchView;//1.TouchViewfromScroll
@property(nonatomic,strong)Base *scrollViewTable;//1.TouchViewfromScroll

@property (nonatomic, strong) UIScrollView *scrollView;


@end

@implementation ViewController

-(void)viewDidLoad
{
    
    //  DrawingSomothing *drawsome=[[DrawingSomothing alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [self initializeClass:4];
}
-(void)initializeClass:(NSInteger)select
{
    switch (select) {
        case 1://1.TouchViewfromScroll
            [self A_TouchScrollView];
            break;
        case 2://1.TouchViewfromScroll
            [self B_TableView];
            break;
        case 3://1.TouchViewfromScroll
            [self C_UITextMethod];
            break;
        case 4://DefineSizePointLocationFrame
            [self D_DefineSize];
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
-(void)B_TableView
{
    
}
-(void)C_UITextMethod
{
    UITextMethod *textMethod=[[UITextMethod alloc]init];
    [textMethod C_ReadSqlFile];
}
//4.DefineSizeLocationPointMove
-(void)D_DefineSize
{
    DefineSizeLocation *defineSize=[[DefineSizeLocation alloc]init];
    
}
//7.ButtonsMethods
-(void)G_ButtonsMethods
{
    ButtonActions *buttonsAction=[[ButtonActions alloc] initWithFrame:CGRectMake(50, 50, 350, 350)];
    buttonsAction.backgroundColor=[UIColor yellowColor];
    [self.view addSubview:buttonsAction];
}
@end
