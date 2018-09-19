//
//  SqliteView.m
//  TestViewAction
//
//  Created by pc on 2018/9/12.
//  Copyright © 2018年 Jinchuncheng. All rights reserved.
//

#import "SqliteView.h"
#import <sqlite3.h>
#import "SqlServiceClass.h"
#define TXTHEIGHT 50
#define TXTLEFT 80
#define TXTRIGHT 200
#define LBLLEFT 10
#define LBLRIGHT 60
#define BTNLEFT 100
#define BTNRIGHT 150



@interface SqliteView()
@property(nonatomic)sqlite3 *sqlite;
@property (nonatomic) IBOutlet UITextField *nameField;
@property (nonatomic) IBOutlet UITextField *priceField;
@property (nonatomic) IBOutlet UITextField *idField;
@property(nonatomic)UILabel *nameLabel;
@property(nonatomic)UILabel *priceLabel;
@property(nonatomic)UILabel *idLabel;
@property(nonatomic) UIButton *addButton;
@property(nonatomic) UIButton *delButton;
@property(nonatomic) UIButton *replaceButton;
@property(nonatomic) UIButton *findButton;
@property(nonatomic,strong)SqlServiceClass *sqlserviceClass;

@end
@implementation SqliteView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
#pragma mark - Init
- (void)drawRect:(CGRect)rect {
    
    // Drawing code
    [self initInputView];
}
-(void)initInputView
{
    self.sqlserviceClass=[[SqlServiceClass alloc] init];
    [self.sqlserviceClass openDB];
    
    self.nameField=[[UITextField alloc]initWithFrame:CGRectMake(TXTLEFT, 100, TXTRIGHT, TXTHEIGHT)];
    self.nameField.backgroundColor=[UIColor whiteColor];
    self.nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(LBLLEFT, 100, LBLRIGHT, TXTHEIGHT)];
    [self.nameLabel setText:@"Name"];
    [self.nameLabel setTextColor:[UIColor blackColor]];
    [self addSubview:self.nameLabel];
    [self addSubview:self.nameField];
    
    self.priceField=[[UITextField alloc]initWithFrame:CGRectMake(TXTLEFT, 170, TXTRIGHT, TXTHEIGHT)];
    self.priceField.backgroundColor=[UIColor whiteColor];
    self.priceLabel=[[UILabel alloc]initWithFrame:CGRectMake(LBLLEFT, 170, LBLRIGHT, TXTHEIGHT)];
    [self.priceLabel setText:@"Price"];
    [self.priceLabel setTextColor:[UIColor blackColor]];
    [self addSubview:self.priceLabel];
    [self addSubview:self.priceField];
    
    self.addButton=[[UIButton alloc] initWithFrame:CGRectMake(BTNLEFT, 250, BTNRIGHT, TXTHEIGHT)];
    [self.addButton setTitle:@"增加数据" forState:UIControlStateNormal];
    [self.addButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.addButton.backgroundColor=[UIColor yellowColor];
    [self addSubview:self.addButton];
    [self.addButton addTarget:self action:@selector(AddColumeData:) forControlEvents:UIControlEventTouchUpInside];
    
    self.idField=[[UITextField alloc]initWithFrame:CGRectMake(TXTLEFT, 320, TXTRIGHT, TXTHEIGHT)];
    self.idField.backgroundColor=[UIColor whiteColor];
    self.idLabel=[[UILabel alloc]initWithFrame:CGRectMake(LBLLEFT, 320, LBLRIGHT, TXTHEIGHT)];
    [self.idLabel setText:@"ID = "];
    [self.idLabel setTextColor:[UIColor blackColor]];
    [self addSubview:self.idField];
    [self addSubview:self.idLabel];
    
    self.findButton=[[UIButton alloc] initWithFrame:CGRectMake(BTNLEFT, 390, BTNRIGHT, TXTHEIGHT)];
    [self.findButton setTitle:@"查找数据" forState:UIControlStateNormal];
    [self.findButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.findButton.backgroundColor=[UIColor yellowColor];
    [self addSubview:self.findButton];
    [self.findButton addTarget:self action:@selector(FindSqlData:) forControlEvents:UIControlEventTouchUpInside];
    
    self.replaceButton=[[UIButton alloc] initWithFrame:CGRectMake(BTNLEFT, 460, BTNRIGHT, TXTHEIGHT)];
    [self.replaceButton setTitle:@"更改数据" forState:UIControlStateNormal];
    [self.replaceButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.replaceButton.backgroundColor=[UIColor yellowColor];
    [self addSubview:self.replaceButton];
    [self.replaceButton addTarget:self action:@selector(FindSqlData:) forControlEvents:UIControlEventTouchUpInside];
    
    self.delButton=[[UIButton alloc] initWithFrame:CGRectMake(BTNLEFT, 530, BTNRIGHT, TXTHEIGHT)];
    [self.delButton setTitle:@"删除数据" forState:UIControlStateNormal];
    [self.delButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.delButton.backgroundColor=[UIColor yellowColor];
    [self addSubview:self.delButton];
    [self.delButton addTarget:self action:@selector(FindSqlData:) forControlEvents:UIControlEventTouchUpInside];
    
}
#pragma mark - CreateFile & Table
-(void)CreateSqliteFile
{
    static NSString * const fileName = @"King.sqlite";
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]stringByAppendingPathComponent:fileName];
    // 打开数据库连接，如果有就打开，没有就重新创建连接
    NSInteger state = sqlite3_open(filePath.UTF8String, &_sqlite);
    // 枚举值SQLITE_OK代表成功的状态
    if (state == SQLITE_OK)
        NSLog(@"----- 打开数据库成功 -----");
    else
        NSLog(@"----- 打开数据库失败 -----");
}
-(void)CreateSqliteTable
{
    // 创表语句，IF NOT EXISTS防止创建重复的表，AUTOINCREMENT是自动增长关键字，real是数字类型
    const char *sql = "CREATE TABLE IF NOT EXISTS t_SQLite(id integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL, price real)";
    //保存错误信息的变量
    char *errorMessage = NULL;
    sqlite3_exec(_sqlite, sql, NULL, NULL, &errorMessage);
    // 如果存在报错信息，代表语句执行失败，比判断枚举值要更简单一些
    if (errorMessage)
        NSLog(@"----- 创建表失败 -> errorMessage: %s -----", errorMessage);
    else
        NSLog(@"----- 创建表成功 -----");
}
#pragma mark - ExecFunction

 -(void)AddColumeData:(UIButton *)sender
 {
     sqlTestList *insertList=[[sqlTestList alloc]init];
     //NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    // insertList.sqlname=[self.nameField.text stringByReplacingCharactersInRange:NSMakeRange(<#NSUInteger loc#>, <#NSUInteger len#>) withString:<#(nonnull NSString *)#>
     NSLog(@"nameField= %@",self.nameField.text);
     insertList.sqlname=self.nameField.text;
     insertList.sqlText=self.priceField.text;
     insertList.sqlID=[self.idField.text intValue];
     [self.sqlserviceClass insertTestList:insertList];
 
 
 }
//查询数据
-(void)FindSqlData:(UIButton *)sender{
  //  self.sqlserviceClass.getTestList *findDataouput;
    sqlTestList *findDataouput=[[sqlTestList alloc]init];
    NSString *searchWord=self.nameField.text;
    NSMutableArray *mutableData=[[NSMutableArray alloc]init];
    //NSArray *singleData=[[NSArray alloc]init];
    mutableData=[self.sqlserviceClass searchTestList:searchWord];
    findDataouput=[mutableData objectAtIndex:0];
    self.priceField.text=findDataouput.sqlText;
    self.idField.text=[NSString stringWithFormat:@"%d",findDataouput.sqlID];
    
//- (NSMutableArray*)searchTestList:(NSString*)searchString{

   
 }
 -(void)DeleteSqlData:(UIButton *)sender
 {
 
 }
 -(void)replaceSqlData:(UIButton *)sender
 {
 
 }
 + (NSString *)getDocumentPath
 {
 NSString *homePath;
 NSFileManager *manager;
 homePath = NSHomeDirectory();
 manager = [NSFileManager defaultManager];
 NSLog(@"根路径地址：%@",homePath);
 NSArray *filePaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
 return [filePaths objectAtIndex:0];
 }
 
/*
-(void)AddColumeData:(UIButton *)sender
{
    
    NSString *name = [self.nameField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    CGFloat price = self.priceField.text.floatValue;
    // 拼接插入数据的sql语句
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO t_SQLite(name,price) VALUES('%@',%f)", name, price];
    char *errorMessage = NULL;
    sqlite3_exec(self.sqlite, sql.UTF8String, NULL, NULL, &errorMessage);
    if (errorMessage)
        NSLog(@"----- 插入数据失败 -> errorMessage: %s -----", errorMessage);
    else
        NSLog(@"----- 插入数据成功 -----");
    
}
-(void)FindSqlData:(UIButton *)sender
{
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:10];
    //判断数据库是否打开
    if (self.sqlite) {
        
        sqlite3_stmt *statement = nil;
        //sql语句
        NSString *querySQL = [NSString stringWithFormat:@"SELECT * from t_SQLite where id like \"%@\"",self.idField];
        const char *sql = [querySQL UTF8String];
        //        char *sql = "SELECT * FROM testTable WHERE testName like ?";//这里用like代替=可以执行模糊查找，原来是"SELECT * FROM testTable WHERE testName = ?"
        if (sqlite3_prepare_v2(_sqlite, sql, -1, &statement, NULL) != SQLITE_OK) {
            NSLog(@"Error: failed to prepare statement with message:search testValue.");
         //   return NO;
        } else {
            sqlTestList *searchList = [[sqlTestList alloc]init];
            //            sqlite3_bind_int(statement, 1, searchID);
            sqlite3_bind_text(statement, 3, [searchString UTF8String], -1, SQLITE_TRANSIENT);
            //查询结果集中一条一条的遍历所有的记录，这里的数字对应的是列值。
            while (sqlite3_step(statement) == SQLITE_ROW) {
                sqlTestList* sqlList = [[sqlTestList alloc] init] ;
                sqlList.sqlID   = sqlite3_column_int(statement,1);
                char* strText   = (char*)sqlite3_column_text(statement, 2);
                sqlList.sqlText = [NSString stringWithUTF8String:strText];
                char *strName = (char*)sqlite3_column_text(statement, 3);
                sqlList.sqlname = [NSString stringWithUTF8String:strName];
                [array addObject:sqlList];
                [sqlList release];
            }
            [searchList release];
        }
        sqlite3_finalize(statement);
        sqlite3_close(_database);
    }
    
   // return [array retain];
    
    
    //查询数据
    let query = "select * from studets"
    //这条执行后，数据就已经在sattement中了
    sqlite3_prepare_v2(db, query, -1, &statement, nil)
    //游标往下走一步，如果返回SQLITE_ROW就进入
    while sqlite3_step(statement) == SQLITE_ROW{
        let id = sqlite3_column_int(statement, 0)
        let stuId = sqlite3_column_int(statement, 2)
    }


        NSLog(@"----- 读取数据失败 -----");
    
}
-(void)DeleteSqlData:(UIButton *)sender
{
    
}
-(void)replaceSqlData:(UIButton *)sender
{
    
}
+ (NSString *)getDocumentPath
{
    NSString *homePath;
    NSFileManager *manager;
    homePath = NSHomeDirectory();
    manager = [NSFileManager defaultManager];
    NSLog(@"根路径地址：%@",homePath);
    NSArray *filePaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [filePaths objectAtIndex:0];
}
*/
@end

