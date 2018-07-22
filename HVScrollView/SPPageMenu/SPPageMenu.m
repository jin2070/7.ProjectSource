//
//  SPPageMenu.m
//  SPPageMenu
//
//  Created by 乐升平 on 17/10/26. https://github.com/SPStore/SPPageMenu
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "SPPageMenu.h"
#import "ScrollviewFunction.h"
#define tagBaseValue 100
#define maxTextScale 0.3


//interface SPItem : UIButton
@interface SPItem : UIButton
@property (nonatomic, assign) CGFloat imageRatio;
@property (nonatomic, assign) SPItemImagePosition imagePosition;
@end
@implementation SPItem
@end

//interface SPPageMenu()
@interface SPPageMenu()
@property (nonatomic, assign) SPPageMenuTrackerStyle trackerStyle;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, assign) CGFloat trackerHeight;
@property (nonatomic, weak) UIView *backgroundView;
@property (nonatomic, strong) UIImageView *dividingLine;
@property (nonatomic, weak) UIScrollView *itemScrollView;
@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, strong) SPItem *selectedButton;
@property (nonatomic, strong) NSMutableDictionary *setupWidths;
@property (nonatomic, assign) BOOL insert;
// 起始偏移量,为了判断滑动方向
@property (nonatomic, assign) CGFloat beginOffsetX;
@end
@implementation SPPageMenu


#pragma mark - public

+ (instancetype)pageMenuWithFrame:(CGRect)frame trackerStyle:(SPPageMenuTrackerStyle)trackerStyle
{
    SPPageMenu *pageMenu = [[SPPageMenu alloc] initWithFrame:frame trackerStyle:trackerStyle];
    return pageMenu;
}

- (instancetype)initWithFrame:(CGRect)frame trackerStyle:(SPPageMenuTrackerStyle)trackerStyle {
    if (self = [super init]) {
        self.frame = frame;
        self.backgroundColor = [UIColor whiteColor];
        self.trackerStyle = trackerStyle;
    }
    return self;
}
- (void)insertItemWithTitle:(NSString *)title atIndex:(NSUInteger)itemIndex animated:(BOOL)animated {
    self.insert = YES;
    if (itemIndex > self.items.count) {return;}
    NSMutableArray *titleArr = self.items.mutableCopy;
    [titleArr insertObject:title atIndex:itemIndex];
    self.items = titleArr;
    [self addButton:itemIndex object:title animated:animated];
    if (itemIndex <= self.selectedItemIndex) {
        _selectedItemIndex += 1;
    }
}

- (void)removeItemAtIndex:(NSUInteger)itemIndex animated:(BOOL)animated {
    if (itemIndex > self.items.count) {return;}
    // 被删除的按钮之后的按钮需要修改tag值
    for (SPItem *button in self.buttons) {
        if (button.tag-tagBaseValue > itemIndex) {
            button.tag = button.tag - 1;
        }
    }
    if (self.items.count) {
        NSMutableArray *objects = self.items.mutableCopy;
        id object = [objects objectAtIndex:itemIndex];
        [objects removeObject:object];
        self.items = objects;
    }
    if (itemIndex < self.buttons.count) {
        SPItem *button = [self.buttons objectAtIndex:itemIndex];
        if (button == self.selectedButton) { // 如果删除的正是选中的item，删除之后，选中的按钮切换为上一个item
            self.selectedItemIndex = itemIndex > 0 ? itemIndex-1 : itemIndex;
        }
        [self.buttons removeObject:button];
        [button removeFromSuperview];
    }
    if (animated) {
        [UIView animateWithDuration:0.5 animations:^{
            [self setNeedsLayout];
            [self layoutIfNeeded];
        }];
    } else {
        [self setNeedsLayout];
    }
    
}

