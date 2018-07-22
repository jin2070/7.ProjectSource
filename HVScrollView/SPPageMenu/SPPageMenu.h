//
//  SPPageMenu.h
//  SPPageMenu
//
//  Created by 乐升平 on 17/10/26. https://github.com/SPStore/SPPageMenu
//  Copyright © 2017年 iDress. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, SPPageMenuTrackerStyle) {
    SPPageMenuTrackerStyleLine = 0,                  // 下划线,默认与item等宽
    SPPageMenuTrackerStyleLineLongerThanItem,        // 下划线,比item要长(长度为item的宽+间距)
    SPPageMenuTrackerStyleLineAttachment,            // 下划线依恋样式
    SPPageMenuTrackerStyleTextZoom,                  // 文字缩放
    SPPageMenuTrackerStyleRoundedRect,               // 圆角矩形
    SPPageMenuTrackerStyleRect                       // 矩形
};

typedef NS_ENUM(NSInteger, SPPageMenuPermutationWay) {
    SPPageMenuPermutationWayScrollAdaptContent = 0,   // 自适应内容,可以左右滑动
    SPPageMenuPermutationWayNotScrollEqualWidths,     // 等宽排列,不可以滑动,整个内容被控制在pageMenu的范围之内,等宽是根据pageMenu的总宽度对每个item均分
    SPPageMenuPermutationWayNotScrollAdaptContent     // 自适应内容,不可以滑动,整个内容被控制在pageMenu的范围之内,这种排列方式下,自动计算item之间的间距,itemPadding属性设置无效
};

typedef NS_ENUM(NSInteger, SPItemImagePosition) {
    SPItemImagePositionDefault,   // 默认图片在左边
    SPItemImagePositionLeft,      // 图片在左边
    SPItemImagePositionTop,       // 图片在上面
    SPItemImagePositionRight,     // 图片在右边
    SPItemImagePositionBottom     // 图片在下面
};

@class SPPageMenu;

@interface SPPageMenu : UIView

// 创建pagMenu
+ (instancetype)pageMenuWithFrame:(CGRect)frame trackerStyle:(SPPageMenuTrackerStyle)trackerStyle;
- (instancetype)initWithFrame:(CGRect)frame trackerStyle:(SPPageMenuTrackerStyle)trackerStyle;

/**
 *  传递数组(数组元素只能是NSString或UIImage类型)
 *
 *  @param items    数组
 *  @param selectedItemIndex  选中哪个item
 */
- (void)setItems:(nullable NSArray *)items selectedItemIndex:(NSUInteger)selectedItemIndex;

/** 选中的item下标 */
@property (nonatomic) NSUInteger selectedItemIndex;

/** 是否需要文字渐变,默认为YES */
@property (nonatomic, assign) BOOL needTextColorGradients;

/** 外界的srollView，pageMenu会监听该scrollView的滚动状况，让跟踪器时刻跟随此scrollView滑动 */
@property (nonatomic, strong) UIScrollView *bridgeScrollView;
/** 关闭跟踪器的跟随效果,在外界传了scrollView进来或者调用了moveTrackerFollowScrollView的情况下,如果为YES，则当外界滑动scrollView时，跟踪器不会时刻跟随,只有滑动结束才会跟踪; 如果为NO，跟踪器会时刻跟随scrollView */
@property (nonatomic, assign) BOOL closeTrackerFollowingMode;

/** 是否显示功能按钮(功能按钮显示在最右侧),默认为NO */
@property (nonatomic, assign) BOOL showFuntionButton;
/** item之间的间距,当permutationWay为‘SPPageMenuPermutationWayNotScrollAdaptContent’时此属性无效 */
@property (nonatomic, assign) CGFloat itemPadding;
/** item的标题字体 */
@property (nonnull, nonatomic, strong) UIFont *itemTitleFont;
/** 选中的item标题颜色 */
@property (nonatomic, strong) UIColor *selectedItemTitleColor;
/** 未选中的item标题颜色 */
@property (nonatomic, strong) UIColor *unSelectedItemTitleColor;

/** 分割线 */
@property (nonatomic, readonly) UIImageView *dividingLine;

/** 内容的四周内边距(内容不包括分割线) */
@property (nonatomic, assign) UIEdgeInsets contentInset;
/** 排列方式 */
@property (nonatomic, assign) SPPageMenuPermutationWay permutationWay;

// 插入item,插入和删除操作时,如果itemIndex超过了了items的个数,则不做任何操作
- (void)insertItemWithTitle:(nullable NSString *)title atIndex:(NSUInteger)itemIndex animated:(BOOL)animated;

// 如果移除的正是当前选中的item(当前选中的item下标不为0),删除之后,选中的item会切换为上一个item
- (void)removeItemAtIndex:(NSUInteger)itemIndex animated:(BOOL)animated;
- (void)removeAllItems;

// 设置指定item的标题,设置后，如果原先的item为image，则image会被title替换
- (void)setTitle:(nullable NSString *)title forItemAtIndex:(NSUInteger)itemIndex;
// 获取指定item的标题
- (nullable NSString *)titleForItemAtIndex:(NSUInteger)itemIndex;


// 获取指定item的enabled状态
- (BOOL)enabledForItemAtIndex:(NSUInteger)itemIndex;

// 设置指定item的宽度(如果width为0,则item将自动计算)
- (void)setWidth:(CGFloat)width forItemAtIndex:(NSUInteger)itemIndex;
// 获取指定item的宽度
- (CGFloat)widthForItemAtIndex:(NSUInteger)itemIndex;



@end

NS_ASSUME_NONNULL_END










