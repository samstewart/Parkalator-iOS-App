//
//  PLServerMetersRequest.h
//  Parkalator
//
//  Created by Sam Stewart on 8/6/11.
//  Copyright 2011 SamStewartApps.com. All rights reserved.
//
/**
 Grabs the meter data from the server. This is called quite frequently.
 You should hook into the delegate to receive parking meter updates.
 */
#import "PLServerRequest.h"

@protocol PLServerMetersRequestDelegate <NSObject, PLServerRequestDelegate>

@end
@interface PLServerMetersRequest : PLServerRequest

@end
