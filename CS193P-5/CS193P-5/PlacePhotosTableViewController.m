//
//  PlacePhotosTableViewController.m
//  CS193P-5
//
//  Created by Ed Sibbald on 12/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PlacePhotosTableViewController.h"

#import "Photo.h"


@implementation PlacePhotosTableViewController

+ (void)addRecentPhoto:(Photo *)photo
{
	NSMutableArray *updatedRecentPhotos = [NSMutableArray array];
	[updatedRecentPhotos addObject:[Photo propertyListFromPhoto:photo]];
	
	NSArray *origRecentPhotos = [PhotosTableViewController recentPhotosFromUserDefaults];
	for (Photo *origRecentPhoto in origRecentPhotos) {
		if ([origRecentPhoto.url compare:photo.url] == 0)
			continue;
		[updatedRecentPhotos addObject:[Photo propertyListFromPhoto:origRecentPhoto]];
		if ([updatedRecentPhotos count] >= 20)
			break;
	}

	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setObject:updatedRecentPhotos forKey:@"RecentPhotos"];
	[defaults synchronize];
}

- (void)didSelectPhoto:(Photo *)photo
{
	[PlacePhotosTableViewController addRecentPhoto:photo];
	[super didSelectPhoto:photo];
}

@end
