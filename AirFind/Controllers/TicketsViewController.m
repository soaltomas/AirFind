//
//  TicketsViewController.m
//  AirFind
//
//  Created by Артем Полушин on 13.01.2018.
//  Copyright © 2018 Артем Полушин. All rights reserved.
//

#import "TicketsViewController.h"
#import "TicketTableViewCell.h"
#import "CoreDataStack.h"
#import "NotificationCenter.h"
#import "NSString+Localize.h"

#define TicketCellReuseIdentifier @"TicketCellIdentifier"

@interface TicketsViewController ()
@property (nonatomic) NSArray *tickets;
@property (nonatomic) UIDatePicker *datePicker;
@property (nonatomic) UITextField *dateTextField;
//@property (nonatomic) UISegmentedControl *segmentedControl;
@end

@implementation TicketsViewController {
    BOOL isFavorites;
    TicketTableViewCell *notificationCell;
}

- (instancetype)initWithTickets:(NSArray *)tickets {
    self = [super init];
    
    if(self) {
        _tickets = tickets;
        self.title = [@"tickets_title" localize];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.tableView registerClass: [TicketTableViewCell class] forCellReuseIdentifier: TicketCellReuseIdentifier];
    }
    return self;
}

- (instancetype)initFavoriteTicketsController {
    self = [super init];
    if (self) {
        isFavorites = YES;
        self.tickets = [NSArray new];
        self.title = [@"favorites" localize];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.tableView registerClass: [TicketTableViewCell class] forCellReuseIdentifier: TicketCellReuseIdentifier];
        
        _datePicker = [[UIDatePicker alloc] init];
        _datePicker.datePickerMode = UIDatePickerModeDateAndTime;
        _datePicker.minimumDate = [NSDate date];
        _dateTextField = [[UITextField alloc] initWithFrame: self.view.bounds];
        _dateTextField.hidden = YES;
        _dateTextField.inputView = _datePicker;
        UIToolbar *keyboardToolbar = [[UIToolbar alloc] init];
        [keyboardToolbar sizeToFit];
        UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace target: nil action: nil];
        UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemDone target: self action: @selector(doneButtonDidTap:)];
        keyboardToolbar.items = @[flexBarButton, doneBarButton];
        _dateTextField.inputAccessoryView = keyboardToolbar;
        [self.view addSubview: _dateTextField];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    if(isFavorites) {
//        _segmentedControl = [[UISegmentedControl alloc] initWithItems: @[@"Из найденного", @"С карты"]];
//        [_segmentedControl addTarget: self action: @selector(changeSource) forControlEvents: UIControlEventValueChanged];
//        _segmentedControl.tintColor = [UIColor blackColor];
//        self.navigationItem.titleView = _segmentedControl;
//    }
}

- (void)changeSource {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return _tickets.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TicketTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: TicketCellReuseIdentifier forIndexPath:indexPath];
    if(isFavorites) {
        cell.favoriteTicket = [_tickets objectAtIndex: indexPath.row];
    } else {
        cell.ticket = [_tickets objectAtIndex: indexPath.row];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 140.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (isFavorites) {
        return;
    }
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle: [@"actions_with_tickets" localize] message: [@"actions_with_tickets_describe" localize] preferredStyle: UIAlertControllerStyleActionSheet];
    UIAlertAction *favoriteAction;
    if ([[CoreDataStack sharedInstance: @"AirFind" storeName: @"base.sqlite"] isFavorite: [_tickets objectAtIndex: indexPath.row]]) {
        favoriteAction = [UIAlertAction actionWithTitle: [@"remove_from_favorite" localize] style: UIAlertActionStyleDestructive handler: ^(UIAlertAction *_Nonnull action) {
            [[CoreDataStack sharedInstance: @"AirFind" storeName: @"base.sqlite"] removeFromFavorite: [_tickets objectAtIndex: indexPath.row]];
        }];
    } else {
        favoriteAction = [UIAlertAction actionWithTitle: [@"add_to_favorite" localize] style: UIAlertActionStyleDefault handler: ^(UIAlertAction *_Nonnull action) {
            [[CoreDataStack sharedInstance: @"AirFind" storeName: @"base.sqlite"] addToFavorite: [_tickets objectAtIndex: indexPath.row]];
        }];
    }
    
    UIAlertAction *notificationAction = [UIAlertAction actionWithTitle:[@"remind_me" localize] style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                                                                     notificationCell = [tableView cellForRowAtIndexPath:indexPath];
                                                                     [_dateTextField becomeFirstResponder];
                                          }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle: [@"close" localize] style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:favoriteAction];
    [alertController addAction:notificationAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)doneButtonDidTap:(UIBarButtonItem *)sender
{
    if (_datePicker.date && notificationCell) {
        NSString *message = [NSString stringWithFormat:@"%@ - %@ за %@ руб.",
                             notificationCell.ticket.from, notificationCell.ticket.to, notificationCell.ticket.price];
        NSURL *imageURL;
        if (notificationCell.airlineLogoView.image) {
            NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingString:[NSString stringWithFormat:@"/%@.png", notificationCell.ticket.airline]];
            if(![[NSFileManager defaultManager] fileExistsAtPath: path]) {
                UIImage *logo = notificationCell.airlineLogoView.image;
                NSData *pngData = UIImagePNGRepresentation(logo);
                [pngData writeToFile: path atomically: YES];
            }
            imageURL = [NSURL fileURLWithPath: path];
        }
        Notification notification = NotificationMake([@"tickets_reminder" localize], message, _datePicker.date, imageURL);
        [[NotificationCenter sharedInstance] sendNotification: notification];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle: [@"success" localize] message: [NSString stringWithFormat: @"%@ - %@", [@"notification_will_be_sent" localize], _datePicker.date] preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle: [@"close" localize] style: UIAlertActionStyleCancel handler: nil];
        [alertController addAction: cancelAction];
        [self presentViewController: alertController animated: YES completion: nil];
    }
    _datePicker.date = [NSDate date];
    notificationCell = nil;
    [self.view endEditing: YES];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear: animated];
    
    if (isFavorites) {
        self.navigationController.navigationBar.prefersLargeTitles = YES;
        _tickets = [[CoreDataStack sharedInstance: @"AirFind" storeName: @"base.sqlite"] favorites];
        [self.tableView reloadData];
    }
    
    [UIView animateWithDuration:1.0 animations:^{
        NSArray *cells = [self.tableView visibleCells];
        [cells enumerateObjectsUsingBlock:^(UITableViewCell *obj,
                                            NSUInteger idx, BOOL *stop) {
            
            CALayer *layer = obj.layer;
            
            CABasicAnimation *rotateAnimation =
            [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
            rotateAnimation.byValue = @(M_PI*2);
            rotateAnimation.duration = 1.0;
            
            [layer addAnimation:rotateAnimation
                                    forKey:@"rotateAnimation"];
        }];
    }];
}

@end
