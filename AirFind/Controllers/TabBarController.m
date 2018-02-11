//
//  TabBarController.m
//  AirFind
//
//  Created by Артем Полушин on 17.01.2018.
//  Copyright © 2018 Артем Полушин. All rights reserved.
//

#import "TabBarController.h"
#import "MainViewController.h"
#import "MapViewController.h"
#import "TicketsViewController.h"
#import "NSString+Localize.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (instancetype)init {
    if (self) {
        self.viewControllers = [self createViewControllers];
        self.tabBar.tintColor = [UIColor blackColor];
    }
    return self;
}

- (NSArray<UIViewController *> *)createViewControllers {
    NSMutableArray<UIViewController *> *controllers = [NSMutableArray new];
    MainViewController *mainViewController = [[MainViewController alloc] init];
    mainViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle: [@"search_tab" localize] image: [UIImage imageNamed: @"search"] selectedImage: [UIImage imageNamed: @"search"]];
    UINavigationController *mainNavigationController = [[UINavigationController alloc] initWithRootViewController: mainViewController];
    [controllers addObject: mainNavigationController];
    
    MapViewController *mapViewController = [[MapViewController alloc] init];
    mapViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle: [@"map_tab" localize] image: [UIImage imageNamed: @"map"] selectedImage: [UIImage imageNamed: @"map"]];
    UINavigationController *mapNavigationController = [[UINavigationController alloc] initWithRootViewController: mapViewController];
    [controllers addObject: mapNavigationController];
    
    TicketsViewController *favoriteViewController = [[TicketsViewController alloc] initFavoriteTicketsController];
    favoriteViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle: [@"favorites_tab" localize] image: [UIImage imageNamed: @"favorite"] selectedImage: [UIImage imageNamed: @"favorite"]];
    UINavigationController *favoriteNavigationController = [[UINavigationController alloc] initWithRootViewController: favoriteViewController];
    [controllers addObject: favoriteNavigationController];
    return controllers;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
