//
//  TableOfContents.m
//  VisualRecipes
//
//  Created by Mark Essien on 09.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TableOfContents.h"

@implementation TableOfContents

@synthesize listOfFiles;

- (id) initWithTable:(NSArray*)itemArray {
    
    if (!(self = [super init]))
		return nil;
    
    listOfFiles = itemArray;
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.clearsSelectionOnViewWillAppear = NO;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [listOfFiles count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    cell.textLabel.text = [[listOfFiles objectAtIndex:indexPath.row] objectForKey:@"Title"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    /*
    //---add this---
    PopOverExample1AppDelegate *appDelegate = 
    [[UIApplication sharedApplication] delegate];
    
    appDelegate.viewController.detailItem = 
    [listOfMovies objectAtIndex:indexPath.row];    
     */
    
}

@end
