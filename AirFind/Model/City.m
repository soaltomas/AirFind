//
//  City.m
//  AirFind
//
//  Created by Артем Полушин on 08.01.2018.
//  Copyright © 2018 Артем Полушин. All rights reserved.
//

#import "City.h"

@implementation City

- (instancetype) initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    
    if(self) {
        _name = [dictionary valueForKey: @"name"];
        _timezone = [dictionary valueForKey: @"time_zone"];
        _code = [dictionary valueForKey: @"code"];
        _countryCode = [dictionary valueForKey: @"country_code"];
        _translations = [dictionary valueForKey: @"name_translations"];
        
        NSDictionary *coords = [dictionary valueForKey: @"coordinates"];
        if(coords && ![coords isEqual: [NSNull null]]) {
            NSNumber *lon = [coords valueForKey: @"lon"];
            NSNumber *lat = [coords valueForKey: @"lat"];
            if(![lon isEqual: [NSNull null]] && ![lat isEqual: [NSNull null]]) {
                _coordiante =CLLocationCoordinate2DMake([lat doubleValue], [lon doubleValue]);
            }
        }
        [self LocalizeName];
    }
    
    return self;
}

- (void)LocalizeName {
    if(!_translations) return;
    NSLocale *locale = [NSLocale currentLocale];
    NSString *localeId = [locale.localeIdentifier substringToIndex: 2];
    if(localeId) {
        if([_translations valueForKey: localeId]) {
            self.name = [_translations valueForKey: localeId];
        }
    }
}

@end
