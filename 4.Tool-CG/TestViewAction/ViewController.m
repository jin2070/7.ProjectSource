//
//  ViewController.m
//  TestViewAction
//
//  Created by pc on 2018/7/19.
//  Copyright © 2018年 Jinchuncheng. All rights reserved.
//

#import "ViewController.h"

//6.DrawingMethod
#import "DrawingMethod.h"


@interface ViewController ()
@end

@implementation ViewController

-(void)viewDidLoad
{
 
  //  DrawingSomothing *drawsome=[[DrawingSomothing alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [self initializeClass:6];
}
-(void)initializeClass:(NSInteger)select
{
    switch (select) {
        
        case 6://6.DrawingMethod
            [self F_DrawingMethod];
            break;
        
        default:
            break;
    }
    
}


//6.DrawingMethod
-(void)F_DrawingMethod
{
    DrawingMethod *drawing=[[DrawingMethod alloc] initWithFrame:CGRectMake(20, 50, 350, 400)];
    [self.view addSubview:drawing];
}

 

@end
