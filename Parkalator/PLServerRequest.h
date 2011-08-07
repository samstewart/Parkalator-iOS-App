//
//  PLServerRequest.h
//  Parkalator
//
//  Created by Sam Stewart on 8/6/11.
//  Copyright 2011 SamStewartApps.com. All rights reserved.
//

/**
 Generic base class for server request.
 
 Override this class for each api request as this class should never be used directly.
 
 We provide a ton of public methods so that base classes can override them.
 */
#import <Foundation/Foundation.h>

#define PL_URL(api_url) [NSString stringWithFormat:@"http://parkalator.com%@", api_url]

/** Generic delegate interface.*/
@protocol PLServerRequestDelegate <NSObject>
- (void)requestFinished:(id)jsonObject;
- (void)requestFailedWithError:(NSError*)jsonError;

@end

@class SBJsonParser;
@interface PLServerRequest : NSObject {
    NSMutableData *dataBuffer;
    
    SBJsonParser *_parser;
}

- (void)send;
//override points for subclasses..
- (void)requestSucceeded:(id)jsonResponse;
- (void)requestFailed:(NSError*)error;

@property (nonatomic, retain) id <PLServerRequestDelegate> delegate;
@property (nonatomic, readonly) NSString *requestURL;
@property (nonatomic, readonly) NSString *requestQuery;
@property (nonatomic, retain) NSMutableDictionary *parameters;
@end