- (void)removeAllItems {
    NSMutableArray *objects = self.items.mutableCopy;
    [objects removeAllObjects];
    self.items = objects;
    self.items = nil;
    
    for (int i = 0; i < self.buttons.count; i++) {
        SPItem *button = self.buttons[i];
        [button removeFromSuperview];
    }
    
    [self.buttons removeAllObjects];
    
    self.selectedButton = nil;
    self.selectedItemIndex = 0;
    
    [self setNeedsLayout];
}

- (void)setTitle:(NSString *)title forItemAtIndex:(NSUInteger)itemIndex {
    if (itemIndex < self.buttons.count) {
        SPItem *button = [self.buttons objectAtIndex:itemIndex];
        [button setTitle:title forState:UIControlStateNormal];
    }
}

- (NSString *)titleForItemAtIndex:(NSUInteger)itemIndex {
    if (itemIndex < self.buttons.count) {
        SPItem *button = [self.buttons objectAtIndex:itemIndex];
        return button.currentTitle;
    }
    return nil;
}

- (BOOL)enabledForItemAtIndex:(NSUInteger)itemIndex {
    if (self.buttons.count) {
        SPItem *button = [self.buttons objectAtIndex:itemIndex];
        return button.enabled;
    }
    return YES;
}

- (void)setWidth:(CGFloat)width forItemAtIndex:(NSUInteger)itemIndex {
    [self.setupWidths setObject:@(width) forKey:[NSString stringWithFormat:@"%zd",itemIndex]];
}

- (CGFloat)widthForItemAtIndex:(NSUInteger)itemIndex {
    CGFloat setupWidth = [[self.setupWidths objectForKey:[NSString stringWithFormat:@"%zd",itemIndex]] floatValue];
    if (setupWidth) {
        return setupWidth;
    } else {
        if (itemIndex < self.buttons.count) {
            SPItem *button = [self.buttons objectAtIndex:itemIndex];
            return button.bounds.size.width;
        }
    }
    return 0;
}
- (void)setItems:(NSArray *)items selectedItemIndex:(NSUInteger)selectedItemIndex {
    _items = items.copy;
    _selectedItemIndex = selectedItemIndex;
    //插入itemScroll,初始化时
    self.insert = NO;
    
    //根据items菜单数量，增加buttons数组和itemscroll subview数量
    for (int i = 0; i < items.count; i++) {
        id object = items[i];
        [self addButton:i object:object animated:NO];
    }
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
}

#pragma mark - private

- (void)addButton:(NSInteger)index object:(id)object animated:(BOOL)animated {
    
    //按照一个一个button实例初始化后，增加到buttons数组
    SPItem *button = [SPItem buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:_unSelectedItemTitleColor forState:UIControlStateNormal]; //开始所有未按状态的颜色
    button.titleLabel.font = _itemTitleFont;
    //按键触发的时候，按键颜色变更以及itemscroll变化
    [button addTarget:self action:@selector(buttonInPageMenuClicked:) forControlEvents:UIControlEventTouchUpInside];
    //初始化tag排列，100开始排，index:0是100，
    button.tag = tagBaseValue + index;
    //根据菜单的格式，加入文字或图像
    if ([object isKindOfClass:[NSString class]]) {
        [button setTitle:object forState:UIControlStateNormal];
    } else {
        [button setImage:object forState:UIControlStateNormal];
    }
    NSLog(@"insert is:%@",self.insert?@"Yes":@"No");
    //itemscroll创建时里面为空，开始一个一个增加button
    if (self.insert) {
        [self.itemScrollView insertSubview:button atIndex:index+1];
        if (!self.buttons.count) {
            [self buttonInPageMenuClicked:button];
        }
    } else {
        [self.itemScrollView insertSubview:button atIndex:index];
    }
    //增加buttons数组
    [self.buttons insertObject:button atIndex:index];
    

}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    
    _itemPadding = 30;
    _itemTitleFont = [UIFont systemFontOfSize:16];
    _selectedItemTitleColor = [UIColor redColor];
    _unSelectedItemTitleColor = [UIColor blackColor];
    _trackerHeight = 3;
    _contentInset = UIEdgeInsetsZero;
    _selectedItemIndex = 0;
    _showFuntionButton = NO;
    _needTextColorGradients = YES;
    
    // 必须先添加分割线，再添加backgroundView;假如先添加backgroundView,那也就意味着backgroundView是SPPageMenu的第一个子控件,而scrollView又是backgroundView的第一个子控件,当外界在由导航控制器管理的控制器中将SPPageMenu添加为第一个子控件时，控制器会不断的往下遍历第一个子控件的第一个子控件，直到找到为scrollView为止,一旦发现某子控件的第一个子控件为scrollView,会将scrollView的内容往下偏移64;这时控制器中必须设置self.automaticallyAdjustsScrollViewInsets = NO;为了避免这样做，这里将分割线作为第一个子控件

    self.dividingLine.alpha=0.5;
    self.dividingLine.hidden=NO;
    [self addSubview:self.dividingLine];
   // _dividingLine = dividingLine;
    
    UIView *backgroundView = [[UIView alloc] init];
    backgroundView.layer.masksToBounds = YES;
    [self addSubview:backgroundView];
    _backgroundView = backgroundView;

    UIScrollView *itemScrollView = [[UIScrollView alloc] init];
    itemScrollView.showsVerticalScrollIndicator = NO;
    itemScrollView.showsHorizontalScrollIndicator = NO;
    [backgroundView addSubview:itemScrollView];
    _itemScrollView = itemScrollView;

}

