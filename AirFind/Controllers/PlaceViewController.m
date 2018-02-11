//
//  PlaceViewController.m
//  AirFind
//
//  Created by Артем Полушин on 11.01.2018.
//  Copyright © 2018 Артем Полушин. All rights reserved.
//

#import "PlaceViewController.h"
#import "CityCollectionViewCell.h"
#import "NSString+Localize.h"

#define ReuseIdentifier @"CellIdentifier"

@interface PlaceViewController ()
@property (nonatomic) PlaceType placeType;
@property (nonatomic) UICollectionView *collectionView;
@property (nonatomic) UISegmentedControl *segmentedControl;
@property (nonatomic) NSArray *currentArray;
@property (nonatomic) NSArray *searchArray;
@property (nonatomic) UISearchController *searchController;
@end

@implementation PlaceViewController

- (instancetype) initWithType:(PlaceType)type {
    self = [super init];
    
    if(self) {
        _placeType = type;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 2.0;
    layout.minimumInteritemSpacing = 2.0;
    layout.itemSize = CGSizeMake(self.view.bounds.size.width/4 - 2, self.view.bounds.size.width/4 - 2);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    _searchController = [[UISearchController alloc] initWithSearchResultsController: nil];
    _searchController.dimsBackgroundDuringPresentation = NO;
    _searchController.searchResultsUpdater = self;
    _searchArray = [NSArray new];
    
    _collectionView = [[UICollectionView alloc] initWithFrame: self.view.bounds collectionViewLayout: layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[CityCollectionViewCell class] forCellWithReuseIdentifier: ReuseIdentifier];
    
    self.navigationItem.searchController = _searchController;

    
    [self.view addSubview: _collectionView];
    
    _segmentedControl = [[UISegmentedControl alloc] initWithItems: @[[@"cities" localize], [@"airports" localize]]];
    [_segmentedControl addTarget: self action: @selector(changeSource) forControlEvents: UIControlEventValueChanged];
    _segmentedControl.tintColor = [UIColor blackColor];
    self.navigationItem.titleView = _segmentedControl;
    _segmentedControl.selectedSegmentIndex = 0;
    
    [self changeSource];
    
    if (_placeType == PlaceTypeArrival) {
        self.title = [@"to" localize];
    } else if (_placeType == PlaceTypeDeparture) {
        self.title = [@"from" localize];
    }
}

- (void)changeSource {
    switch (_segmentedControl.selectedSegmentIndex) {
        case 0:
            _currentArray = [[DataManager sharedInstance] cities];
            break;
        case 1:
            _currentArray = [[DataManager sharedInstance] airports];
        default:
            break;
    }
    [self.collectionView reloadData];
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    if (searchController.searchBar.text) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat: @"SELF.name CONTAINS[cd] %@", searchController.searchBar.text];
        _searchArray = [_currentArray filteredArrayUsingPredicate: predicate];
        [_collectionView reloadData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (_searchController.isActive && [_searchArray count] > 0) {
        return [_searchArray count];
    }
    return [_currentArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

     CityCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: ReuseIdentifier forIndexPath:indexPath];
    _collectionView.backgroundColor = [UIColor lightGrayColor];
    if(_segmentedControl.selectedSegmentIndex == 0) {
        City *city = (_searchController.isActive && [_searchArray count] > 0) ? [_searchArray objectAtIndex: indexPath.row] : [_currentArray objectAtIndex: indexPath.row];
        [cell setCity: city];
    } else if (_segmentedControl.selectedSegmentIndex == 1) {
        Airport *airport = (_searchController.isActive && [_searchArray count] > 0) ? [_searchArray objectAtIndex: indexPath.row] : [_currentArray objectAtIndex: indexPath.row];
        [cell setAirport: airport];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    DataSourceType dataType = ((int)_segmentedControl.selectedSegmentIndex) + 1;
    
    if (_searchController.isActive && [_searchArray count] > 0) {
        [self.delegate selectPlace:[_searchArray objectAtIndex: indexPath.row] withType: _placeType andDataType: dataType];
        _searchController.active = NO;
    } else {
        [self.delegate selectPlace:[_currentArray objectAtIndex: indexPath.row] withType: _placeType andDataType: dataType];
    }
    [self.navigationController popViewControllerAnimated: YES];
}

@end
