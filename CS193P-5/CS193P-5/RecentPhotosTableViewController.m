//
//  RecentPhotosTableViewController.m
//  CS193P-5
//
//  Created by Ed Sibbald on 12/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "RecentPhotosTableViewController.h"

@implementation RecentPhotosTableViewController

- (id)init
{
	return [self initWithPhotosArray:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
	// update data before super class gets a chance to do anything 
	[_photos release]; // unlikely to be anything here, but still...
	_photos = [[PhotosTableViewController recentPhotosFromUserDefaults] copy];
	[self.tableView reloadData];

	[super viewWillAppear:animated];
}

@end
