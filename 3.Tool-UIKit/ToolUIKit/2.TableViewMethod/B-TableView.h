//
//  B-TableView.h
//  ToolUIKit
//
//  Created by pc on 2018/9/17.
//  Copyright © 2018年 Jinchuncheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface B_TableView : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(strong,nonatomic)NSArray *listData;
@property(strong,nonatomic)IBOutlet UITableView *tableView;
//@property(strong,nonatomic)UITableViewCell *tableViewCell;

@end
