//
//  PLMeter.m
//  Parkalator
//
//  Created by Sam Stewart on 8/6/11.
//  Copyright 2011 SamStewartApps.com. All rights reserved.
//

#import "PLMeterBlock.h"

@implementation PLMeterBlockAnnotation
@synthesize coordinate=_coordinate;

- (id)initWithCoordinate:(CLLocationCoordinate2D)coor {
    self = [super init];
    if (self) {
        _coordinate = coor;
    }
    return self;
}
- (id)initWithLocation:(CLLocation*)loc {
    return [self initWithCoordinate:loc.coordinate];
}
@end
@implementation PLMeterBlock
@synthesize open, close, meterID, beginLoc, endLoc, name, occupied, totalMeters, middleLoc;
- (id)initWithDict:(NSDictionary*)dict {
    self = [self init];
    if (self) {
        NSDictionary *locBegDict = [dict objectForKey:@"LOCBEG"];
        NSDictionary *locEndDict = [dict objectForKey:@"LOCEND"];
        beginLoc = CLLocationCoordinate2DMake([[locBegDict objectForKey:@"lat"] floatValue],
                                                   [[locBegDict objectForKey:@"lng"] floatValue]);
        endLoc = CLLocationCoordinate2DMake([[locEndDict objectForKey:@"lat"] floatValue],
                                                 [[locEndDict objectForKey:@"lng"] floatValue]);
    }
    return self;
}
- (CLLocationCoordinate2D)middleLoc {
    return CLLocationCoordinate2DMake((beginLoc.latitude+endLoc.latitude)/2.0, (beginLoc.longitude+endLoc.longitude)/2.0);
}
- (id)init {
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)dealloc {
    [super dealloc];
    //TODO: release all members..
}
@end
