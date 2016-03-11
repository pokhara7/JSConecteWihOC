//
//  testJSViewController.h
//  SHReader
//
//  Created by pokhara on 16/2/23.
//  Copyright © 2016年 shuhai. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
@protocol JavaScriptObjectiveCDelegate2 <JSExport>
-(void)read:(NSDictionary *)param;//跳转阅读页面方法
@end

// 此模型用于注入JS的模型，这样就可以通过模型来调用方法。
@interface HYBJsObjCModel2 : NSObject <JavaScriptObjectiveCDelegate2>

@property (nonatomic, weak) JSContext *jsContext;
@property (nonatomic, weak) UIWebView *webView;

@end
@interface testJSViewController : UIViewController

@end
