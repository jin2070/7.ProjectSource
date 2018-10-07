//
//  A-TableView.m
//  ToolUIKit
//
//  Created by pc on 2018/9/17.
//  Copyright © 2018年 Jinchuncheng. All rights reserved.
//

#import "A-TableView.h"

@interface A_TableView ()  <UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) NSMutableArray *tableDataArr;
@end
static NSString *identifier =@"TableViewCell";
@implementation A_TableView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadData];
    
    self.tableViewShow.delegate=self;
    self.tableViewShow.dataSource=self;
    
    //self.tableViewShow.dataSource=self;
    self.tableViewShow.backgroundColor=[UIColor lightGrayColor];
    [self.tableViewShow reloadData];
    
}


- (void)loadData {
    //初始化数组
    self.tableDataArr = [NSMutableArray array];
   
    //加入20个字符串到数组中
    for(int i = 0; i < 20; i++) {
        [self.tableDataArr addObject:[NSString stringWithFormat:@"table item %i", i]];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"tableData count=%ld",[self.tableDataArr count]);
    return [self.tableDataArr count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   //UITableViewCell *cell = [self.tableViewShow dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath.row];
    UITableViewCell *cell=[self.tableViewShow dequeueReusableCellWithIdentifier:identifier];
    //为单元格的label设置数据
    if(cell==nil){
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    cell.textLabel.text = [self.tableDataArr objectAtIndex:indexPath.row];
    cell.detailTextLabel.text=@"hello";
    NSLog(@"indexPath:%@",indexPath);
 //   NSLog(@"Row....:%l",indexPath.row);
    cell.imageView.image=[UIImage imageNamed:@"008.png"];

    

    return cell;
}

/*
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableDataArr removeObjectAtIndex:indexPath.row];
    [self.tableViewshow reloadData];
}
*/

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
