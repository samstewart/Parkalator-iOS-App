//
//  PLMeter.h
//  Parkalator
//
//  Created by Sam Stewart on 8/6/11.
//  Copyright 2011 SamStewartApps.com. All rights reserved.
//

/** Simple model object which represents a block of parking meters (which is the most refined the api gives us). 
 In the future, we'll probably change this to a NSManagedObject.*/
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

/** Simple annotation object.*/
@interface PLMeterBlockAnnotation : NSObject <MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

- (id)initWithCoordinate:(CLLocationCoordinate2D)coor;
- (id)initWithLocation:(CLLocation*)loc;
@end

@interface PLMeterBlock : NSObject
- (id)initWithDict:(NSDictionary*)dict;

@property (nonatomic, readonly) NSDate *open;
@property (nonatomic, readonly) NSDate *close;
@property (nonatomic, readonly) NSString *meterID;
@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) CLLocationCoordinate2D beginLoc;
@property (nonatomic, readonly) CLLocationCoordinate2D endLoc;
@property (nonatomic, readonly) NSInteger occupied;
@property (nonatomic, readonly) NSInteger totalMeters;
//average of beginLoc and endLoc
@property (nonatomic, readonly) CLLocationCoordinate2D middleLoc;
@end
