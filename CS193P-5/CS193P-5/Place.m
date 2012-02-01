//
//  Place.m
//  CS193P-5
//
//  Created by Ed Sibbald on 11/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Place.h"

@implementation Place

@synthesize name = _name;
@synthesize description = _description;
@synthesize id = _id;

- (id)initWithDictionary:(NSDictionary *)dict
{
	self = [super init];
	if (!self)
		return self;
	
	id possContent = [dict objectForKey:@"_content"];
	NSString *content = [possContent isKindOfClass:[NSString class]] ? (NSString *)possContent : nil;
	if ([content length] == 0) {
		// parse into name, description
		NSLog(@"Non-empty string expected at key \"_content\"");
		[self release];
		return nil;
	}

	id possId = [dict objectForKey:@"place_id"];
	NSString *placeId = [possId isKindOfClass:[NSString class]] ? (NSString *)possId : nil;
	if ([placeId length] == 0) {
		NSLog(@"Non-empty string expected at key \"place_id\"");
		[self release];
		return nil;
	}

	NSRange range = [content rangeOfString:@","];
	if (range.location == NSNotFound) {
		self.name = [[content copy] autorelease];
	}
	else {
		self.name = [content substringToIndex:range.location];
		if ([content length] > range.location + 2)
			self.description = [content substringFromIndex:range.location + 2];
	}
	self.id = [[placeId copy] autorelease];

	return self;
}

- (void)dealloc
{
	self.name = nil;
	self.description = nil;
	self.id = nil;
	[super dealloc];
}

@end
