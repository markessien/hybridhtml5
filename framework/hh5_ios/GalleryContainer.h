//
//  GalleryContainer.h
//
//
//  Created by Mark Essien on 04.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TableOfContents.h"

@interface GalleryContainer : UIViewController<UIScrollViewDelegate, UIPopoverControllerDelegate, TableOfContentsDelegate>
{
    UIPopoverController *popoverController;
    UIBarButtonItem* tocButton;
    UIToolbar* toolBar;
    UIScrollView *scrollView;
    NSMutableArray *itemPages;
    NSMutableArray *pageNames;
    int curPage;
    int lastPage;
}


@property (nonatomic, retain) UIBarButtonItem *tocButton;
@property (nonatomic, retain) UIPopoverController *popoverController;
@property (nonatomic, retain) UIToolbar *toolBar;
@property (nonatomic, retain) NSMutableArray *pageNames;
@property (nonatomic, retain) NSMutableArray *itemPages;
@property (nonatomic, retain) UIScrollView   *scrollView;

- (void) createWebViews;
- (void) addPage:(NSString*)pageName;
- (void) loadPageAtIndex:(int)i;
- (void) loadToolbar;
- (void) buttonClicked:(id)sender;
- (void) selectedIndex:(int)i;

@end