// 按钮点击时菜单颜色变化，按钮tag的选择
- (void)buttonInPageMenuClicked:(SPItem *)senders {
    //不选的时候颜色恢复到灰色
   [self.selectedButton setTitleColor:_unSelectedItemTitleColor forState:UIControlStateNormal];
    //设定新button先赋值，再存上被选择的时候颜色亮色
    [senders setTitleColor:_selectedItemTitleColor forState:UIControlStateNormal];
    //被选择的tag
    CGFloat toIndex = senders.tag - tagBaseValue;

    // 更新下item对应的下标,必须在代理之前，否则外界在代理方法中拿到的不是最新的,必须用下划线，用self.会造成死循环
    _selectedItemIndex = toIndex;
   //新设的实例变量转到，selectedButton公有属性
    self.selectedButton = senders;
    NSLog(@"Last selectedbutton:%p",self.selectedButton);
}




#pragma mark - setter

- (void)setTrackerStyle:(SPPageMenuTrackerStyle)trackerStyle {
    _trackerStyle = trackerStyle;
    switch (trackerStyle) {
        case SPPageMenuTrackerStyleLine:
        case SPPageMenuTrackerStyleLineLongerThanItem:
        case SPPageMenuTrackerStyleLineAttachment:
        
            break;
        case SPPageMenuTrackerStyleRoundedRect:
        case SPPageMenuTrackerStyleRect:
  
            _selectedItemTitleColor = [UIColor whiteColor];
            break;
        default:
            break;
    }
}


