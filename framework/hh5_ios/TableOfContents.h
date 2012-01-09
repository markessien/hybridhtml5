//
//  TableOfContents.h
//  VisualRecipes
//
//  Created by Mark Essien on 09.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TableOfContents : UITableViewController {

    NSArray *listOfFiles;
}

- (id)initWithTable:(NSArray*)itemArray;

@property (nonatomic, retain) NSArray *listOfFiles;


@end
