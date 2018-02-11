//
//  LocationService.m
//  AirFind
//
//  Created by Артем Полушин on 17.01.2018.
//  Copyright © 2018 Артем Полушин. All rights reserved.
//

#import "LocationService.h"
#import "NSString+Localize.h"

@interface LocationService() <CLLocationManagerDelegate>
@property (nonatomic) CLLocationManager *locationManager;
@property (nonatomic) CLLocation *currentLocation;
@end

@implementation LocationService

- (instancetype) init {
    self = [super init];
    if (self) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        [_locationManager requestAlwaysAuthorization];
    }
    return self;
}

-(void) locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [_locationManager startUpdatingLocation];
    } else if (status == kCLAuthorizationStatusNotDetermined) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle: [@"close" localize] message: [@"not_determine_current_city" localize] preferredStyle: UIAlertControllerStyleAlert];
        [alertController addAction: [UIAlertAction actionWithTitle: [@"close" localize] style: (UIAlertActionStyleDefault) handler: nil]];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController: alertController animated: YES completion: nil];
    }
}

- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    if (!_currentLocation) {
        _currentLocation = [locations firstObject];
        [_locationManager stopUpdatingLocation];
        [[NSNotificationCenter defaultCenter] postNotificationName: kLocationServiceDidUpdateCurrentLocation object: _currentLocation];
    }
}

@end
