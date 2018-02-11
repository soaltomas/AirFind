//
//  City.h
//  AirFind
//
//  Created by Артем Полушин on 08.01.2018.
//  Copyright © 2018 Артем Полушин. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface City : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *timezone;
@property (nonatomic) NSString *code;
@property (nonatomic) NSString *countryCode;
@property (nonatomic) NSDictionary *translations;
@property (nonatomic) CLLocationCoordinate2D coordiante;

- (instancetype) initWithDictionary:(NSDictionary *)dictionary;

@end
