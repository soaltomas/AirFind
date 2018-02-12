//
//  CityCollectionViewCell.m
//  AirFind
//
//  Created by Артем Полушин on 11.02.2018.
//  Copyright © 2018 Артем Полушин. All rights reserved.
//

#import "CityCollectionViewCell.h"

@interface CityCollectionViewCell()

@property (nonatomic) UILabel *textLabel;

@end

@implementation CityCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame: frame];
    
    if(self) {
        self.contentView.layer.shadowColor = [[[UIColor blackColor] colorWithAlphaComponent: 0.2] CGColor];
        self.contentView.layer.shadowOffset = CGSizeMake(1.0, 1.0);
        self.contentView.layer.shadowRadius = 10.0;
        self.contentView.layer.shadowOpacity = 1.0;
        self.contentView.layer.cornerRadius = 15.0;
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _textLabel = [[UILabel alloc] initWithFrame: CGRectMake(5, self.bounds.size.height/2 - 10, self.bounds.size.width, 20)];
        [self.contentView addSubview: _textLabel];
    }
    
    return self;
}

//- (void) layoutSubviews {
//    [super layoutSubviews];
//    self.contentView.frame = CGRectMake(10.0, 10.0, [UIScreen mainScreen].bounds.size.width - 20.0, self.frame.size.height - 20.0);
//    _textLabel.frame = CGRectMake(10.0, 10.0, self.contentView.frame.size.width - 110.0, 40.0);
//}

- (void)setCity:(City *)city {
    _city = city;
    _textLabel.text = _city.name;
}

- (void)setAirport:(Airport *)airport {
    _airport = airport;
    _textLabel.text = _airport.name;
}

@end
