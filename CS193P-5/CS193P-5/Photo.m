//
//  Photo.m
//  CS193P-5
//
//  Created by Ed Sibbald on 12/5/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Photo.h"

#import "FlickrFetcher.h"

@implementation Photo

@synthesize title = _title;
@synthesize description = _description;
@synthesize url = _url;

- (id)initWithDictionary:(NSDictionary *)dict
{
	self = [self init];
	if (!self)
		return self;

	id possTitle = [dict objectForKey:@"title"];
	NSString *title = [possTitle isKindOfClass:[NSString class]] ? (NSString *)possTitle : nil;
	if (!title) {
		NSLog(@"Non-nil string expected at key \"title\"");
		[self release];
		return nil;
	}
	self.title = title;
	
	id possDescriptionDict = [dict objectForKey:@"description"];
	NSDictionary *descriptionDict = [possDescriptionDict isKindOfClass:[NSDictionary class]]
		? (NSDictionary *)possDescriptionDict : nil;
	if (!descriptionDict) {
		NSLog(@"Non-nil dictionary expected at key \"description\"");
		[self release];
		return nil;
	}
	id possDescription = [descriptionDict objectForKey:@"_content"];
	NSString *description = [possDescription isKindOfClass:[NSString class]] ? (NSString *)possDescription : nil;
	if (!description) {
		NSLog(@"Non-nil string expected at key \"description/\"_content\"\"");
		[self release];
		return nil;
	}
	self.description = description;
	
	self.url = [FlickrFetcher urlStringForPhotoWithFlickrInfo:dict format:FlickrFetcherPhotoFormatLarge];
	
	return self;
}

- (void)dealloc
{
	self.title = nil;
	self.description = nil;
	self.url = nil;
	[super dealloc];
}

+ (id)propertyListFromPhoto:(Photo *)photo
{
	NSMutableDictionary *dict = [NSMutableDictionary dictionary];
	[dict setObject:photo.title forKey:@"title"];
	[dict setObject:photo.description forKey:@"description"];
	[dict setObject:photo.url forKey:@"url"];
	return [NSDictionary dictionaryWithDictionary:dict];
}

+ (Photo *)photoFromPropertyList:(id)plist
{
	NSDictionary *dict = [plist isKindOfClass:[NSDictionary class]] ? (NSDictionary *)plist : nil;
	if (!dict) {
		NSLog(@"Incorrectly formatted property list");
		return nil;
	}
	
	id possTitle = [dict objectForKey:@"title"];
	NSString *title = [possTitle isKindOfClass:[NSString class]] ? (NSString *)possTitle : nil;
	id possDescription = [dict objectForKey:@"description"];
	NSString *description = [possDescription isKindOfClass:[NSString class]] ? (NSString *)possDescription : nil;
	id possUrl = [dict objectForKey:@"url"];
	NSString *url = [possUrl isKindOfClass:[NSString class]] ? (NSString *)possUrl : nil;

	if (!title || !description || !url || [url length] == 0) {
		NSLog(@"Incorrectly formatted property list");
		return nil;
	}

	Photo *photo = [[Photo alloc] init];
	photo.title = title;
	photo.description = description;
	photo.url = url;
	return [photo autorelease];
}

@end
