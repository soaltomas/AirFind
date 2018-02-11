//
//  Country.h
//  AirFind
//
//  Created by Артем Полушин on 08.01.2018.
//  Copyright © 2018 Артем Полушин. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Country : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *currency;
@property (nonatomic) NSString *code;
@property (nonatomic) NSDictionary *translations;

- (instancetype) initWithDictionary:(NSDictionary *)dictionary;

@end
