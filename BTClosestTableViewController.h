//
//  BTClosestTableViewController.h
//  RestTest
//
//  Created by Bogdan Tudosie on 03/05/14.
//  Copyright (c) 2014 Bogdan Tudosie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BTClosestTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate>

@property (copy, nonatomic) NSString *sessionKey;
@property (strong, nonatomic) NSString *serviceURL;
@property (strong, nonatomic) NSMutableArray *closestLocations;
@property (strong, nonatomic) CLLocationManager *locationManager;

// user position, used in this view.
@property (strong, nonatomic) NSNumber *latitude;
@property (strong, nonatomic) NSNumber *longitude;

@end
