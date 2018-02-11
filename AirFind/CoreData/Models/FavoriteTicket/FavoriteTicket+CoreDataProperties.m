//
//  FavoriteTicket+CoreDataProperties.m
//  
//
//  Created by Артем Полушин on 27.01.2018.
//
//

#import "FavoriteTicket+CoreDataProperties.h"

@implementation FavoriteTicket (CoreDataProperties)

+ (NSFetchRequest<FavoriteTicket *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"FavoriteTicket"];
}

@dynamic airline;
@dynamic created;
@dynamic departure;
@dynamic expires;
@dynamic flightNumber;
@dynamic from;
@dynamic price;
@dynamic returnDate;
@dynamic to;
@dynamic fromMap;

@end
