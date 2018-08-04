//
//  ChatMainVC.m
//  ChatTest
//
//  Created by lixiaoyi on 2018/8/3.
//  Copyright © 2018年 lixiaoyi. All rights reserved.
//

#import "ChatMainVC.h"
#import "TapScrollView.h"

#define kWidth          self.view.bounds.size.width
#define kHeight         self.view.bounds.size.height

@interface ChatMainVC ()
@property (nonatomic, strong) TapScrollView *tapScrollView;

@property (nonatomic, strong) UINavigationBar *navBar;

@property (nonatomic, strong) UIScrollView *mainScrollView;

@property (nonatomic, strong) UIView *view1;

@property (nonatomic, strong) UIView *view2;

@end

@implementation ChatMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 创建导航Bar
    self.navBar = [[UINavigationBar alloc] initWithFrame: CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,44)];
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) {
        self.navBar.frame = CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width,44);
    }
    [self.navBar setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.navBar];
    
    [self.navBar addSubview:self.tapScrollView];
    
    [self createLeftButtonItemWithImageName:@"back"];
    
    [self.view addSubview:self.mainScrollView];
    [self.mainScrollView addSubview:self.view1];
    [self.mainScrollView addSubview:self.view2];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (TapScrollView *)tapScrollView {
    if (!_tapScrollView) {
        _tapScrollView = [[TapScrollView alloc] initWithFrame:CGRectMake(100, 0, self.view.bounds.size.width - 200, 44) buttonsArr:@[@"消息",@"好友"]];
        
        __weak typeof(self) weakSelf = self;
        self.tapScrollView.tapScrollViewBlock = ^(NSUInteger index) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if (1000 == index) {
                [UIView animateWithDuration:0.1 animations:^{
                    [strongSelf.mainScrollView scrollRectToVisible:CGRectMake(0, 0, strongSelf.view.frame.size.width, strongSelf.view.frame.size.height) animated:YES];
                }];
            } else if (1001 == index) {
                [UIView animateWithDuration:0.1 animations:^{
                    [strongSelf.mainScrollView scrollRectToVisible:CGRectMake(strongSelf.view.frame.size.width, 0, strongSelf.view.frame.size.width, strongSelf.view.frame.size.height) animated:YES];
                }];
            }
        };
    }
    
    return _tapScrollView;
}

- (UIScrollView *)mainScrollView {
    if (!_mainScrollView) {
        CGFloat width = self.view.bounds.size.width;
        CGFloat height = self.view.bounds.size.height;
        CGRect frame = CGRectMake(0, 64, width, height);
        _mainScrollView = [[UIScrollView alloc] initWithFrame:frame];
        _mainScrollView.scrollEnabled = YES;
        _mainScrollView.pagingEnabled = YES;
        _mainScrollView.contentSize = CGSizeMake(width * 2, height);
        _mainScrollView.delegate = self;
    }
    
    return _mainScrollView;
}

- (UIView *)view1 {
    if (!_view1) {
        _view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
        _view1.backgroundColor = [UIColor lightGrayColor];
    }
    
    return _view1;
}

- (UIView *)view2 {
    if (!_view2) {
        _view2 = [[UIView alloc] initWithFrame:CGRectMake(kWidth, 0, kWidth, kHeight)];
        _view2.backgroundColor = [UIColor cyanColor];
    }
    
    return _view2;
}

#pragma mark -
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int index =  scrollView.contentOffset.x / scrollView.frame.size.width;
    
    NSLog(@"index--->%d", index);
    if (0 == index) {
        
        [UIView animateWithDuration:0.2 animations:^{
            self.tapScrollView.indicatorView.frame = CGRectMake(0, 0, self.tapScrollView.indicatorScrollView.frame.size.width/2, 5);
        }];
    } else if (1 == index) {
        
        [UIView animateWithDuration:0.2 animations:^{
            self.tapScrollView.indicatorView.frame = CGRectMake(self.tapScrollView.indicatorScrollView.bounds.size.width / 2, 0, self.tapScrollView.indicatorScrollView.frame.size.width/2, 5);
        }];
    }
}

- (void)createLeftButtonItemWithImageName:(NSString *)imageName{
    UIButton *leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(10, -2, 60, 44);
    if (!imageName || [imageName isEqualToString:@""]) {
        imageName = @"go_back.png";
    }
    [leftButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [leftButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateHighlighted];
    [leftButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [leftButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [leftButton addTarget:self action:@selector(onBack:) forControlEvents:UIControlEventTouchUpInside];
    [self.navBar addSubview:leftButton];
}

- (void)onBack:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
