//
//  ViewController.m
//  ChatTest
//
//  Created by lixiaoyi on 2018/8/3.
//  Copyright © 2018年 lixiaoyi. All rights reserved.
//

#import "ViewController.h"
#import "ChatMainVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"chat";
    
    [self createRightBarButton];
}

- (void)createRightBarButton {
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"push" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 60, 40);
    [button addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)rightBtnClick:(UIButton *)sender{
    ChatMainVC *main = [[ChatMainVC alloc] init];
    [self.navigationController pushViewController:main animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
