//
//  Ticket.h
//  AirFind
//
//  Created by Артем Полушин on 13.01.2018.
//  Copyright © 2018 Артем Полушин. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ticket : NSObject

@property (nonatomic) NSNumber *price;
@property (nonatomic) NSString *airline;
@property (nonatomic) NSDate *departure;
@property (nonatomic) NSDate *expires;
@property (nonatomic) NSNumber *flightNumber;
@property (nonatomic) NSDate *returnDate;
@property (nonatomic) NSString *from;
@property (nonatomic) NSString *to;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
