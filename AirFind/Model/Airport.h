//
//  Airport.h
//  AirFind
//
//  Created by Артем Полушин on 09.01.2018.
//  Copyright © 2018 Артем Полушин. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Airport : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *timezone;
@property (nonatomic) NSString *code;
@property (nonatomic) NSString *countryCode;
@property (nonatomic) NSString *cityCode;
@property (nonatomic) NSDictionary *translations;
@property (nonatomic, getter=isFlightable) BOOL flightable;
@property (nonatomic) CLLocationCoordinate2D coordinate;

- (instancetype) initWithDictionary:(NSDictionary *) dictionary;

@end
