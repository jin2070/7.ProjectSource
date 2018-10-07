//
//  UITextMethod.m
//  ToolUIKit
//
//  Created by pc on 2018/10/3.
//  Copyright © 2018年 Jinchuncheng. All rights reserved.
//

#import "UITextMethod.h"
#import "FMDatabase.h"

#define kTitleKey                @"title"
#define kDetailKey                @"detail text"
#define kSimpifiedKey           @"simlified name"

@interface UITextMethod ()

@end

@implementation UITextMethod

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barStyle=UIBarStyleBlack;
    self.navigationController.navigationItem.title=@"瞰视";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self C_ReadSqlFile];
}
-(void)C_ReadSqlFile
{
    self.menuList = [NSMutableArray array];
    self.oList = [NSMutableArray array];
    self.nList = [NSMutableArray array];
    NSString *name;
    
    NSString *homePath;
    homePath = NSHomeDirectory();
    NSString *dbpath = [[NSBundle mainBundle] pathForResource:@"aa.sqlite" ofType:nil];
    NSLog(@"根路径地址：%@",dbpath);
    FMDatabase* db = [FMDatabase databaseWithPath:dbpath];
    if (![db open]) {
        NSLog(@"Database Open failed!");
        return;
    }else{
    NSLog(@"Database Open Succeed!");
}
    FMResultSet *rs;
    int i=0;
    rs = [db executeQuery:@"select *from aa[se"];
    while ([rs next]) {
        if(i==5)
        {
            name = [rs stringForColumn:@"content"];
            NSLog(@"name: %@ ",name);
        }
      	  i++;
    }
    self.A_textView.text=name;
    [self.menuList addObject:self.oList];
    [self.menuList addObject:self.nList];
   
    [db close];
    
}
-(void)A_ReadTextFile
{
    
    NSString *contentPath = [[NSBundle mainBundle] pathForResource:@"etoc04" ofType:@"txt"];
 
    NSString *aa = [NSString stringWithContentsOfFile:contentPath encoding:NSASCIIStringEncoding error:nil];
   NSString *bb = [NSString stringWithContentsOfFile:contentPath encoding:NSUTF16BigEndianStringEncoding error:nil];
     NSString *cc= [NSString stringWithContentsOfFile:contentPath encoding:NSUTF16StringEncoding error:nil];
     NSString *dd = [NSString stringWithContentsOfFile:contentPath encoding:kCFStringEncodingUTF8 error:nil];
    NSString *ff = [NSString stringWithContentsOfFile:contentPath encoding:kCFStringEncodingUTF16 error:nil];
     NSString *ee = [NSString stringWithContentsOfFile:contentPath encoding:kCFStringEncodingGB_18030_2000 error:nil];
     NSString *gg = [NSString stringWithContentsOfFile:contentPath encoding:kCFStringEncodingGB_2312_80 error:nil];
      NSString *hh = [NSString stringWithContentsOfFile:contentPath encoding:NSUnicodeStringEncoding error:nil];
      NSString *ii = [NSString stringWithContentsOfFile:contentPath encoding:kCFStringEncodingUTF8 error:nil];
  NSLog(@"aa content:%@",aa);
  NSLog(@"bb content:%@",bb);
  NSLog(@"cc content:%@",cc);
  NSLog(@"dd content:%@",dd);
  NSLog(@"ff content:%@",ff);
  NSLog(@"ee content:%@",ee);
  NSLog(@"gg content:%@",gg);
  NSLog(@"hh content:%@",hh);
  NSLog(@"ii content:%@",ii);
//  NSLog(@"jj content:%@",jj);
  
    NSString *jj= [NSString stringWithContentsOfFile:contentPath encoding:NSUTF8StringEncoding error:nil];
   NSLog(@"jj content:%@",jj);
    self.A_textView.text=jj;
    
 
}
-(void)B_ReadTxtFile
{
    NSString *contentPath = [[NSBundle mainBundle] pathForResource:@"etoc04" ofType:@"txt"];
    NSString *content = [NSString stringWithContentsOfFile:contentPath encoding:kCFStringEncodingUTF8 error:nil];
    NSLog(@"====%@",content);
    self.A_textView.text=content;
    
     const char * aStr =[content UTF8String];
    
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding (kCFStringEncodingGB_18030_2000);
    

    int nLen =[self convertToInt:content];
    
    NSString* str = [[NSString alloc]initWithBytes:aStr length:nLen encoding:enc ];
   NSString* strs = [[NSString alloc]initWithBytes:aStr length:nLen encoding:kCFStringEncodingUTF16 ];
   NSLog(@"str = %@",str);
    NSLog(@"str = %@",strs);
    //NSLog(@"str = %@",content);
}



- (int)convertToInt:(NSString*)strtemp//判断中英混合的的字符串长度
{
    int strlength = 0;
    char *p = (char *)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0; i < [strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding]; i++)
    {
        if (*p) {
            p++;
            strlength++;        }
        else {
            p++;
            
        }    }
    return strlength;

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
