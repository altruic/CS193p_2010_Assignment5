//
//  PhotoViewController.m
//  CS193P-5
//
//  Created by Ed Sibbald on 11/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PhotoViewController.h"

#import "FlickrFetcher.h"
#import "Photo.h"


@implementation PhotoViewController

@synthesize photo = _photo;

- (id)initWithPhoto:(Photo *)aPhoto
{
	self = [super init];
	if (self) {
		_photo = [aPhoto retain];
		self.title = !_photo ? @"No photo" : [_photo.title length] == 0 ? @"No title" : _photo.title;
	}
	return self;
}

- (void)dealloc
{
	[_scrollView release];
	[_imageView release];
	[_photo release];
	[super dealloc];
}

#pragma mark - View lifecycle

- (NSData *)imageData
{
	if (!self.photo) {
		NSLog(@"Non-nil photo expected");
		return nil;
	}

	NSData *data = nil;
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	data = [FlickrFetcher imageDataForPhotoWithURLString:self.photo.url];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

	if (!data) {
		NSLog(@"Non-nil image data expected");
		return nil;
	}
	
	return data;
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
	NSData *data = [self imageData];
	if (!data) {
		NSLog(@"Could not load image data");
		// Create plain label with text "Could not load image"
		return;
	}

	UIImage *image = [[UIImage alloc] initWithData:data];
	_imageView = [[UIImageView alloc] initWithImage:image];
	[image release];

	_scrollView = [[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
	_scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	_scrollView.delegate = self;
	_scrollView.minimumZoomScale = 0.1;
	_scrollView.maximumZoomScale = 2.0;
	[_scrollView addSubview:_imageView];
	_scrollView.contentSize = _imageView.bounds.size;
	
	self.view = _scrollView;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{ return _imageView; }

- (void)updateZoomScalesAndResetZoom:(BOOL)reset
{
	CGSize scrollViewSize = _scrollView.bounds.size;
	double scrollAspect = scrollViewSize.width / scrollViewSize.height;
	CGSize imageViewSize = _imageView.bounds.size;
	double imageAspect = imageViewSize.width / imageViewSize.height;

	_scrollView.minimumZoomScale = imageAspect > scrollAspect
		? scrollViewSize.width / imageViewSize.width
		: scrollViewSize.height / imageViewSize.height;
	_scrollView.maximumZoomScale = 2.0;
	
	if (reset) {
		_scrollView.zoomScale = imageAspect > scrollAspect
			? scrollViewSize.height / imageViewSize.height
			: scrollViewSize.width / imageViewSize.width;
	}
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[self updateZoomScalesAndResetZoom:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{ return YES; }

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
	[super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
	[self updateZoomScalesAndResetZoom:NO];
}

@end
