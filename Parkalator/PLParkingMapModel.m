//
//  PLParkingMapModel.m
//  Parkalator
//
//  Created by Sam Stewart on 8/6/11.
//  Copyright 2011 SamStewartApps.com. All rights reserved.
//

#import "PLParkingMapModel.h"
#import "PLServerMetersRequest.h"
#import "PLMeterBlock.h"

@interface PLParkingMapModel ()
/** Filters meters so that we only return those within our specified radius.*/
- (NSArray*)filterToRadius:(NSArray*)meters;
- (void)refreshMeters;
@end

@implementation PLParkingMapModel
@synthesize delegate, radius, mapLocation, refreshRate;

- (id)init
{
    self = [super init];
    if (self) {
        //default refresh rate interval
        refreshRate = 5;
        metersCache = [[NSMutableArray arrayWithCapacity:3000] retain];
        hasLoaded = NO;
        _metersRequest = [[PLServerMetersRequest alloc] initWithDelegate:self];
    }
    
    return self;
}
- (void)start {
    //start initial request
    [_metersRequest send];
    
    if (refreshTimer)  [refreshTimer release], refreshTimer = nil;
    refreshTimer = [[NSTimer scheduledTimerWithTimeInterval:self.refreshRate 
                                                     target:self 
                                                   selector:@selector(refreshMeters) 
                                                   userInfo:nil 
                                                    repeats:YES] retain];
    isRunning = YES;
}
#pragma mark Request delegate callback methods
- (void)requestFinished:(id)jsonObject {
    hasLoaded = YES;
    NSDictionary *jsonDict = (NSDictionary*)jsonObject;
    NSArray *meters = [jsonDict objectForKey:@"meters"];
    
    [metersCache removeAllObjects];
    
    NSMutableArray *blockLocations = [NSMutableArray arrayWithCapacity:[meters count]];
    
    for (NSDictionary *meterDict in meters) {
        PLMeterBlock *meterBlock = [[PLMeterBlock alloc] initWithDict:meterDict];
        [metersCache addObject:meterBlock];
        
        CLLocationCoordinate2D midCoor = meterBlock.middleLoc;
        CLLocation *loc = [[CLLocation alloc] initWithLatitude:midCoor.latitude longitude:midCoor.longitude];
        [blockLocations addObject:loc];
    }
    
    [delegate meterBlockLocations:blockLocations];
    
}
- (void)requestFailedWithError:(NSError*)jsonError {
    hasLoaded = YES;
    NSLog(@"Meter block request failed: %@", [jsonError localizedDescription]);
}
#pragma mark Data access methods
- (void)refreshMeters {
    if (hasLoaded) {
        hasLoaded = NO;
        NSLog(@"Refreshing parking meters..");
        
        [_metersRequest send];
        
    } else {
        NSLog(@"not refreshing because we haven't finished");
    }
   
}
- (NSArray*)filterToRadius:(NSArray *)meters {
    return nil;
}

- (void)dealloc {
    [refreshTimer release], refreshTimer = nil;
    [metersCache release], metersCache = nil;
    [_metersRequest release], _metersRequest = nil;
    [super dealloc];
}
@end
