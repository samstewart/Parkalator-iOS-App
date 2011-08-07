//
//  PLParkingMap.h
//  Parkalator
//
//  Created by Sam Stewart on 8/6/11.
//  Copyright 2011 SamStewartApps.com. All rights reserved.
//

/** Map of parking availability pulled from the parkalator web api. If you set realtime to true,
 we hit the API pretty hard to ensure almost realtime updates.*/

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "PLLocationManager.h"
#import "PLParkingMapModel.h"

@class PLParkingMapModel;
@interface PLParkingMap : UIViewController <MKMapViewDelegate, PLLocationManagerDelegate, PLParkingMapModelDelegate> {
    MKMapView *map_view;
    PLParkingMapModel *model;
}
@property (nonatomic, assign) BOOL isRealtime;
@end
