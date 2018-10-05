//
//  UITextMethod.h
//  ToolUIKit
//
//  Created by pc on 2018/10/3.
//  Copyright © 2018年 Jinchuncheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextMethod : UIViewController
@property (nonatomic, retain) NSMutableArray *menuList;
@property (nonatomic, retain) NSMutableArray *oList;
@property (nonatomic, retain) NSMutableArray *nList;

@property (strong, nonatomic) IBOutlet UITextView *A_textView;
-(void)A_ReadTextFile;
-(void)C_ReadSqlFile;
@end
