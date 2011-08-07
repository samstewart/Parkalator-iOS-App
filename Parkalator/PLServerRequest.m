//
//  PLServerRequest.m
//  Parkalator
//
//  Created by Sam Stewart on 8/6/11.
//  Copyright 2011 SamStewartApps.com. All rights reserved.
//

#import "PLServerRequest.h"
#import "SBJsonParser.h"

@interface PLServerRequest ()
/** Converts keys/values (both should be strings) from dictionary into a query string. (starts with "?")
 Make sure all keys/values are url safe before passing in.
 */
- (NSString*)queryFromParams:(NSDictionary*)params;
@end
@implementation PLServerRequest
@synthesize requestURL=_requestURL, delegate, parameters, requestQuery;

- (id)init
{
    self = [super init];
    if (self) {
        //init code here
    }
    
    return self;
}
#pragma mark Base Class Request Methods
- (void)send {
    NSURL *url = [NSURL URLWithString:self.requestURL];
    NSLog(@"Creating url with string: %@", self.requestURL);
    
    NSAssert1(url, @"Error creating url from string: %@", self.requestURL);
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0];
    
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    NSAssert(conn, @"Could not create url connection");
    
    if (dataBuffer) [dataBuffer release], dataBuffer = nil;;
    dataBuffer = [[NSMutableData dataWithLength:100] retain];
    
}
- (void)requestSucceeded:(id)jsonResponse {
    //by default, we just call the delegate..
    [delegate requestFinished:jsonResponse];
}
- (void)requestFailed:(NSError *)error {
    //by default, we just call the delegate..
    [delegate requestFailedWithError:error];
}

#pragma mark URL Generation and override points

- (NSString*)queryFromParams:(NSDictionary *)params {
    NSArray *keys = [params allKeys];
    
    if ([keys count] == 0) return @"";
    
    NSMutableString *queryStr = [NSMutableString stringWithCapacity:30];
    [queryStr appendString:@"?"];
    BOOL isFirst = YES;
    
    for (NSString *key in keys) {
        NSString *value = [params objectForKey:key];
        if (!isFirst) {
            isFirst = NO;
            [queryStr appendString:@"&"];
        }
        
        [queryStr appendFormat:@"%@=%@", key, value];
        
    }
    return queryStr;
}
- (NSString*)requestQuery {
    NSString *query = [self queryFromParams:parameters];
    NSLog(@"Request query: %@", query);
    
    return query;
}
- (NSString*)requestURL {
    NSAssert(NO, @"PLServerRequest is an abstract class and should not be used directly. Use a subclasses");
    //usually use PL_URL + requestQuery
    return nil;
}
#pragma mark NSURLConnection Callback methods
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [dataBuffer appendData:data];
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [dataBuffer release], dataBuffer = nil;
    [connection release], connection = nil;
    
    [self requestFailed:error];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    //parse into json, every time
    NSString *json_str = [[NSString alloc] initWithData:dataBuffer encoding:NSUTF8StringEncoding];
    
    [dataBuffer release], dataBuffer = nil;
    [connection release], connection = nil;
    
    if (!_parser) _parser = [[SBJsonParser alloc] init];
    
    NSError *error = nil;
    id jsonObject = [_parser objectWithString:json_str error:&error];
    [json_str release];
    
    
    if (error)
        [self requestFailed:error];
    else
        [self requestSucceeded:jsonObject];
}
- (void)dealloc {
    [parameters release], parameters = nil;
    [dataBuffer release], dataBuffer = nil;
    [_parser release], _parser = nil;
    [super dealloc];
}
@end
