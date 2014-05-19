//
//  BTClosestTableViewController.m
//  RestTest
//
//  Created by Bogdan Tudosie on 03/05/14.
//  Copyright (c) 2014 Bogdan Tudosie. All rights reserved.
//

#import "BTClosestTableViewController.h"
#import "BTMainViewController.h"
#import "BTAppDelegate.h"
#import "BTCompleteOrderViewController.h"

@interface BTClosestTableViewController ()


@end

@implementation BTClosestTableViewController

@synthesize closestLocations, locationManager, serviceURL, sessionKey, latitude, longitude;

- (void) fetchLocations
{
    // create the AF Networking connection then post latitude and longitude to the webservice, then update
    // the local array should location change.
    // set up AFNetworking, connect and fetch the locations.
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:self.serviceURL]];
    // set up object serializer and content types accepted as a response
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    NSDictionary *requestParameters = @{@"client_uid": @"3232", @"session_key": self.sessionKey, @"lat":[self.latitude stringValue], @"lon":[self.longitude stringValue] };
    
    // initialize a new array then add objects to it.
    NSMutableArray *locationsList = [[NSMutableArray alloc] init];
    
    [manager POST:@"" parameters:requestParameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // Process Response Object
        NSDictionary *response = (NSDictionary *) responseObject;
        // get the result, if it's null no point in going on just display an Alert View
        NSNumber *resultState = [responseObject objectForKey:@"result"];
        if ([resultState integerValue] == 0) {
            // something happened, display an error message
            UIAlertView *warningView = [[UIAlertView alloc] initWithTitle:@"No nearby locations" message:[response objectForKey:@"errorMessage"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [warningView show];
        }
        else if([resultState integerValue] == 1) {
            // we got an OK response, process the Dictionary data and return the array of objects.
            NSDictionary *locationsOutput = [response objectForKey:@"output"];
            
            for (NSString* key in locationsOutput) {
                [locationsList addObject:[locationsOutput objectForKey:key]];
                //NSLog(@"Value is: %@", [locationsOutput objectForKey:key]);
                
            }
            //NSLog(@"Locations added %i ", [locationsList count]);
            self.closestLocations = [locationsList mutableCopy];
            [self.tableView reloadData];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // Handle Error
        UIAlertView *httpErrorView = [[UIAlertView alloc] initWithTitle:@"Request error" message:@"A service request error occurred. Please try again later" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [httpErrorView show];
    }];

    
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    if([self.parentViewController  isKindOfClass:[BTMainViewController class]])
    {
        BTMainViewController *parent = (BTMainViewController *)self.parentViewController;
        self.sessionKey = parent.session;
        NSLog(@"URL is %@ ", self.sessionKey);
    }
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    
    // also set the URL
    self.serviceURL = [apiURL stringByAppendingString:@"/get_employee_closestlocations"];
    
    // set tableview delegate and data source
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
   
    // adjust for EdgeInset with navigation bar.
    self.tableView.contentInset = UIEdgeInsetsMake(64.0f, 0.0f, 0.0f, 0.0f);

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CLLocation Manager Delegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    [locationManager stopUpdatingLocation];
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *currentLocation = (CLLocation *)[locations lastObject];
    [locationManager stopUpdatingLocation];
    
    if(currentLocation != nil)
    {
        [self setLongitude:[NSNumber numberWithDouble: currentLocation.coordinate.longitude]];
        [self setLatitude:[NSNumber numberWithDouble: currentLocation.coordinate.latitude]];
        
        NSLog(@"Latitude: %f", [self.latitude floatValue]);
        NSLog(@"Longitude: %f", [self.longitude floatValue]);
    }
    [self fetchLocations];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [closestLocations count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ClosestCell" forIndexPath:indexPath];
    
    // Configure the cell...
    // title is the location's name, detail is represented by full address and distance
    cell.textLabel.text = [[closestLocations objectAtIndex:indexPath.row] objectForKey:@"locationname"];
    NSString *address = [[closestLocations objectAtIndex:indexPath.row] objectForKey:@"street_address"];
    NSString *distance = [[closestLocations objectAtIndex:indexPath.row] objectForKey:@"distance"];
    NSString *detailText = [address stringByAppendingString:distance];
    cell.detailTextLabel.text = detailText;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"closestPay" sender:self];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"closestPay"]) {
        BTCompleteOrderViewController *destination = [segue destinationViewController];
        
        NSDictionary *location = [closestLocations objectAtIndex:self.tableView.indexPathForSelectedRow.row];
        NSString *locationName = [location objectForKey:@"locationname"];
        NSString *address = [location objectForKey:@"street_address"];
        NSDictionary *values = [location objectForKey:@"agreedPrice"];
        NSArray *accepted = [location objectForKey:@"accepted_vouchers"];
        
        destination.name = locationName;
        destination.address = address;
        destination.values = values;
        destination.acceptedVouchers = accepted;
    }
}

@end
