//
//  TicketTableViewCell.h
//  AirFind
//
//  Created by Артем Полушин on 13.01.2018.
//  Copyright © 2018 Артем Полушин. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"
#import "APIManager.h"
#import "Ticket.h"
#import "FavoriteTicket+CoreDataClass.h"

@interface TicketTableViewCell : UITableViewCell

@property (nonatomic) Ticket *ticket;
@property (nonatomic) FavoriteTicket *favoriteTicket;
@property (nonatomic) UIImageView *airlineLogoView;

@end
