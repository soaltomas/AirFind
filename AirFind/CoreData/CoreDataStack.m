//
//  CoreDataStack.m
//  AirFind
//
//  Created by Артем Полушин on 25.01.2018.
//  Copyright © 2018 Артем Полушин. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreDataStack.h"

@interface CoreDataStack()

@property (nonatomic) NSString *modelName;
@property (nonatomic) NSString *storeName;

@property (nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic) NSManagedObjectModel *managedObjectModel;

@end

@implementation CoreDataStack

+ (instancetype)sharedInstance:(NSString *)modelName storeName:(NSString *)storeName{
    
    static CoreDataStack *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[CoreDataStack alloc] init];
        [instance setup: modelName storeName: storeName];
    });
    return instance;
}

- (void)setup:(NSString *)modelName storeName:(NSString *)storeName {
    NSURL *modelUrl = [[NSBundle mainBundle] URLForResource: modelName withExtension: @"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL: modelUrl];
    NSURL *docsUrl = [[[NSFileManager defaultManager] URLsForDirectory: NSDocumentDirectory inDomains: NSUserDomainMask] lastObject];
    NSURL *storeUrl = [docsUrl URLByAppendingPathComponent: storeName];
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: _managedObjectModel];
    NSPersistentStore *store = [_persistentStoreCoordinator addPersistentStoreWithType: NSSQLiteStoreType configuration: nil URL: storeUrl options: nil error: nil];
    
    if (!store) {
        abort();
    }
    
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType: NSMainQueueConcurrencyType];
    _managedObjectContext.persistentStoreCoordinator = _persistentStoreCoordinator;
}

- (void)save {
    NSError *error;
    [_managedObjectContext save: &error];
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
    }
}

- (FavoriteTicket *)favoriteFromTicket:(Ticket *)ticket {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName: @"FavoriteTicket"];
    request.predicate = [NSPredicate predicateWithFormat: @"price == %ld AND airline == %@ AND from == %@ AND to == %@ AND departure == %@ AND expires == %@ AND flightNumber == %ld", (long)ticket.price.integerValue, ticket.airline, ticket.from, ticket.to, ticket.departure, ticket.expires, (long)ticket.flightNumber.integerValue];
    return [[_managedObjectContext executeFetchRequest: request error: nil] firstObject];
}

- (BOOL)isFavorite:(Ticket *)ticket {
    return [self favoriteFromTicket: ticket] != nil;
}

- (void)addToFavorite:(Ticket *)ticket {
    FavoriteTicket *favorite = [NSEntityDescription insertNewObjectForEntityForName: @"FavoriteTicket" inManagedObjectContext: _managedObjectContext];
    favorite.price = ticket.price.intValue;
    favorite.airline = ticket.airline;
    favorite.departure = ticket.departure;
    favorite.expires = ticket.expires;
    favorite.flightNumber = ticket.flightNumber.intValue;
    favorite.returnDate = ticket.returnDate;
    favorite.from = ticket.from;
    favorite.to = ticket.to;
    favorite.created = [NSDate date];
    [self save];
}

- (void)addToFavoriteFromMap:(MapPrice *)mapPrice {
    FavoriteTicket *favorite = [NSEntityDescription insertNewObjectForEntityForName: @"FavoriteTicket" inManagedObjectContext: _managedObjectContext];
    favorite.price = mapPrice.value;
    
}

- (void)removeFromFavorite:(Ticket *)ticket {
    FavoriteTicket *favorite = [self favoriteFromTicket: ticket];
    if (favorite) {
        [_managedObjectContext deleteObject: favorite];
        [self save];
    }
}

- (NSArray *)favorites {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName: @"FavoriteTicket"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey: @"created" ascending: NO]];
    return [_managedObjectContext executeFetchRequest: request error: nil];
}
@end
