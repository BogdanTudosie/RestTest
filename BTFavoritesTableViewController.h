//
//  BTFavoritesTableViewController.h
//  RestTest
//
//  Created by Bogdan Tudosie on 03/05/14.
//  Copyright (c) 2014 Bogdan Tudosie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BTFavoritesTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (copy, nonatomic) NSString *sessionKey;
@property (strong, nonatomic) NSString *serviceURL;
@property (strong, nonatomic) NSMutableArray *locations; 

@end
