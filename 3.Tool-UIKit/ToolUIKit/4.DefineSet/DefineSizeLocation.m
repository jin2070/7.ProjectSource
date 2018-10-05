//
//  DefineSizeLocation.m
//  ToolUIKit
//
//  Created by pc on 2018/10/3.
//  Copyright © 2018年 Jinchuncheng. All rights reserved.
//

#import "DefineSizeLocation.h"

@interface DefineSizeLocation ()

@end

@implementation DefineSizeLocation

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initPresentView];
    // Do any additional setup after loading the view.
}
-(void)initPresentView
{
    CGPoint controllerPoint;
    CGSize controllerSize;
    controllerPoint=self.view.frame.origin;
    controllerSize=self.view.frame.size;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
