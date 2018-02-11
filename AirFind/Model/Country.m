//
//  Country.m
//  AirFind
//
//  Created by Артем Полушин on 08.01.2018.
//  Copyright © 2018 Артем Полушин. All rights reserved.
//

#import "Country.h"

@implementation Country

- (instancetype) initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    
    if(self) {
        _name = [dictionary valueForKey: @"name"];
        _currency = [dictionary valueForKey: @"currency"];
        _code = [dictionary valueForKey: @"code"];
        _translations = [dictionary valueForKey: @"name_translations"];
    }
    
    return self;
    
}

@end
