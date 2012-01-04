//
//  GalleryContainer.m
//  
//
//  Created by Mark Essien on 04.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GalleryContainer.h"
#import "ItemPage.h"

@implementation GalleryContainer

@synthesize itemPages;
@synthesize scrollView;

#define NUM_PAGES 5

- (void)loadView {
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
	self.view.backgroundColor = [UIColor blueColor];
}


- (void)viewDidLoad {
    [super viewDidLoad];
	
    // Initialise the scrollview with some 'normal' parameters
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    [self.scrollView  setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;
    scrollView.delegate = self;
	scrollView.bounces = YES;
	
    [self.view addSubview:scrollView];
    
    // pre-initialise with 5 pages
	scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * NUM_PAGES, scrollView.frame.size.height - 100);
    
    // create the webviews. To avoid a slow-down while launching, we do this with a timer
	[NSTimer scheduledTimerWithTimeInterval:0.01 target:self 
             selector:@selector(createWebViews) userInfo:nil repeats:NO];
}

- (void)createWebViews  {

    if (self.itemPages == nil)
        self.itemPages = [[NSMutableArray alloc] init];
	else
        return; // function called twice
	
    // Create the individual pages that will make up the gallery
    for (unsigned i = 0; i < 5; i++) {
		ItemPage* page = [[ItemPage alloc] init];
        [itemPages addObject:page];
		
		if (nil == page.view.superview) {
			CGRect frame = scrollView.frame;
			frame.origin.x = frame.size.width * i;
			frame.origin.y = 0;
			page.view.frame = frame;
			[scrollView addSubview:page.view];
		}
    }

	
	scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * NUM_PAGES, scrollView.frame.size.height - 100);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
}

@end
