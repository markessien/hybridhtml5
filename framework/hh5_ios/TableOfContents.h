//
//  TableOfContents.h
//  VisualRecipes
//
//  Created by Mark Essien on 09.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TableOfContentsDelegate<NSObject>
@optional
    - (void) selectedIndex:(int)i;
@end

@interface TableOfContents : UITableViewController {

    NSArray *listOfFiles;
    id delegate;
}

- (id)initWithTable:(NSArray*)itemArray;

@property (nonatomic, retain) NSArray *listOfFiles;
@property (nonatomic, retain) id<TableOfContentsDelegate> delegate;

@end
