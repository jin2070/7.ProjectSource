//
//  ChapterViewController.m
//  TestViewAction
//
//  Created by pc on 2018/10/1.
//  Copyright © 2018年 Jinchuncheng. All rights reserved.
//

#import "ChapterViewController.h"
#import "ContentViewController.h"
#define kViewControllerKey        @"viewController"
#define kTitleKey                @"title"
#define kDetailKey                @"detail text"
@interface ChapterViewController ()

@end

@implementation ChapterViewController
/*
- (id)init:(NSString *)title andVersesAmount:(NSInteger)num
{
    self = [super initWithNibName:@"Chapter" bundle:nil];
    if (self) {
        // Custom initialization
        self.title = booksName = title;
        versesAmount = num;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(swipeNotify:) name:[NSString stringWithFormat:@"%@%@", @"swipeNotify", booksName] object:nil];
    }
    return self;
}
 */
-(void)getInfoFromMainViewController:(NSString *)title andVersesAmount:(NSInteger)num
{
    self.title = self.booksName = title;
    self.versesAmount = num;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(swipeNotify:) name:[NSString stringWithFormat:@"%@%@", @"swipeNotify", self.booksName] object:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.booksName;
    self.menuList = [NSMutableArray array];
    
    if ([self.booksName isEqualToString:@"詩篇"] || [self.booksName isEqualToString:@"诗篇"])
        for (int i=1; i<=self.versesAmount; i++) {
            [self.menuList addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      [NSString stringWithFormat: @"第 %d 篇",i], kTitleKey,
                                      [NSString stringWithFormat: @"%d",i], kDetailKey,
                                      nil]];
            
        }
    else
        for (int i=1; i<=self.versesAmount; i++) {
            [self.menuList addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      [NSString stringWithFormat: @"第 %d 章",i], kTitleKey,
                                      [NSString stringWithFormat: @"%d",i], kDetailKey,
                                      nil]];
            
        }
    [self initTableView];
    self.chapterTableView.delegate=self;
    self.chapterTableView.dataSource=self;
    [self.chapterTableView reloadData];
    // Do any additional setup after loading the view.
}
-(void)initTableView{
    
    self.chapterTableView=[[UITableView alloc]initWithFrame:CGRectMake(2, 65, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:self.chapterTableView];
}
#pragma mark -
#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.menuList count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *kCellIdentifier = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kCellIdentifier];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.textLabel.opaque = NO;
        cell.textLabel.textColor = [UIColor blackColor];
        cell.textLabel.highlightedTextColor = [UIColor whiteColor];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:18];
        
        cell.detailTextLabel.backgroundColor = [UIColor clearColor];
        cell.detailTextLabel.opaque = NO;
        cell.detailTextLabel.textColor = [UIColor grayColor];
        cell.detailTextLabel.highlightedTextColor = [UIColor whiteColor];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    }
    
    // get the view controller's info dictionary based on the indexPath's row
    NSDictionary *dataDictionary = [self.menuList objectAtIndex:indexPath.row];
    cell.textLabel.text = [dataDictionary valueForKey:kTitleKey];
    cell.detailTextLabel.text = @"";
    
    return cell;
}
#pragma mark -
#pragma mark UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.currentIndex = indexPath.row;
    
    NSMutableDictionary *rowData = [self.menuList objectAtIndex:indexPath.row];
    ContentViewController *targetViewController = [rowData objectForKey:kViewControllerKey];
    if (!targetViewController) {
        targetViewController = [[ContentViewController  alloc] init];
        [targetViewController getInfoFromChapterViewController:self.booksName andVersesAmount:[rowData objectForKey:kDetailKey]];
        [rowData setValue:targetViewController forKey:kViewControllerKey];
   //     [targetViewController release];
    }
    [self.navigationController pushViewController:targetViewController animated:YES];
}

#pragma mark - KVO
- (void)swipeNotify:(NSNotification *)notification
{
    
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
