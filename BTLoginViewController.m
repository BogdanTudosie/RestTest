//
//  BTLoginViewController.m
//  RestTest
//
//  Created by Bogdan Tudosie on 02/05/14.
//  Copyright (c) 2014 Bogdan Tudosie. All rights reserved.
//

#import "BTLoginViewController.h"
#import "BTAppDelegate.h"
#import "BTMainViewController.h"

@interface BTLoginViewController ()

@property (strong, nonatomic) UIGestureRecognizer *tapper;

@end

@implementation BTLoginViewController

@synthesize textPassword, textUserName, pickCountry, btnLogin, response = _response, sessionKey ,tapper;

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
    self.textUserName.delegate = self;
    self.textPassword.delegate = self;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Text Field Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([[segue identifier] isEqualToString:@"loginSegue"])
    {
        BTMainViewController *destination = [segue destinationViewController];
        [destination setSession:self.sessionKey];
    }
}

#pragma mark - Custom methods

- (IBAction)login:(id)sender {
    
    // take the data from the form field including language.
    NSString *userName = self.textUserName.text;
    NSString *password = self.textPassword.text;
    NSString *loginURL = [apiURL stringByAppendingString:@"/login"];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:loginURL]];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    NSDictionary *requestParameters = @{@"client_uid": @"3232", @"username":userName, @"password":password};
    
    // now connect and POST the parameters
    [manager POST:@"" parameters:requestParameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // Process Response Object
        _response = (NSDictionary*) responseObject;
        // get the result, if it's null no point in going on just display an Alert View
        NSNumber *resultState = [responseObject objectForKey:@"result"];
        if ([resultState integerValue] == 0) {
            UIAlertView *loginError = [[UIAlertView alloc] initWithTitle:@"Logon error" message:@"Incorrect username or password!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [loginError show];
        }
        else if([resultState integerValue] == 1)
        {
            NSDictionary *sessionInfo = [responseObject objectForKey:@"output"];
            NSString *sessionID = [sessionInfo objectForKey:@"session_key"];
            sessionKey = sessionID;
            
            [self performSegueWithIdentifier:@"loginSegue" sender:self];
        }
       
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // Handle Error
        UIAlertView *info = [[UIAlertView alloc] initWithTitle:@"Error" message:@"An error occurred." delegate:self cancelButtonTitle:@"Close" otherButtonTitles:@"OK", nil];
        [info show];
        NSLog(@"Error: %@", error);
    }];
}

@end
