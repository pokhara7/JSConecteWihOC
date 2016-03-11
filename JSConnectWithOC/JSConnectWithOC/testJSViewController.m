//
//  testJSViewController.m
//  SHReader
//
//  Created by pokhara on 16/2/23.
//  Copyright © 2016年 shuhai. All rights reserved.
//

#import "testJSViewController.h"

@interface testJSViewController ()<UIWebViewDelegate>
{
 UIWebView *web;
}
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) JSContext *jsContext;
@end

@implementation testJSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    web.delegate = self;
    [self addLocalWeb];
    [self.view addSubview:web];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(haha:) name:@"textchange" object:nil];
}
-(void)haha:(NSNotification *)sender
{
    
//    readV.webUrl = sender.object;
    NSLog(@"%@",[sender.object valueForKey:@"bookid"]);
    
    NSString *strSender = [NSString stringWithFormat:@"参数是%@和%@",[sender.object valueForKey:@"bookid"],[sender.object valueForKey:@"maxorder"]];
    UIAlertController *a = [UIAlertController alertControllerWithTitle:strSender message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                                 {
                                    
                                     
                                     
                                 }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"返回上一页" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [a addAction:sureAction];
    [a addAction:cancelAction];
    [self presentViewController:a animated:YES completion:nil];
    
}

-(void)addLocalWeb
{
    //1.寻找资源路径
    NSString *str = [[NSBundle mainBundle]resourcePath];
    //2.拼接地址
    NSString *filePath = [str stringByAppendingPathComponent:@"noarticlesss.html"];
    //3.转化为所以需要的htmlstring字符串
    NSString *htmlstr = [[NSString alloc]initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    //4.加载网页
    [web loadHTMLString:htmlstr baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle]bundlePath]]];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
  
    self.jsContext = [web valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    // 通过模型调用方法，这种方式更好些。
    HYBJsObjCModel2 *model  = [[HYBJsObjCModel2 alloc] init];
    self.jsContext[@"OCModel"] = model;
    model.jsContext = self.jsContext;
    model.webView = web;
    
    self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue)
    {
        context.exception = exceptionValue;
        NSLog(@"异常信息：%@", exceptionValue);
    };
    
    
 }


@end


@implementation HYBJsObjCModel2
/**************************************书籍详情页面的按钮点击事件，发送通知**************************************/


-(void)read:(NSDictionary *)param
{
    NSLog(@"%@",[param valueForKey:@"maxorder"]);
    NSLog(@"%@",[param valueForKey:@"bookid"]);
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"textchange" object:param];
    });
}
@end
