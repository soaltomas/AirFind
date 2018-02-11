//
//  TicketsViewController.h
//  AirFind
//
//  Created by Артем Полушин on 13.01.2018.
//  Copyright © 2018 Артем Полушин. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TicketsViewController : UITableViewController

- (instancetype)initWithTickets:(NSArray *)tickets;
- (instancetype)initFavoriteTicketsController;

@end
