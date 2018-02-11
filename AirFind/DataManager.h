//
//  DataManager.h
//  AirFind
//
//  Created by Артем Полушин on 10.01.2018.
//  Copyright © 2018 Артем Полушин. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Country.h"
#import "City.h"
#import "Airport.h"
#import "Ticket.h"
#import "MapPrice.h"

#define kDataManagerLoadDataDidComplete @"DataManagerLoadDataDidComplete"

typedef enum DataSourceType {
    DataSourceTypeCountry,
    DataSourceTypeCity,
    DataSourceTypeAirport
} DataSourceType;

typedef struct SearchRequest {
    __unsafe_unretained NSString *origin;
    __unsafe_unretained NSString *destination;
    __unsafe_unretained NSDate *departDate;
    __unsafe_unretained NSDate *returnDate;
} SearchRequest;

@interface DataManager : NSObject

+ (instancetype) sharedInstance;
- (void) loadData;
- (City *) cityForIATA: (NSString *)iata;
- (City *) cityForLocation: (CLLocation *)location;

@property (nonatomic, readonly) NSArray *countries;
@property (nonatomic, readonly) NSArray *cities;
@property (nonatomic, readonly) NSArray *airports;

@end
