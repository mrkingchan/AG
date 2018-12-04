//
//  NNMallViewController.m
//  YWL
//
//  Created by 牛牛 on 2018/7/16.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNMallViewController.h"
#import "NSString+Hash.h"
#import "YTKNetworkConfig.h"
#import <WebKit/WebKit.h>

@interface NNMallViewController () <WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *webview;

@end

@implementation NNMallViewController

#pragma mark -
#pragma mark ---------Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
    
    // 初始化webview
    [self setupChildView];
    
    // 展示网页
    [self setupRequest];
}

- (void)setupRequest
{
    NNUserModel *userModel = [NNHProjectControlCenter sharedControlCenter].userControl_currentUserModel;
    NSString *mallUrl = userModel.mallurl;
    if (mallUrl.length == 0) {
        mallUrl = @"https://www.zthycbec.com/";
    }
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:mallUrl]];
    [self.webview loadRequest:request];
}

- (void)setupChildView
{
    [self.view addSubview:self.webview];
    [self.webview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark -
#pragma mark ---------WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    [SVProgressHUD nn_show];
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    [SVProgressHUD nn_dismiss];
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
{
    [SVProgressHUD nn_dismiss];
}

#pragma mark -
#pragma mark ---------Getters & Setters
- (WKWebView *)webview
{
    if (_webview == nil) {
        _webview = [[WKWebView alloc] init];
        _webview.navigationDelegate = self;
    }
    return _webview;
}

@end
