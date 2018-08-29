//
//  Base.h
//  TestViewAction
//
//  Created by pc on 2018/8/5.
//  Copyright © 2018年 Jinchuncheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Base : UIViewController
@property (nonatomic, strong) UIScrollView *scrollView;
//@property (nonatomic, strong) MyHeaderView *headerView;
@property (nonatomic, assign) CGPoint lastContentOffset;
@property (nonatomic, strong) UITableView *tableView;
@end
