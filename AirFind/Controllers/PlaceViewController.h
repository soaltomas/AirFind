//
//  PlaceViewController.h
//  AirFind
//
//  Created by Артем Полушин on 11.01.2018.
//  Copyright © 2018 Артем Полушин. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"

typedef enum PlaceType {
    PlaceTypeArrival,
    PlaceTypeDeparture
} PlaceType;

@protocol PlaceViewControllerDelegate<NSObject>
- (void)selectPlace:(id)place withType:(PlaceType)placeType andDataType:(DataSourceType)dataType;
@end

@interface PlaceViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic) id<PlaceViewControllerDelegate> delegate;
- (instancetype) initWithType:(PlaceType)type;
@end
