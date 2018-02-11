//
//  MapPrice.h
//  AirFind
//
//  Created by Артем Полушин on 17.01.2018.
//  Copyright © 2018 Артем Полушин. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "City.h"

@interface MapPrice : NSObject

@property (nonatomic) City *destination;
@property (nonatomic) City *origin;
@property (nonatomic) NSDate *departure;
@property (nonatomic) NSDate *returnDate;
@property (nonatomic) NSInteger numberOfChanges;
@property (nonatomic) NSInteger value;
@property (nonatomic) NSInteger distance;
@property (nonatomic) BOOL actual;

- (instancetype) initWithDictionary: (NSDictionary *)dictionary withOrigin:(City *)origin;

@end
