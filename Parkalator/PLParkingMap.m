//
//  PLParkingMap.m
//  Parkalator
//
//  Created by Sam Stewart on 8/6/11.
//  Copyright 2011 SamStewartApps.com. All rights reserved.
//

#import "PLParkingMap.h"
#import "PLParkingMapModel.h"
#import "PLMeterBlock.h"

@implementation PLParkingMap
@synthesize isRealtime;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        model = [[PLParkingMapModel alloc] init];
        model.delegate = self;
        [model start];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
#pragma mark location manager delegate
- (void)foundUserLocation:(CLLocationCoordinate2D)loc {
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, METERS_PER_MILE*.5, METERS_PER_MILE*.5);
    [map_view setRegion:region animated:YES];
}
#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
    map_view = [[MKMapView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    map_view.delegate = self;
    map_view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    map_view.showsUserLocation = YES;
    self.view = map_view;
    self.navigationItem.title = @"Parkalator";
    
    //find users location..
    PLLocationManager *locMan = [PLLocationManager sharedLocManager];
    locMan.delegate = self;
    [locMan start];
}
#pragma mark Map model delegate
- (void)meterBlockLocations:(NSArray *)locations {
    //clear all annotations
    [map_view removeAnnotations:map_view.annotations];
    
    for (CLLocation *loc in locations) {
        PLMeterBlockAnnotation *annot = [[PLMeterBlockAnnotation alloc] initWithLocation:loc];
        [map_view addAnnotation:annot];
    }
}
#pragma mark MapView delegate
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    NSLog(@"User selected annotation view");
}
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    //update the models location so we can load more records..
    model.mapLocation = mapView.region.center;
}
/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [model release], model = nil;
    [map_view release], map_view = nil;
    [super dealloc];
}
@end
