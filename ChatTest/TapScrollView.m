//
//  TapScrollView.m
//  ChatTest
//
//  Created by lixiaoyi on 2018/8/3.
//  Copyright © 2018年 lixiaoyi. All rights reserved.
//

#import "TapScrollView.h"

@implementation TapScrollView

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame
                      buttonsArr:(NSMutableArray *)buttonNames{
    if (self = [super initWithFrame:frame]) {
        
        NSUInteger count = [buttonNames count];
        CGFloat allWidth = frame.size.width;
        CGFloat itemWidth = allWidth / count;
        
        if (count > 0) {
            for (int idx = 0; idx < count; idx ++) {
                UIButton *tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                [tempBtn setTitle:buttonNames[idx] forState:UIControlStateNormal];
                [tempBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [tempBtn setFrame:CGRectMake(idx * itemWidth, 0, itemWidth, 40)];
                [tempBtn addTarget:self action:@selector(tempBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                tempBtn.tag = 1000 + idx;
                [self addSubview:tempBtn];
            }
        }
        
        // 添加indicatorScrollView
        self.indicatorScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, frame.size.width, 5)];
        self.indicatorScrollView.backgroundColor = [UIColor clearColor];
        self.indicatorScrollView.contentSize = CGSizeMake(allWidth * 2, 5);
        self.indicatorScrollView.scrollEnabled = YES;
        self.indicatorScrollView.pagingEnabled = YES;
        self.indicatorScrollView.delegate = self;
        self.indicatorScrollView.bounces  = NO;
        self.indicatorScrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:self.indicatorScrollView];
        
        // 添加indicatorview
        self.indicatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, itemWidth, 5)];
        UIColor *color = [UIColor colorWithRed:59.0/255.0 green:189.0/255.0 blue:100.0/255.0 alpha:1.0];
        self.indicatorView.backgroundColor = color;
        [self.indicatorScrollView addSubview:self.indicatorView];
        
    }
    
    return self;
}

#pragma mark - lazy load
- (NSMutableArray *)buttonNames {
    if (!_buttonNames) {
        _buttonNames = [NSMutableArray array];
    }
    
    return _buttonNames;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int index =  scrollView.contentOffset.x / scrollView.frame.size.width;
    if (0 == index) {
        self.indicatorView.frame = CGRectMake(scrollView.frame.size.width / 2, 0, scrollView.frame.size.width/2, 5);
    } else if (1 == index) {
        self.indicatorView.frame = CGRectMake(scrollView.bounds.size.width, 0, scrollView.frame.size.width/2, 5);
    }
    
}

- (void)tempBtnClick:(UIButton *)sender {
    long index = sender.tag;
    if (1000 == index) {
        [UIView animateWithDuration:0.2 animations:^{
            [self.indicatorScrollView scrollRectToVisible:CGRectMake(0, 0, self.indicatorScrollView.frame.size.width/2, 5) animated:YES];
            [sender.titleLabel setFont:[UIFont systemFontOfSize:20]];
            
            UIButton *tag1 = [self viewWithTag:1001];
            [tag1.titleLabel setFont:[UIFont systemFontOfSize:17]];
            [tag1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            UIColor *color = [UIColor colorWithRed:59.0/255.0 green:189.0/255.0 blue:100.0/255.0 alpha:1.0];
            [sender setTitleColor:color forState:UIControlStateNormal];
        }];
        
    } else if (1001 == index) {
        [UIView animateWithDuration:0.2 animations:^{
            [self.indicatorScrollView scrollRectToVisible:CGRectMake(self.indicatorScrollView.bounds.size.width / 2, 0, self.indicatorScrollView.frame.size.width/2, 5) animated:YES];
            [sender.titleLabel setFont:[UIFont systemFontOfSize:20]];
            UIColor *color = [UIColor colorWithRed:59.0/255.0 green:189.0/255.0 blue:100.0/255.0 alpha:1.0];
            [sender setTitleColor:color forState:UIControlStateNormal];
            
            UIButton *tag0 = [self viewWithTag:1000];
            [tag0.titleLabel setFont:[UIFont systemFontOfSize:17]];
            [tag0 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }];
        
    }
    
    self.tapScrollViewBlock(index);
}

@end
