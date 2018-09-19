//
//  Base.m
//  TestViewAction
//
//  Created by pc on 2018/8/5.
//  Copyright © 2018年 Jinchuncheng. All rights reserved.
//

#import "Base.h"

@interface Base () <UITableViewDataSource,UITableViewDelegate>
//@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSInteger rowCount;
@end


@implementation Base


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.rowCount = 5;
    
    [self.view addSubview:self.tableView];
    self.scrollView = self.tableView;
    
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.rowCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell_1";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%zd行",indexPath.row];
    
    return cell;
}

- (UITableView *)tableView {
    
    if (!_tableView) {
       // _tableView=[UITableView alloc] initWithFrame:<#(CGRect)#> style:<#(UITableViewStyle)#>
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 250, 350) style:UITableViewStyleGrouped ];
        // _tableView.contentInset = UIEdgeInsetsMake(kScrollViewBeginTopInset, 0, 0, 0);
        // _tableView.scrollIndicatorInsets = UIEdgeInsetsMake(kScrollViewBeginTopInset, 0, 0, 0);
        _tableView.contentInset = UIEdgeInsetsMake(50, 0, 0, 0);
        _tableView.scrollIndicatorInsets = UIEdgeInsetsMake(200, 0, 0, 0);
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor=[UIColor lightGrayColor];
    }
    return _tableView;
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
