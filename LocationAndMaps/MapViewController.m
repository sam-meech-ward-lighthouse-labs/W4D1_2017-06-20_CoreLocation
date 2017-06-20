//
//  MapViewController.m
//  LocationAndMaps
//
//  Created by Sam Meech-Ward on 2017-06-20.
//  Copyright © 2017 Sam Meech-Ward. All rights reserved.
//

#import "MapViewController.h"
@import MapKit;

@interface MapViewController () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupMap];
    
    [self setupStartLocationAnnotation];
}

- (void)setupMap {
    int regionRadius = 1000;
    CLLocationCoordinate2D startLocationCoordinate = self.startLocation.coordinate;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(startLocationCoordinate, regionRadius*2, regionRadius*2);
    [self.mapView setRegion:region];
    
    self.mapView.delegate = self;
}

- (void)setupStartLocationAnnotation {
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = self.startLocation.coordinate;
    point.title = @"My Location";
    
    [self.mapView addAnnotation:point];
    [self setAnnotationAddress:point];
}

- (void)setAnnotationAddress:(MKPointAnnotation *)point {
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    [geocoder reverseGeocodeLocation:self.startLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        CLPlacemark *placemark = placemarks[0];
        
        point.title = placemark.thoroughfare;
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Map View Delegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    MKPinAnnotationView *pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"MyCustomAnnotation"];
    
    pin.canShowCallout = YES;
    
    return pin;
}

@end
