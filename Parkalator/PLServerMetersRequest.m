//
//  PLServerMetersRequest.m
//  Parkalator
//
//  Created by Sam Stewart on 8/6/11.
//  Copyright 2011 SamStewartApps.com. All rights reserved.
//

#import "PLServerMetersRequest.h"

@implementation PLServerMetersRequest

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
@end
