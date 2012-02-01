//
//  PhotosTableViewController.h
//  CS193P-5
//
//  Created by Ed Sibbald on 11/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Photo;


@interface PhotosTableViewController : UITableViewController
{
	NSArray *_photos;
	UILabel *_footerLabel;
}

- (id)initWithPhotosArray:(NSArray *)photos;

- (void)didSelectPhoto:(Photo *)photo;

+ (NSArray *)recentPhotosFromUserDefaults;

@end
