//
//  APIManager.h
//  AirFind
//
//  Created by Артем Полушин on 12.01.2018.
//  Copyright © 2018 Артем Полушин. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataManager.h"

@interface APIManager : NSObject

+ (instancetype)sharedInstance;
- (void)cityForCurrentIP:(void(^)(City *city))completion;
- (void)ticketsWithRequest:(SearchRequest)request withCompletion:(void (^)(NSArray *tickets))completion;
- (void)mapPricesFor:(City *)origin withCompletion:(void (^)(NSArray *prices))completion;

@end
