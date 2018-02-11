//
//  CoreDataStack.h
//  AirFind
//
//  Created by Артем Полушин on 25.01.2018.
//  Copyright © 2018 Артем Полушин. All rights reserved.
//

#ifndef CoreDataStack_h
#define CoreDataStack_h

#import <CoreData/CoreData.h>
#import "DataManager.h"
#import "FavoriteTicket+CoreDataClass.h"
#import "Ticket.h"
#import "MapPrice.h"

@interface CoreDataStack: NSObject

+ (instancetype)sharedInstance:(NSString *)modelName storeName:(NSString *)storeName;

- (BOOL)isFavorite:(Ticket *)ticket;
- (NSArray *)favorites;
- (void)addToFavorite:(Ticket *)ticket;
- (void)addToFavoriteFromMap:(MapPrice *)mapPrice;
- (void)removeFromFavorite:(Ticket *)ticket;

@end

#endif /* CoreDataStack_h */
