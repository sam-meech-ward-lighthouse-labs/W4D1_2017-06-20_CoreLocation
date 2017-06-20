//
//  MapViewController.h
//  LocationAndMaps
//
//  Created by Sam Meech-Ward on 2017-06-20.
//  Copyright © 2017 Sam Meech-Ward. All rights reserved.
//

#import <UIKit/UIKit.h>
@import CoreLocation;

@interface MapViewController : UIViewController

@property (nonatomic, strong) CLLocation *startLocation;

@end
