//
//  ButtonActions.m
//  TestViewAction
//
//  Created by pc on 2018/8/28.
//  Copyright © 2018年 Jinchuncheng. All rights reserved.
//

#import "ButtonActions.h"

@implementation ButtonActions
-(void)drawRect:(CGRect)rect
{
    [self buttonclickeda];

    [self TestButton];
}
-(void)buttonclickeda
{
    UIButton *button=[[UIButton alloc] init];
    // 2. 设置位置尺寸
    button.frame = CGRectMake(100, 50, 200, 50);
    
    // 3. 设置文字
    // 3.1 常态的文字
    [button setTitle:@"我是按钮" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:button];
    [button addTarget:self action:@selector(buttonClickedb:) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)buttonClickedb:(UIButton *)sender
{
    UIScrollView *scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 100, 200)];
    //self.scrollViewTable.tableView.frame=CGRectMake(50, 100, 200, 350);
    // _tableView = [[UITableView alloc] initWithFrame:CGRectMake(50, 30, 250, 350)];
    scrollView.backgroundColor=[UIColor grayColor];
    [self addSubview:scrollView];
 //   scrollView.frame = CGRectMake(30, 150, 350, 500);
}



-(void)TestButton
{
    UIButton *button=[[UIButton alloc] init];
    // 2. 设置位置尺寸
    button.frame = CGRectMake(100, 100, 200, 50);
    
    // 3. 设置文字
    // 3.1 常态的文字
    [button setTitle:@"我是按钮" forState:UIControlStateNormal];
    // 3.2 高亮状态的文字
    [button setTitle:@"我是高亮按钮" forState:UIControlStateHighlighted];
    
    // 4. 设置字体颜色
    // 4.1 常态的字体颜色
    [button setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    // 4.2 高亮状态的字体颜色
    [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [self addSubview:button];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button1 setFrame:CGRectMake(130, 150, 60, 30)];
    [button1 setTitle:@"按钮一" forState:UIControlStateNormal];
    button1.titleLabel.font = [UIFont systemFontOfSize:15];
    button1.titleLabel.text = @"按钮3";
    button1.titleLabel.textColor = [UIColor blueColor];
    [self addSubview:button1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [button2 setFrame:CGRectMake(149, 190, 22, 22)];
    [self addSubview:button2];
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeInfoLight];
    [button3 setFrame:CGRectMake(149, 230, 22, 22)];
    [self addSubview:button3];
    UIButton *button4 = [UIButton buttonWithType:UIButtonTypeInfoDark];
    [button4 setFrame:CGRectMake(149, 270, 22, 22)];
    [self addSubview:button4];
    UIButton *button5 = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [button5 setFrame:CGRectMake(149, 310, 22, 22)];
    [self addSubview:button5];
    UIButton *button6 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button6 setFrame:CGRectMake(130, 350, 60, 30)];
    [button6 setTitle:@"按钮六" forState:UIControlStateNormal];
    [self addSubview:button6];
}

- (void)buttonClick:(UIButton *)senderss
{
    NSLog(@"sender selected %d",senderss.selected);
    senderss.selected = !senderss.selected;
    NSLog(@"sender selected %d",senderss.selected);
    if (senderss.selected == YES) {
        
        senderss.backgroundColor = [UIColor orangeColor];
        
    }else{
        
        senderss.backgroundColor = [UIColor blueColor];
    }
    NSLog(@"button clicked");
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
