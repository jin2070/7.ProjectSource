//
//  ViewController.m
//  HVScrollView
//
//  Created by Libo on 17/6/14.
//  Copyright © 2017年 iDress. All rights reserved.
//

// ----------- 悬浮菜单SPPageMenu的框架github地址:https://github.com/SPStore/SPPageMenu ---------
// ----------- 本demo地址:https://github.com/SPStore/HVScrollView ----------

#import "ViewController.h"
#import "SPPageMenu.h"

@interface ViewController () <UIScrollViewDelegate>
@property (nonatomic, strong) SPPageMenu *pageMenu;
@end

@implementation ViewController



#pragma mark - 子图初始化&Layout设定
- (SPPageMenu *)pageMenu {
//    UIImage *hello=[UIImage imageNamed:@"222.jpg"];
    if (!_pageMenu) {
       
        _pageMenu = [SPPageMenu pageMenuWithFrame:CGRectMake(0, 200, 400, 40) trackerStyle:SPPageMenuTrackerStyleLineLongerThanItem];
        [_pageMenu setItems:@[@"章节kassdfsfdasf结尾长吗",@"搜索🔍",@"路线",@"查找结果"] selectedItemIndex:2];//@"查找结果"

    }
    return _pageMenu;
}

#pragma mark - 打开初始化&加载子图
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.pageMenu];
}
//内存不足时释放内存
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
