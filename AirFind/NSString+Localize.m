//
//  NSString+Localize.m
//  AirFind
//
//  Created by Артем Полушин on 11.02.2018.
//  Copyright © 2018 Артем Полушин. All rights reserved.
//

#import "NSString+Localize.h"

@implementation NSString (Localize)

- (NSString *)localize {
    return NSLocalizedString(self, "");
}

@end
