//
//  ViewController.m
//  TestViewAction
//
//  Created by pc on 2018/7/19.
//  Copyright © 2018年 Jinchuncheng. All rights reserved.
//

#import "ViewController.h"
//1.NSString
#import "NsstringTools.h"
//2.NSArray
#import "NSarrayTools.h"
//3.NSDictionary
#import "NSDictionaryTools.h"

@interface ViewController ()

@end

@implementation ViewController

-(void)viewDidLoad
{
 
  //  DrawingSomothing *drawsome=[[DrawingSomothing alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [self initializeClass:3];
}
-(void)initializeClass:(NSInteger)select
{
    switch (select) {
        case 1://1.NSString
            [self A_Nstringshowtime];
            break;
        case 2: //2.NSArray
            [self B_Narrayshowtime];
            break;
        case 3: //NSDictionary
            [self C_NSDictionaryShwothim];
            break;
        case 5://5.Frameworks
         //   [self E_Delegae];
            break;
        case 6://6.DrawingMethod
          //  [self F_DrawingMethod];
            break;
        case 7:
          //  [self G_ButtonsMethods];
            break;
        default:
            break;
    }
    
}
//1.NSString
-(void)A_Nstringshowtime
{
    NsstringTools *nstringtool=[[NsstringTools alloc] init];
    [nstringtool ShowTime];
}
//2.NSArray
-(void)B_Narrayshowtime
{
    NSarrayTools *nsarray=[[NSarrayTools alloc] init];
    [nsarray ShowTime];
}
//3.NSDictionary
-(void)C_NSDictionaryShwothim
{
    NSDictionaryTools *ndTools=[[NSDictionaryTools alloc] init];
    [ndTools ShowTime];
    
}
//3.NSDictionary


@end
