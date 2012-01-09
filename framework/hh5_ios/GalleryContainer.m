//
//  GalleryContainer.m
//  
//
//  Created by Mark Essien on 04.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GalleryContainer.h"
#import "ItemPage.h"
#import "TableOfContents.h"

@implementation GalleryContainer

@synthesize itemPages;
@synthesize scrollView;
@synthesize pageNames;
@synthesize toolBar;
@synthesize popoverController;
@synthesize tocButton;

#define NUM_PAGES 5


- (void)loadView {
    self.view = [[UIView alloc] initWithFrame:CGRectZero];
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

- (void) loadToolbar {
    
    
    CGRect rcToolbar;
    rcToolbar.origin.x = 0;
    rcToolbar.origin.y = 0;
    rcToolbar.size.width = self.view.frame.size.width;
    rcToolbar.size.height = 50;
    toolBar = [[UIToolbar alloc] initWithFrame:rcToolbar];
    toolBar.translucent = YES;
    toolBar.tintColor = [UIColor blackColor];
    [self.view addSubview:toolBar];
    
    NSMutableArray* items = [[NSMutableArray alloc] init];
    
    // UIBarButtonItem* favButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedStringFromTable(@"Favorite", @"fmlib", @"fmlib stuff") style:UIBarButtonItemStylePlain target:nil action:nil];
    
    // [UIImage imageNamed:@"heart_empty.png"] 
    self.tocButton = [[UIBarButtonItem alloc] initWithTitle:@"Recipes" style:UIBarButtonItemStyleBordered target:self action:@selector(buttonClicked:)];
    [items addObject:self.tocButton];
    
    
    UIBarButtonItem* spaceButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [items addObject:spaceButton];
    
    
    UIBarButtonItem* shareButton = [[UIBarButtonItem alloc] initWithTitle:@"Share..." style:UIBarButtonItemStyleBordered target:nil action:@selector(onShowShareWindowClicked)];
    [items addObject:shareButton];
    
    //spaceButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease];;
    //[items addObject:spaceButton];
    
    [toolBar setItems:items];
    
    // [self startFadeTimer];
    
}

-(void)buttonClicked:(id)sender {
    
    if (self.popoverController == nil) {
        TableOfContents *toc = [[TableOfContents alloc] initWithNibName:@"TableOfContents" bundle:[NSBundle mainBundle]]; 
        toc.listOfFiles = self.pageNames;
        
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:toc]; 
        
        popover.delegate = self;
        
        self.popoverController = popover;
    }
    
    CGRect rc = CGRectMake(0, 0, 100, 100);
   
    //UIView* btn = [[event.allTouches anyObject] view];
    //CGRect popoverRect = [self.view convertRect:[btn frame] 
    //                                   fromView:[btn superview]];
    
    // popoverRect.size.width = 100; 
    [self.popoverController 
     presentPopoverFromRect:rc 
     inView:self.view 
     permittedArrowDirections:UIPopoverArrowDirectionAny 
     animated:YES];
}


- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
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
            // [page.view setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
            [self loadPageAtIndex:i];
		}
    }

	scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * NUM_PAGES, scrollView.frame.size.height);
    
    [self loadToolbar];
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
	
	scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * [pageNames count], scrollView.frame.size.height );
    
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
