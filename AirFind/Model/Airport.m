//
//  Airport.m
//  AirFind
//
//  Created by Артем Полушин on 09.01.2018.
//  Copyright © 2018 Артем Полушин. All rights reserved.
//

#import "Airport.h"

@implementation Airport

- (instancetype) initWithDictionary:(NSDictionary *)dictionary {
    
    self = [super init];
    
    if(self) {
        _name = [dictionary valueForKey: @"name"];
        _timezone = [dictionary valueForKey: @"time_zone"];
        _code = [dictionary valueForKey: @"code"];
        _countryCode = [dictionary valueForKey: @"country_code"];
        _cityCode = [dictionary valueForKey: @"city_code"];
        _translations = [dictionary valueForKey: @"name_translations"];
        _flightable = [dictionary valueForKey: @"flightable"];
        
        NSDictionary *coords = [dictionary valueForKey: @"coordinates"];
        if(coords && ![coords isEqual: [NSNull null]]) {
            NSNumber *lon = [coords valueForKey: @"lon"];
            NSNumber *lat = [coords valueForKey: @"lat"];
            if(![lon isEqual: [NSNull null]] && ![lat isEqual: [NSNull null]]) {
                _coordinate = CLLocationCoordinate2DMake([lat doubleValue], [lon doubleValue]);
            }
        }
    }
    
    return self;
    
}

@end
