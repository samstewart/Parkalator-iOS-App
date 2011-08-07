//
//  PLLocationManager.m
//  Parkalator
//
//  Created by Sam Stewart on 8/6/11.
//  Copyright 2011 SamStewartApps.com. All rights reserved.
//

#import "PLLocationManager.h"

@implementation PLLocationManager
@synthesize delegate;

static PLLocationManager *_sharedManager;

+ (PLLocationManager*)sharedLocManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[PLLocationManager alloc] init];
    });
    
    return _sharedManager;
}
- (id)init
{
    self = [super init];
    if (self) {
        _locManager = [[CLLocationManager alloc] init];
        _locManager.delegate = self;
        _locManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locManager.distanceFilter = 100;
    }
    
    return self;
}

- (void)start  {
    //TODO: enable realtime location updates. Lion broke this in simulator, so we hardcode
#warning Hardcoded location because lion broke CLLocation simulator support
    CLLocation *hackLoc = [[CLLocation alloc] initWithLatitude:37.352 longitude:-121.952];
    [self locationManager:_locManager didUpdateToLocation:hackLoc fromLocation:hackLoc];
    /*
    if ([CLLocationManager locationServicesEnabled])
        [_locManager startUpdatingLocation];
    else
        NSLog(@"Cannot utilize location services.");
     */
}

#pragma mark location manager delegate methods
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    userLoc = newLocation;
    NSLog(@"Found user location: %@", userLoc);
    
    [delegate foundUserLocation:newLocation.coordinate];
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"Error finding user's location: %@", [error localizedDescription]);
}

- (void)dealloc {
    [_locManager release], _locManager = nil;
    [userLoc release], userLoc = nil;
    [super dealloc];
}
@end