- (void)setItemPadding:(CGFloat)itemPadding {
    _itemPadding = itemPadding;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setItemTitleFont:(UIFont *)itemTitleFont {
    _itemTitleFont = itemTitleFont;
    for (SPItem *button in self.buttons) {
        button.titleLabel.font = itemTitleFont;
    }
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setSelectedItemTitleColor:(UIColor *)selectedItemTitleColor {
    _selectedItemTitleColor = selectedItemTitleColor;
  
    [self.selectedButton setTitleColor:selectedItemTitleColor forState:UIControlStateNormal];
}

- (void)setUnSelectedItemTitleColor:(UIColor *)unSelectedItemTitleColor {
    _unSelectedItemTitleColor = unSelectedItemTitleColor;
 
    for (SPItem *button in self.buttons) {
        if (button == _selectedButton) {
            continue;  // 跳过选中的那个button
        }
        [button setTitleColor:unSelectedItemTitleColor forState:UIControlStateNormal];
    }
}

- (void)setSelectedItemIndex:(NSUInteger)selectedItemIndex {
    _selectedItemIndex = selectedItemIndex;
    if (self.buttons.count) {
        SPItem *button = [self.buttons objectAtIndex:selectedItemIndex];
        [self buttonInPageMenuClicked:button];
    }
}

- (void)setContentInset:(UIEdgeInsets)contentInset {
    _contentInset = contentInset;
    [self setNeedsLayout];
    [self layoutIfNeeded];
 
}

- (void)setPermutationWay:(SPPageMenuPermutationWay)permutationWay {
    _permutationWay = permutationWay;
    [self setNeedsLayout];
    [self layoutIfNeeded];

}

#pragma mark - getter

- (NSArray *)items {
    if (!_items) {
        _items = [NSMutableArray array];
    }
    return _items;
}

- (NSMutableArray *)buttons {
    
    if (!_buttons) {
        _buttons = [NSMutableArray array];
        
    }
    return _buttons;
}

- (NSMutableDictionary *)setupWidths {
    
    if (!_setupWidths) {
        _setupWidths = [NSMutableDictionary dictionary];
    }
    return _setupWidths;
}


#pragma mark - 布局

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat backgroundViewX = self.bounds.origin.x+_contentInset.left;
    CGFloat backgroundViewY = self.bounds.origin.y+_contentInset.top;
    CGFloat backgroundViewW = self.bounds.size.width-(_contentInset.left+_contentInset.right);
    CGFloat backgroundViewH = self.bounds.size.height-(_contentInset.top+_contentInset.bottom);
    NSLog(@"conteninset.lefe:%f, right:%f,top:%f,bottom:%f",_contentInset.left,_contentInset.right,_contentInset.top,_contentInset.bottom);
    //contentinset为0，backgroundview:与SPMenu size一样 0，0，400，40
    self.backgroundView.frame = CGRectMake(backgroundViewX, backgroundViewY, backgroundViewW, backgroundViewH);
    
    CGFloat dividingLineW = self.bounds.size.width;
    CGFloat dividingLineH = 20;//(self.dividingLine.hidden || self.dividingLine.alpha < 0.01) ? 0 : 0.5;
    CGFloat dividingLineX = 0;
    CGFloat dividingLineY = self.bounds.size.height-dividingLineH;
     NSLog(@"diviLine.lefe:%f, right:%f,top:%f,bottom:%f",dividingLineX, dividingLineY, dividingLineW, dividingLineH);
    //dividing.frame    尺寸 0, 20, 400, 20
    self.dividingLine.frame = CGRectMake(dividingLineX, dividingLineY, dividingLineW, dividingLineH);
   

    CGFloat functionButtonH = backgroundViewH-dividingLineH;
    CGFloat functionButtonW = functionButtonH;

    
    CGFloat itemScrollViewX = 0;
    CGFloat itemScrollViewY = 0;
    CGFloat itemScrollViewW = self.showFuntionButton ? backgroundViewW-functionButtonW : backgroundViewW;
    CGFloat itemScrollViewH = backgroundViewH-dividingLineH;
    NSLog(@"itemScrollview X:%f, Y:%f,width:%f,height:%f",itemScrollViewX, itemScrollViewY, itemScrollViewW, itemScrollViewH);
    //itemscrollview尺寸与 backgroudview, self 3个一样，只有height是一半高度 0，0，400，20
    self.itemScrollView.frame = CGRectMake(itemScrollViewX, itemScrollViewY, itemScrollViewW, itemScrollViewH);
    
    __block CGFloat buttonW = 0.0;
    __block CGFloat lastButtonMaxX = 0.0;
    
    CGFloat contentW = 0.0; // 文字宽
    CGFloat contentW_sum = 0.0; // 所有文字宽度之和
    NSMutableArray *buttonWidths = [NSMutableArray array];
    // 提前计算每个按钮的宽度，目的是为了计算间距
    for (int i= 0 ; i < self.buttons.count; i++) {
        SPItem *button = self.buttons[i];
        
        CGFloat setupButtonW = [[self.setupWidths objectForKey:[NSString stringWithFormat:@"%d",i]] floatValue];
        CGFloat textW = [button.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, itemScrollViewH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_itemTitleFont} context:nil].size.width;
        CGFloat imageW = button.currentImage.size.width;
        if (button.currentTitle && !button.currentImage) {
            contentW = textW;
        } else if(button.currentImage && !button.currentTitle) {
            contentW = imageW;
        } else if (button.currentTitle && button.currentImage && (button.imagePosition == SPItemImagePositionRight || button.imagePosition == SPItemImagePositionLeft)) {
            contentW = textW + imageW;
        } else if (button.currentTitle && button.currentImage && (button.imagePosition == SPItemImagePositionTop || button.imagePosition == SPItemImagePositionBottom)) {
            contentW = MAX(textW, imageW);
        }
        if (setupButtonW) {
            contentW_sum += setupButtonW;
            [buttonWidths addObject:@(setupButtonW)];
        } else {
            contentW_sum += contentW;
            [buttonWidths addObject:@(contentW)];
        }
    }
    CGFloat diff = itemScrollViewW - contentW_sum;
    
    [self.buttons enumerateObjectsUsingBlock:^(SPItem *button, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat setupButtonW = [[self.setupWidths objectForKey:[NSString stringWithFormat:@"%zd",idx]] floatValue];
        if (self.permutationWay == SPPageMenuPermutationWayScrollAdaptContent) {
            buttonW = [buttonWidths[idx] floatValue];
            if (idx == 0) {
                button.frame = CGRectMake(self->_itemPadding*0.5+lastButtonMaxX, 0, buttonW, itemScrollViewH);
            } else {
                button.frame = CGRectMake(self->_itemPadding+lastButtonMaxX, 0, buttonW, itemScrollViewH);

            }
        } else if (self.permutationWay == SPPageMenuPermutationWayNotScrollEqualWidths) {
            // 求出外界设置的按钮宽度之和
            CGFloat totalSetupButtonW = [[self.setupWidths.allValues valueForKeyPath:@"@sum.floatValue"] floatValue];
            // 如果该按钮外界设置了宽，则取外界设置的，如果外界没设置，则其余按钮等宽
            buttonW = setupButtonW ? setupButtonW : (itemScrollViewW-self->_itemPadding*(self.buttons.count)-totalSetupButtonW)/(self.buttons.count-self.setupWidths.count);
            if (buttonW < 0) { // 按钮过多时,有可能会为负数
                buttonW = 0;
            }
            if (idx == 0) {
                button.frame = CGRectMake(self->_itemPadding*0.5+lastButtonMaxX, 0, buttonW, itemScrollViewH);
            } else {
                button.frame = CGRectMake(self->_itemPadding+lastButtonMaxX, 0, buttonW, itemScrollViewH);
            }
            
        } else {
            self->_itemPadding = diff/self.buttons.count;
            buttonW = [buttonWidths[idx] floatValue];
            if (idx == 0) {
                button.frame = CGRectMake(self->_itemPadding*0.5+lastButtonMaxX, 0, buttonW, itemScrollViewH);
            } else {
                button.frame = CGRectMake(self->_itemPadding+lastButtonMaxX, 0, buttonW, itemScrollViewH);
            }
        }
        lastButtonMaxX = CGRectGetMaxX(button.frame);
    }];
    self.itemScrollView.contentSize = CGSizeMake(lastButtonMaxX+_itemPadding*0.5, 0);
    
    if (self.translatesAutoresizingMaskIntoConstraints == NO) {
    }
}

@end
#pragma mark - Backup Store








