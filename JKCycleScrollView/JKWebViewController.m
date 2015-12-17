//
//  JKWebViewController.m
//  JKCycleScrollView
//
//  Created by Kzj_ZhongJunKang on 15/12/15.
//  Copyright © 2015年 Kzj_ZhongJunKang. All rights reserved.
//

#import "JKWebViewController.h"
#import <SVProgressHUD.h>

@interface JKWebViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation JKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillDisappear:(BOOL)animated{
    [SVProgressHUD dismiss];
}
- (UIWebView *) webView {
    if (!_webView) {
        _webView = [UIWebView new];
        _webView.frame = self.view.frame;
        _webView.delegate = self;
        
        [_webView loadRequest:[NSURLRequest requestWithURL:self.webUrl]];
    }
    return _webView;
}
#pragma mark UIWebView Delegate
- (void)webViewDidStartLoad:(UIWebView *)webView {

    [SVProgressHUD showWithStatus:@"加载中。。。"];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {

    [SVProgressHUD dismiss];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error {
    NSLog(@"%@",error);
    [SVProgressHUD showErrorWithStatus:@"网络出错了!"];

}


@end
