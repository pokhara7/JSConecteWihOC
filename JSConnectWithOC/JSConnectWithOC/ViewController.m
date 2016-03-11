//
//  ViewController.m
//  JSConnectWithOC
//
//  Created by pokhara on 16/3/11.
//  Copyright © 2016年 shuhai. All rights reserved.
//

#import "ViewController.h"
#import "testJSViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100,300, 150, 150)];
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(clik:) forControlEvents:
     UIControlEventTouchUpInside];
}

-(void)clik:(id)sender
{
    
    NSLog(@"fsdfas");
    testJSViewController *testvc = [[testJSViewController alloc]init];
    [self presentViewController:testvc animated:YES completion:nil];
}

@end
