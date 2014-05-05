//
//  BTRestViewController.h
//  RestTest
//
//  Created by Bogdan Tudosie on 28/04/14.
//  Copyright (c) 2014 Bogdan Tudosie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BTMainViewController : UITabBarController <UITabBarControllerDelegate>


@property (copy, nonatomic) NSString *session;
@property (copy, nonatomic) NSString *urlToUse;

@end
