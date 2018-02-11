//
//  FavoriteTicket+CoreDataProperties.h
//  
//
//  Created by Артем Полушин on 27.01.2018.
//
//

#import "FavoriteTicket+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface FavoriteTicket (CoreDataProperties)

+ (NSFetchRequest<FavoriteTicket *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *airline;
@property (nullable, nonatomic, copy) NSDate *created;
@property (nullable, nonatomic, copy) NSDate *departure;
@property (nullable, nonatomic, copy) NSDate *expires;
@property (nonatomic) int16_t flightNumber;
@property (nullable, nonatomic, copy) NSString *from;
@property (nonatomic) int64_t price;
@property (nullable, nonatomic, copy) NSDate *returnDate;
@property (nullable, nonatomic, copy) NSString *to;
@property (nonatomic) BOOL fromMap;

@end

NS_ASSUME_NONNULL_END
