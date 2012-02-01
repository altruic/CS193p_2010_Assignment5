//
//  Photo.h
//  CS193P-5
//
//  Created by Ed Sibbald on 12/5/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Photo : NSObject
{
	NSString *_title;
	NSString *_description;
	NSString *_url;
}

@property (retain) NSString *title;
@property (retain) NSString *description;
@property (retain) NSString *url;

// NOT a new designated initializer, just for convenience
- (id)initWithDictionary:(NSDictionary *)dict;

+ (id)propertyListFromPhoto:(Photo *)photo;
+ (Photo *)photoFromPropertyList:(id)plist;

@end
