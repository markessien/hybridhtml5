//
//  GalleryContainer.h
//
//
//  Created by Mark Essien on 04.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GalleryContainer : UIViewController<UIScrollViewDelegate>
{
    UIScrollView *scrollView;
    NSMutableArray *itemPages;
    NSMutableArray *pageNames;
    int curPage;
    int lastPage;
}

@property (nonatomic, retain) NSMutableArray *pageNames;
@property (nonatomic, retain) NSMutableArray *itemPages;
@property (nonatomic, retain) UIScrollView   *scrollView;

- (void) createWebViews;
- (void) addPage:(NSString*)pageName;
- (void) loadPageAtIndex:(int)i;

@end
