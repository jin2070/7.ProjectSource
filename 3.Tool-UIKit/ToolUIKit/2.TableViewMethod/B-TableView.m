//
//  B-TableView.m
//  ToolUIKit
//
//  Created by pc on 2018/9/17.
//  Copyright © 2018年 Jinchuncheng. All rights reserved.
//

#import "B-TableView.h"

@interface B_TableView ()

@end

@implementation B_TableView
@synthesize tableView=_tableView;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //  self.tableView=[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    // self.tableView=[UITableView alloc]initWithFrame:CGRectMake(10, 30, 300, 400)
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(10, 50, 350, 450) style:UITableViewStylePlain];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    
    [self.view addSubview:self.tableView];
    NSArray *arry=[NSArray arrayWithObjects:@"张三",@"张四",@"李三",@"李四",@"张三风",@"张天",@"张喔",@"发生",@"人类",@"送沙发",@"发售",@"老地方",@"藕粉",@"卫生",@"咖啡色",@"批发",@"气氛",@"那方",@"卡法巴斯",@"私密",@"客服",@"资料库",@"马上到！",@"拿上来",@"私服",@"发卡量", nil];
    self.listData=arry;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return [self.listData count];
    return 22;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"hello");
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row=[indexPath row];
    NSLog(@"----第 %zu 行",row);
    static NSString *TableSampledentifier=@"TableSampleIdentifier";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:TableSampledentifier];
    if(cell==nil){
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:TableSampledentifier];
    }
    /*
    else{
        while ([cell.contentView.subviews lastObject]!=nil) {
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    */
    
    NSString *strNumber=[NSString stringWithFormat:@"-----第%tu行",row];
    NSString *strCell=[self.listData objectAtIndex:row];
    NSString *appendString=[strCell stringByAppendingString:strNumber];
    cell.detailTextLabel.text=@"详细内容";
    cell.textLabel.text=appendString;
    cell.textLabel.backgroundColor=[UIColor blueColor];
    cell.textLabel.font=[UIFont boldSystemFontOfSize:20.0f];
    
    cell.textLabel.backgroundColor=[UIColor yellowColor];
    UIView *backgroundView=[[UIView alloc]initWithFrame:cell.frame];
    backgroundView.backgroundColor=[UIColor clearColor];
    cell.backgroundView=backgroundView;
    
    UIImage *image=[UIImage imageNamed:@"007.jpg"];
    cell.imageView.image=image;
    
    
    return cell;
}
//设置单元格缩进
-(NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row=[indexPath row];
    if(row %3==0)
    {
        return 0;
    }
    return 2;
}
//选中单元格所产生事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSLog(@"金春城");
    
    NSInteger row=[indexPath row];
    NSString *rowValue=[self.listData objectAtIndex:row];
    NSString *message=[[NSString alloc]initWithFormat:@"You selecte%@",rowValue];
   UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"显示的标题" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"点击取消");
        
    }]];
    
    
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"点击确认");
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"警告" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"点击警告");
        
    }]];
    
    
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
        NSLog(@"添加一个textField就会调用 这个block");
        
    }];
    // 由于它是一个控制器 直接modal出来就好了
    
    [self presentViewController:alertController animated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
