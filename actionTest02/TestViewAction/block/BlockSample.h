//
//  BlockSample.h
//  TestViewAction
//
//  Created by pc on 2018/7/29.
//  Copyright © 2018年 Jinchuncheng. All rights reserved.
//

#import <Foundation/Foundation.h>
//测试block
typedef int (^CYAddBlock) (int, int);
@interface BlockSample : NSObject
//(void)(^blockHello)();
-(void)runBlockFunction;
- (void)testBlock;
@end
