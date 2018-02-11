//
//  MapViewController.m
//  AirFind
//
//  Created by Артем Полушин on 17.01.2018.
//  Copyright © 2018 Артем Полушин. All rights reserved.
//

#import "MapViewController.h"
#import "LocationService.h"
#import "APIManager.h"
#import "MapPrice.h"
#import "NSString+Localize.h"

@interface MapViewController () <MKMapViewDelegate>
@property (nonatomic) MKMapView *mapView;
@property (nonatomic) LocationService *locationService;
@property (nonatomic) City *origin;
@property (nonatomic) NSArray *prices;
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = [@"map" localize];
    
    _mapView = [[MKMapView alloc] initWithFrame: self.view.bounds];
    _mapView.showsUserLocation = YES;
    [self.view addSubview: _mapView];
    
    [[DataManager sharedInstance] loadData];
    
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(dataLoadedSuccessfully) name:kDataManagerLoadDataDidComplete object: nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(updateCurrentLocation:) name:kLocationServiceDidUpdateCurrentLocation object: nil];
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver: self];
}

- (void) dataLoadedSuccessfully {
    _locationService = [[LocationService alloc] init];
}

- (void) updateCurrentLocation:(NSNotification *) notification {
    CLLocation *currentLocation = notification.object;
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(currentLocation.coordinate, 1000000, 1000000);
    [_mapView setRegion: region animated: YES];
    
    if (currentLocation) {
        _origin = [[DataManager sharedInstance] cityForLocation: currentLocation];
        if(_origin) {
            [[APIManager sharedInstance] mapPricesFor: _origin withCompletion:^(NSArray *prices) {
                self.prices = prices;
            }];
        }
    }
}

- (void) setPrices:(NSArray *)prices {
    _prices = prices;
    [_mapView removeAnnotations: _mapView.annotations];
    
    for(MapPrice *price in prices) {
        dispatch_async(dispatch_get_main_queue(), ^{
            MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
            annotation.title = [NSString stringWithFormat: @"%@ (%@)", price.destination.name, price.destination.code];
            annotation.subtitle = [NSString stringWithFormat: @"%ld руб.", (long)price.value];
            annotation.coordinate = price.destination.coordiante;
            [_mapView addAnnotation: annotation];
        });
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
