//
//  TouchViewfromScroll.h
//  TestViewAction
//
//  Created by pc on 2018/7/20.
//  Copyright © 2018年 Jinchuncheng. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN   //每个属性或每个方法都去指定nonnull和nullable，是一件非常繁琐的事。苹果为了减轻我们的工作量，专门提供了两个宏：NS_ASSUME_NONNULL_BEGIN， NS_ASSUME_NONNULL_END。在这两个宏之间的代码，所有简单指针对象都被假定为nonnull，因此我们只需要去指定那些nullable的指针。
typedef NS_ENUM(NSInteger, SPItemImagePosition) {
    SPItemImagePositionDefault,   // 默认图片在左边
    SPItemImagePositionLeft,      // 图片在左边
    SPItemImagePositionTop,       // 图片在上面
    SPItemImagePositionRight,     // 图片在右边
    SPItemImagePositionBottom     // 图片在下面
};
@interface TouchViewfromScroll : UIView<UIScrollViewDelegate>

@end
NS_ASSUME_NONNULL_END
