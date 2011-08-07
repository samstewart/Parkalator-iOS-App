//
//  PLLocationManager.h
//  Parkalator
//
//  Created by Sam Stewart on 8/6/11.
//  Copyright 2011 SamStewartApps.com. All rights reserved.
//

/** Simple singleton for getting users current location*/
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#define METERS_PER_MILE 1609.344

@protocol PLLocationManagerDelegate <NSObject>
- (void)foundUserLocation:(CLLocationCoordinate2D)loc;
@end

@interface PLLocationManager : NSObject <CLLocationManagerDelegate> {
    CLLocationManager *_locManager;
    CLLocation *userLoc;
}

+ (PLLocationManager*)sharedLocManager;
- (void)start;

@property (nonatomic, retain) id <PLLocationManagerDelegate> delegate;
@end
