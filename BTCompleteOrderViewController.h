//
//  BTCompleteOrderViewController.h
//  RestTest
//
//  Created by Bogdan Tudosie on 03/05/14.
//  Copyright (c) 2014 Bogdan Tudosie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BTCompleteOrderViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *locationName;
@property (weak, nonatomic) IBOutlet UILabel *orderValue;
@property (weak, nonatomic) IBOutlet UILabel *locationAddress;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *userCompany;
@property (weak, nonatomic) IBOutlet UIPickerView *voucherTypesPicker;


// string properties for passed values.

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *address;
@property (copy, nonatomic) NSDictionary *values;
@property (copy, nonatomic) NSString *user;
@property (copy, nonatomic) NSString *company;

// dictionary for accepted types
@property (strong, nonatomic) NSArray *acceptedVouchers;

@end
