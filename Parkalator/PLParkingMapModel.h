//
//  PLParkingMapModel.h
//  Parkalator
//
//  Created by Sam Stewart on 8/6/11.
//  Copyright 2011 SamStewartApps.com. All rights reserved.
//
/**
 Model for main parking app. It's a model which polls the server as frequently as possible for parking meter
 updates to achieve near realtime results.
 
 You should make sure to update mapLocation so that we know which annotations to show.
 
 Note: currently, we just dump all the annotations on the map, but in the future, we'd like to only show those in
 the current view.
 
 We'd also like to paginate in the future since the record size is so large.
 */

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "PLServerRequest.h"

@protocol PLParkingMapModelDelegate <NSObject>
/** Called when we load a set of parking meters. You are passed an array of PLMeterBlocks.
 Note: DEPRECATED*/
- (void)meterBlocksLoaded:(NSArray*)meterBlocks atPage:(NSInteger)index;
/** Called with an array of CLLocation objects which should be plotted on the map*/
- (void)meterBlockLocations:(NSArray*)locations;
@end

@class PLServerMetersRequest;
@interface PLParkingMapModel : NSObject <PLServerRequestDelegate> {
    PLServerMetersRequest *_metersRequest;
    NSTimer *refreshTimer;
    BOOL isRunning;
    
    //cache of PLMeterBlock objects
    NSMutableArray *metersCache;
    BOOL hasLoaded;
}
- (void)start;

@property (nonatomic, assign) CLLocationCoordinate2D mapLocation;
@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) NSTimeInterval refreshRate;
@property (nonatomic, retain) id <PLParkingMapModelDelegate> delegate;
@end
