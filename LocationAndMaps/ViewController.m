//
//  ViewController.m
//  LocationAndMaps
//
//  Created by Sam Meech-Ward on 2017-06-20.
//  Copyright © 2017 Sam Meech-Ward. All rights reserved.
//

#import "ViewController.h"
@import CoreLocation;

#import "MapViewController.h"

@interface ViewController () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation *currentLocation;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.allowsBackgroundLocationUpdates = YES;
    [self.locationManager requestWhenInUseAuthorization];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)getLocation:(id)sender {
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [self.locationManager requestLocation];
    } else {
        // Send the user to settings to enable location authorization
    }
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        NSLog(@"kCLAuthorizationStatusAuthorizedWhenInUse");
    } else if (status == kCLAuthorizationStatusAuthorizedAlways) {
        NSLog(@"kCLAuthorizationStatusAuthorizedAlways");
    } else if (status == kCLAuthorizationStatusDenied) {
        NSLog(@"kCLAuthorizationStatusDenied");
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    if (!self.currentLocation) {
        self.currentLocation = locations[0];
        
        NSLog(@"location: %@", locations[0]);
        
        [self performSegueWithIdentifier:@"show-map" sender:self];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"Error getting the location updates: %@", error.localizedDescription);
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"show-map"]) {
        MapViewController *mapViewController = (MapViewController *)segue.destinationViewController;
        mapViewController.startLocation = self.currentLocation;
    }
}

@end
