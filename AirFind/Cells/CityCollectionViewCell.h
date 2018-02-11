//
//  CityCollectionViewCell.h
//  AirFind
//
//  Created by Артем Полушин on 11.02.2018.
//  Copyright © 2018 Артем Полушин. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "City.h"
#import "Airport.h"

@interface CityCollectionViewCell : UICollectionViewCell

@property (nonatomic) City *city;
@property (nonatomic) Airport *airport;

@end
