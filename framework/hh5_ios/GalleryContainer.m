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
@synthesize pageNames;

#define NUM_PAGES 5

- (void)loadView {
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
	self.view.backgroundColor = [UIColor blueColor];
}


- (void)viewDidLoad {
    [super viewDidLoad];
	
    self.pageNames = [[NSMutableArray alloc] init];
    
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
	scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * NUM_PAGES, scrollView.frame.size.height);
    
    // create the webviews. To avoid a slow-down while launching, we do this with a timer
	[NSTimer scheduledTimerWithTimeInterval:0.01 target:self 
             selector:@selector(createWebViews) userInfo:nil repeats:NO];
}


- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    NSLog(@"I have finished rotating");
   // self.viewframe = self
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * NUM_PAGES, scrollView.frame.size.height);
}

- (void)createWebViews  {

    if (self.itemPages == nil) {
        self.itemPages = [[NSMutableArray alloc] init];
        
    }
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
            [page.view setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
            [self loadPageAtIndex:i];
		}
    }

	scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * NUM_PAGES, scrollView.frame.size.height);
}

- (void)scrollViewDidScroll:(UIScrollView *)sv {
    
	CGFloat pageWidth = scrollView.frame.size.width;
	curPage = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
	
	if (curPage != lastPage)
	{
		lastPage = curPage;
		[NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(loadNextPages) userInfo:nil repeats:NO];
	}
}

- (void)loadNextPages 
{
	[self loadPageAtIndex: curPage];
	[self loadPageAtIndex: curPage+1];
	[self loadPageAtIndex: curPage-1];
}

- (void)loadPageAtIndex:(int) i {
    
	if (i < 0) return;
    if (i >= [self.pageNames count]) return;
	
	int selPage = i % NUM_PAGES;
	
    // replace the placeholder if necessary
    ItemPage *page = [itemPages objectAtIndex:selPage];
	if (page == nil)
	{		
        NSLog(@"BUG!!!");
	}
	
	[page loadPage:[pageNames objectAtIndex:i]];
	// [page resizeObjects];
	
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * i;
    frame.origin.y = 0;
    page.view.frame = frame;
	
	scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * [pageNames count], scrollView.frame.size.height - 100);
    
	// NSLog(@"Exit loadRecipe");
}

- (void) addPage:(NSString*)pageName {
    [pageNames addObject:pageName];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
}

@end
