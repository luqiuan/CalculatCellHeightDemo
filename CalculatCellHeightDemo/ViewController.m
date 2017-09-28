//
//  ViewController.m
//  CalculatCellHeightDemo
//
//  Created by luqiuan on 2017/9/28.
//  Copyright © 2017年 luqiuan. All rights reserved.
//

#import "ViewController.h"
#import "Defines.h"
#import "SaveHeightWithModelController.h"
#import "SaveHeightWithStaticValueController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *title = @[@"使用model保存动态高度",@"使用静态变量保存高度"];
    for (int i = 0; i < 2; i ++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 200)/2, 100 + 50 * i, 200, 40)];
        [button setTitle:title[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        button.tag = i;
        [button addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:button];
    }
    
}

- (void)action:(UIButton *)sender{
    UIViewController *VC;
    if (sender.tag == 0) {
        VC = [[SaveHeightWithModelController alloc] init];
    }
    else{
        VC = [[SaveHeightWithStaticValueController alloc] init];
    }
    [self presentViewController:VC animated:YES completion:^{
        
    }];
}


@end
