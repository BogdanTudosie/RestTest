//
//  BTRestViewController.m
//  RestTest
//
//  Created by Bogdan Tudosie on 28/04/14.
//  Copyright (c) 2014 Bogdan Tudosie. All rights reserved.
//

#import "BTMainViewController.h"
#import "BTAppDelegate.h"
#import "BTFavoritesTableViewController.h"

@interface BTMainViewController ()

@end

@implementation BTMainViewController

// synthesize properties
@synthesize session, urlToUse;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBarController.delegate = self;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

// Tab Bar Controller Delegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    switch(tabBarController.selectedIndex)
    {
        case 0:
        {
            // History
            break;
        }
            
        case 1:
        {
            // Favorite locations
            break;
        }

        case 2:
            // Closest locations
            break;
        case 3:
            // Agreement locations
            break;
    }
}

@end
