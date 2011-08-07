//
//  PLServerMetersRequest.m
//  Parkalator
//
//  Created by Sam Stewart on 8/6/11.
//  Copyright 2011 SamStewartApps.com. All rights reserved.
//

#import "PLServerMetersRequest.h"

@implementation PLServerMetersRequest
@synthesize coordinate;
- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (NSString*)requestURL {
    return [NSString stringWithFormat:@"%@%@", PL_URL(@"/api/parking_meters"), self.requestQuery];
}
- (NSMutableDictionary*)parameters {
#warning Hard coding our location...
    return [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:37.778734661], @"lat", 
                                                        [NSNumber numberWithFloat:-122.4318517401], @"lng", 
                                                        [NSNumber numberWithFloat:.001], @"radius", nil];
}
@end
