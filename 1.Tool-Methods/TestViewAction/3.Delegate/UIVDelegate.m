//
//  UIVDelegate.m
//  TestViewAction
//
//  Created by pc on 2018/7/31.
//  Copyright © 2018年 Jinchuncheng. All rights reserved.
//

#import "UIVDelegate.h"

@interface UIVDelegate()
@property (nonatomic,strong) NSString* text;
@end

@implementation UIVDelegate
- (void)StartToCook{  //开始做菜
    NSLog(@"大厨开始做菜");
    sleep(2);
    NSLog(@"大厨做好菜了，该上菜了");
    
    //下面这句是判断 一下delegate是否实现了doSomethingAftercaiZuohaole方法，如果delegate没有实现
    //直接[self.delegate doSomethingAftercaiZuohaole];会crash

    if (self.delegate && [self.delegate respondsToSelector:@selector(takeRiceAfterCookDone)]) {
        [self.delegate takeRiceAfterCookDone];
    }else if (self.delegate && [self.delegate respondsToSelector:@selector(takeWaterAfterCookDone)]){
        [self.delegate takeWaterAfterCookDone];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
