//
//  CustomViewController.m
//  WGADSDKDemo
//
//  Created by Mr.Song on 2020/2/18.
//  Copyright © 2020 Mr.Song. All rights reserved.
//

#import "CustomViewController.h"

@interface CustomViewController ()

@end

@implementation CustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self setupBackBarButtonItem];
    // Do any additional setup after loading the view.
}

- (void)setupBackBarButtonItem
{

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [button sizeToFit];
    button.frame = CGRectMake(10, 40, 40, 20);
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)buttonAction
{
     [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
