//
//  NavigationTest.m
//  ToolUIKit
//
//  Created by pc on 2018/10/5.
//  Copyright © 2018年 Jinchuncheng. All rights reserved.
//

#import "NavigationTest.h"
#import "ViewController.h"
#define UserMethod1 1

@interface NavigationTest ()
@property(nonatomic,strong)IBOutlet UINavigationController *navigationCT;
@end

@implementation NavigationTest
-(void)viewWillAppear:(BOOL)animated
{
      //  [self  setBackButtonTitle];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"008"]
    
   // [self  setBackButtonTitle];
    [self addButtonOnBar];
    [self choiceOnBar];
}
- (void)setBackButtonTitle {
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"返回", nil)
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self action:@selector(goToBack)];
    leftButton.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = leftButton;
}
-(void)goToBack
{

    //跳转到前一个界面
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"hello");
}
-(void)dispearBarBackground
{
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    //设置透明的背景图，便于识别底部线条有没有被隐藏
    [navigationBar setBackgroundImage:[[UIImage alloc] init]
                       forBarPosition:UIBarPositionAny
                           barMetrics:UIBarMetricsDefault];
    //此处使底部线条失效
    [navigationBar setShadowImage:[UIImage new]];
    
}
-(void)choiceOnBar{
    UISegmentedControl *segControl = [[UISegmentedControl alloc] initWithItems:@[@"消息",@"页数",@"电话"]];
    segControl.tintColor = [UIColor colorWithRed:0.07 green:0.72 blue:0.96 alpha:1];
    [segControl setSelectedSegmentIndex:0];
    self.navigationItem.titleView = segControl;
}



-(void)addButtonOnBar
{
    UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(closeAction)];
    if (UserMethod1) {
        //方法一:
        UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"返回", nil)
                                                                       style:UIBarButtonItemStylePlain
                                                                      target:self action:@selector(goToBack)];
        leftButton.tintColor = [UIColor whiteColor];
        self.navigationItem.leftBarButtonItem = leftButton;
        self.navigationItem.rightBarButtonItems = @[closeItem];
        //要求显示默认的返回按钮，但是文字会显示默认的Back，暂时还不知道这个文字怎么改
      //  self.navigationItem.leftItemsSupplementBackButton = YES;
    }
    else {
        //方法二
        UIButton* leftButton = [UIButton buttonWithType:UIButtonTypeSystem];
        leftButton.backgroundColor = [UIColor clearColor];
        leftButton.frame = CGRectMake(0, 0, 45, 40);
        [leftButton setImage:[UIImage imageNamed:@"LeftButton_back_Icon"] forState:UIControlStateNormal];
        [leftButton setTitle:@"返回" forState:UIControlStateNormal];
        leftButton.tintColor = [UIColor whiteColor];
        leftButton.autoresizesSubviews = YES;
        leftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        leftButton.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin;
        [leftButton addTarget:self action:@selector(goToBack) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem* backItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
        
       // self.navigationItem.leftBarButtonItems = @[backItem,closeItem];
        self.navigationItem.rightBarButtonItems = @[backItem,closeItem];
     //  self.navigationItem.rightBarButtonItem=@[closeItem];
    }
}
//关闭程序
-(void)closeAction{
    //[self dismissModalStack];
      exit(0);
}
-(void)dismissModalStack {
    UIViewController *vc = self.presentingViewController;
    while (vc.presentingViewController) {
        vc = vc.presentingViewController;
        
    }
    [vc dismissViewControllerAnimated:YES completion:NULL];
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
