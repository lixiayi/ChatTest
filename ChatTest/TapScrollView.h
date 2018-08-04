//
//  TapScrollView.h
//  ChatTest
//
//  Created by lixiaoyi on 2018/8/3.
//  Copyright © 2018年 lixiaoyi. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^TapScrollViewBlock)(NSUInteger index);

@interface TapScrollView : UIView<UIScrollViewDelegate>


/**
 按钮的名字
 */
@property (nonatomic, strong) NSMutableArray *buttonNames;


/**
 指示器
 */
@property (nonatomic, strong) UIView *indicatorView;


/**
 指示器滑动view
 */
@property (nonatomic, strong) UIScrollView *indicatorScrollView;

/**
 TapScrollViewDelegate
 */
@property (nonatomic, strong) TapScrollViewBlock tapScrollViewBlock;



#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame
                   buttonsArr:(NSMutableArray *)buttonNames;


@end
