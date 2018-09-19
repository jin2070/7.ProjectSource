//
//  SqliteView.h
//  TestViewAction
//
//  Created by pc on 2018/9/12.
//  Copyright © 2018年 Jinchuncheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SqliteView : UIView
+ (NSString *)getDocumentPath;
-(void)CreateSqliteFile;
-(void)CreateSqliteTable;
@end
