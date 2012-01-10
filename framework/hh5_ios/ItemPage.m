//
//  ItemPage.m
//  VisualRecipes
//
//  Created by Mark Essien on 04.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ItemPage.h"

@implementation ItemPage

@synthesize webView;


- (id) init {
    return self;
}

- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
	self.view.backgroundColor = [UIColor blackColor];
    self.view.autoresizesSubviews = YES;
    
    
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.webView  setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    // self.webView.delegate = self;
    [self.view addSubview:webView];
    
    // Disable webview scrolling
    UIView * v = [[webView subviews] lastObject];
    if([v isKindOfClass:[UIScrollView class] ]) {
        UIScrollView* sv = (UIScrollView*)v;
        [sv setScrollEnabled:NO];
        [sv setBounces:NO];
    }
}

- (void) loadPage:(NSString*)pageName {
    
    NSString* path    = [[NSBundle mainBundle] bundlePath];
	NSURL*    baseURL = [NSURL fileURLWithPath:path];	
	
	NSString *p = [pageName stringByReplacingOccurrencesOfString:@".html" withString:@""]; 
	NSString *filePath = [[NSBundle mainBundle] pathForResource:p ofType:@"html"];
	NSString *htmlData = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
	
    [self.webView loadHTMLString:htmlData baseURL:baseURL];
}
@end
