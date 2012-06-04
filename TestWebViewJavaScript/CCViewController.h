//
//  CCViewController.h
//  TestWebViewJavaScript
//
//  Created by Shin Suo on 12-5-29.
//  Copyright (c) 2012年 CocoaChina. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCViewController : UIViewController <UIWebViewDelegate>
{
    UIWebView *webView;
    UIButton *button;
}

@end
