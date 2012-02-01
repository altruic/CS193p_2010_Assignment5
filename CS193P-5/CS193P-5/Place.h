//
//  Place.h
//  CS193P-5
//
//  Created by Ed Sibbald on 11/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Place : NSObject
{
	NSString *_name;
	NSString *_description;
	NSString *_id;
}

@property (retain) NSString *name;
@property (retain) NSString *description;
@property (retain) NSString *id;

- (id)initWithDictionary:(NSDictionary *)dict;

@end
