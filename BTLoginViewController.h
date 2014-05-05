//
//  BTLoginViewController.h
//  RestTest
//
//  Created by Bogdan Tudosie on 02/05/14.
//  Copyright (c) 2014 Bogdan Tudosie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BTLoginViewController : UIViewController <UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UITextField *textUserName;
@property (weak, nonatomic) IBOutlet UITextField *textPassword;
@property (weak, nonatomic) IBOutlet UIPickerView *pickCountry;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
@property (weak, nonatomic) NSDictionary *response;
@property (weak, nonatomic) NSString *sessionKey;

// actions
- (IBAction)login:(id)sender;

@end
