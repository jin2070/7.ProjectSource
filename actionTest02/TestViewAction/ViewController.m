//
//  ViewController.m
//  TestViewAction
//
//  Created by pc on 2018/7/19.
//  Copyright © 2018年 Jinchuncheng. All rights reserved.
//

#import "ViewController.h"
#import "TouchViewfromScroll.h"
//#import "UIVDelegate.h"
#import "UIVDelegate.h"
//--测试导入
#import "BlockSample.h"
#import "Base.h"
#import "UIViewController+Alpha.h"
//#import "UINavigationController+NavAlpha.h"
@interface ViewController ()<UIScrollViewDelegate,DaChuDelegate>
@property(nonatomic,strong)TouchViewfromScroll *touchView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic,strong)Base *scrollViewTable;
//--测试属性
@property(nonatomic,strong)BlockSample *blocksample;
@end

@implementation ViewController

-(void)viewDidLoad
{
    
     [self.view addSubview:self.scrollView];
    self.scrollViewTable=[[Base alloc] init];
    self.scrollViewTable.view.backgroundColor=[UIColor blueColor];
    self.scrollViewTable.view.frame=CGRectMake(0, 100, 350, 500);
    [self addChildViewController:self.scrollViewTable];
   
    // 先将第一个子控制的view添加到scrollView上去
    [self.scrollView addSubview:self.childViewControllers[0].view];
  
    //---测试实例方法
    [self buttonclickeda];
    //[self TestButton];
   // [self TestFunctionAndExample];
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
    [self.view addSubview:button];
    [button addTarget:self action:@selector(buttonClickedb:) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)buttonClickedb:(UIButton *)sender
{
    //self.scrollViewTable.tableView.frame=CGRectMake(50, 100, 200, 350);
    // _tableView = [[UITableView alloc] initWithFrame:CGRectMake(50, 30, 250, 350)];
    _scrollView.frame = CGRectMake(30, 150, 350, 500);
}
- (UIScrollView *)scrollView {
    
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        // _scrollView.frame = CGRectMake(0, 0, kScreenW, kScreenH-bottomMargin);
        _scrollView.frame = CGRectMake(30, 100, 350, 500);
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = YES;
        _scrollView.showsHorizontalScrollIndicator = YES;
      //  _scrollView.contentSize = CGSizeMake(kScreenW*4, 0);//2就是有几张侧翻
        _scrollView.backgroundColor = [UIColor yellowColor];
    }
    return _scrollView;
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
    [self.view addSubview:button];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button1 setFrame:CGRectMake(130, 150, 60, 30)];
         [button1 setTitle:@"按钮一" forState:UIControlStateNormal];
    button1.titleLabel.font = [UIFont systemFontOfSize:15];
         button1.titleLabel.text = @"按钮3";
        button1.titleLabel.textColor = [UIColor blueColor];
    [self.view addSubview:button1];
    
         UIButton *button2 = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
         [button2 setFrame:CGRectMake(149, 190, 22, 22)];
    [self.view addSubview:button2];
        UIButton *button3 = [UIButton buttonWithType:UIButtonTypeInfoLight];
         [button3 setFrame:CGRectMake(149, 230, 22, 22)];
    [self.view addSubview:button3];
        UIButton *button4 = [UIButton buttonWithType:UIButtonTypeInfoDark];
         [button4 setFrame:CGRectMake(149, 270, 22, 22)];
    [self.view addSubview:button4];
         UIButton *button5 = [UIButton buttonWithType:UIButtonTypeContactAdd];
         [button5 setFrame:CGRectMake(149, 310, 22, 22)];
    [self.view addSubview:button5];
        UIButton *button6 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
         [button6 setFrame:CGRectMake(130, 350, 60, 30)];
         [button6 setTitle:@"按钮六" forState:UIControlStateNormal];
    [self.view addSubview:button6];
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
-(void)TestDelegate
{
   
}
-(void)TestFunctionAndExample
{
    //加NavigationBar属性
    self.title = @"金彭星";
    self.navBarTintColor = [UIColor yellowColor];
    self.navAlpha = 1;
    self.navTitleColor = [UIColor grayColor];
    [self laoWangKaiYe];
    _touchView=[[TouchViewfromScroll alloc] initWithFrame:CGRectMake(0, 400,400, 200)];
    _touchView.backgroundColor=[UIColor grayColor];
    [self.view addSubview:self.touchView];
    
    //增加UIImageView图层
    UIImageView *imageview=[[UIImageView alloc] initWithFrame:CGRectMake(50, 100, 300, 70)];
    imageview.backgroundColor=[UIColor redColor];
    imageview.alpha=0.8;
    imageview.hidden=NO;
    [self.view addSubview:imageview];
    
    [self PrintWord]; //测试category
    //测试block
    self.blocksample=[[BlockSample alloc] init];
    [self.blocksample runBlockFunction];
    [self.blocksample testBlock];
    
    
}
- (void)laoWangKaiYe{
    NSLog(@"老王开业了");
    
    UIVDelegate *dachu1 = [[UIVDelegate alloc] initWithFrame:CGRectMake(30, 60, 300, 400)];
    //   UIVDelegate *uiviewdelgate=[[UIVDelegate alloc] i
    dachu1.backgroundColor=[UIColor lightGrayColor];
    [self.view addSubview:dachu1];
    dachu1.delegate = self;//说明老王充当代理的角色，负责接收菜好了的信号。
    [dachu1 kaiShiZuoCai];//大厨开始做菜
}
//- (void)tackCookAfterCookDone{
//   NSLog(@"服务员收到铃声，准备端菜了");//这里可以通知服务员去上菜了
//}
-(void)takeWaterAfterCookDone
{
    NSLog(@"服务员开始倒水了");//这里可以通知服务员去倒水了
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
 

@end
