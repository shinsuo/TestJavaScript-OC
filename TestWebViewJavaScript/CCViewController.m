//
//  CCViewController.m
//  TestWebViewJavaScript
//
//  Created by Shin Suo on 12-5-29.
//  Copyright (c) 2012年 CocoaChina. All rights reserved.
//

#import "CCViewController.h"

@implementation CCViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"html"];
    NSString *htmlString = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
    
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 400)];
    webView.delegate = self;
    [webView loadHTMLString:htmlString baseURL:nil];
    
    button = [[UIButton alloc] initWithFrame:CGRectMake(0, 400, 320, 80)];
    [button setTitle:@"sendToJS" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)buttonPressed:(id)sender
{
    NSLog(@"buttonPressed");
}

#pragma mark webViewDelegate Method
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    int v=0,x=0,y=0,w=0,h=0,mode=0;
    int exit=0;
    NSString *newURL = nil;
    
    NSString *absoluteString = [request.URL absoluteString];
    NSString *relativeString = [request.URL relativeString];

    NSArray *urlArray = [absoluteString componentsSeparatedByString:@"//"];
    if ([absoluteString hasPrefix:@"punchbox://"]) {
        NSString *urlRelativeString =[absoluteString substringFromIndex:[[NSString stringWithFormat:@"punchbox://"] length]];
        if ([urlRelativeString hasPrefix:@"jsctrl/"]) {
            NSString *keyValues = [urlRelativeString substringFromIndex:[[NSString stringWithFormat:@"jsctrl/"] length]];
            NSArray *keyValueArray = [keyValues componentsSeparatedByString:@"&"];
            for (NSString *keyValue in keyValueArray) {
                NSArray *key = [keyValue componentsSeparatedByString:@"="];
                if ([[key objectAtIndex:0] isEqualToString:@"v"]) {
                    NSString *valueString = [key objectAtIndex:1];
                    v = valueString.intValue;
                }else if ([[key objectAtIndex:0] isEqualToString:@"mode"]) {
                    NSString *valueString = [key objectAtIndex:1];
                    mode = valueString.intValue;
                }else if ([[key objectAtIndex:0] isEqualToString:@"x"]) {
                    NSString *valueString = [key objectAtIndex:1];
                    x = valueString.intValue;
                }else if ([[key objectAtIndex:0] isEqualToString:@"y"]) {
                    NSString *valueString = [key objectAtIndex:1];
                    y = valueString.intValue;
                }else if ([[key objectAtIndex:0] isEqualToString:@"w"]) {
                    NSString *valueString = [key objectAtIndex:1];
                    w = valueString.intValue;
                }else if ([[key objectAtIndex:0] isEqualToString:@"h"]) {
                    NSString *valueString = [key objectAtIndex:1];
                    h = valueString.intValue;
                }else if ([[key objectAtIndex:0] isEqualToString:@"exit"]) {
                    NSString *valueString = [key objectAtIndex:1];
                    exit = valueString.intValue;
                }else if ([[key objectAtIndex:0] isEqualToString:@"url"]) {
                    NSString *valueString = [key objectAtIndex:1];
                    newURL = [NSString stringWithFormat:@"%@",valueString];
                }else{
                    return NO;
                }                
            }
            
            UIWebView *newWebView = [[UIWebView alloc] initWithFrame:CGRectMake(x, y, w, h)];
            newWebView.delegate = self;
            [newWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:newURL]]];
        }
        return NO;
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidStartLoad");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidFinishLoad");
    [self.view addSubview:webView];
    [webView release];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"didFailLoadWithError:%@",error);
}

@end
