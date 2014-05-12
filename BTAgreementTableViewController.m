//
//  BTAgreementTableViewController.m
//  RestTest
//
//  Created by Bogdan Tudosie on 03/05/14.
//  Copyright (c) 2014 Bogdan Tudosie. All rights reserved.
//

#import "BTAgreementTableViewController.h"
#import "BTMainViewController.h"
#import "BTAppDelegate.h"

@interface BTAgreementTableViewController ()

@end

@implementation BTAgreementTableViewController

@synthesize sessionKey, locations, serviceURL;


/*
 * Method: fetchLocations
 * Parameters: none
 * Returns: Array of Dictionaries containing locations.
 */
- (void) fetchLocations
{
    // set up AFNetworking, connect and fetch the locations.
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:self.serviceURL]];
    // set up object serializer and content types accepted as a response
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    NSDictionary *parameters = @{@"client_uid": @"3232", @"session_key": self.sessionKey};
    
    // initialize a new array then add objects to it.
    NSMutableArray *locationsList = [[NSMutableArray alloc] init];
    
    [manager POST:@"" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // Process Response Object
        NSDictionary *response = (NSDictionary *) responseObject;
        // get the result, if it's null no point in going on just display an Alert View
        NSNumber *resultState = [responseObject objectForKey:@"result"];
        if ([resultState integerValue] == 0) {
            // something happened, display an error message
        }
        else if([resultState integerValue] == 1) {
            // we got an OK response, process the Dictionary data and return the array of objects.
            NSDictionary *locationsOutput = [response objectForKey:@"output"];
            
            for (NSString* key in locationsOutput) {
                [locationsList addObject:[locationsOutput objectForKey:key]];
                NSLog(@"Value is: %@", [locationsOutput objectForKey:key]);
                
            }
            //NSLog(@"Locations added %i ", [locationsList count]);
            self.locations = [locationsList mutableCopy];
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
    
    // also set the URL
    self.serviceURL = [apiURL stringByAppendingString:@"/get_employee_agreementlocations"];
    // fetch locations
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.contentInset = UIEdgeInsetsMake(64.0f, 0.0f, 0.0f, 0.0f);
    [self fetchLocations];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [locations count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AgreementCell" forIndexPath:indexPath];
    
    cell.textLabel.text = [[locations objectAtIndex:indexPath.row] objectForKey:@"locationname"];
    cell.detailTextLabel.text = [[locations objectAtIndex:indexPath.row] objectForKey:@"street_address"];
    
    return cell;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
