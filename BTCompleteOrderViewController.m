//
//  BTCompleteOrderViewController.m
//  RestTest
//
//  Created by Bogdan Tudosie on 03/05/14.
//  Copyright (c) 2014 Bogdan Tudosie. All rights reserved.
//

#import "BTCompleteOrderViewController.h"

@interface BTCompleteOrderViewController ()

@end

@implementation BTCompleteOrderViewController

@synthesize userCompany, username, locationAddress, locationName, orderValue, user, name, address, values, company, acceptedVouchers;

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
    
    // set the delegate and data source for the uipickerview
    self.voucherTypesPicker.delegate = self;
    self.voucherTypesPicker.dataSource = self;
    // Do any additional setup after loading the view.
    self.locationName.text = self.name;
    self.locationAddress.text = self.address;
    self.orderValue.text = [self.values objectForKey:@"agreementmeal"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [acceptedVouchers count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self.acceptedVouchers objectAtIndex:row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    self.orderValue.text = [self.values objectForKey:[self.acceptedVouchers objectAtIndex:row]];
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

@end
