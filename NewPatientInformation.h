//
//  NewPatientInformation.h
//  Capstone2
//
//  Created by Johnathan Cornella on 10/18/15.
//  Copyright © 2015 Johnathan Cornella. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewPatientInformation : UITableViewController

//Properties connecting to storyboard for Patient Information View Controller
@property (strong, nonatomic) IBOutlet UITextField *firstName;
@property (strong, nonatomic) IBOutlet UITextField *lastName;
@property (strong, nonatomic) IBOutlet UITextField *medicalID;
@property (strong, nonatomic) IBOutlet UITextField *patientEmail;
@property (strong, nonatomic) IBOutlet UITextField *patientPhoneNumber;
@property (strong, nonatomic) IBOutlet UITextField *dateofBirth;
@property (strong, nonatomic) IBOutlet UITextField *doctorName;
@property (strong, nonatomic) IBOutlet UITextField *doctorEmail;
@property (strong, nonatomic) IBOutlet UITextView *patientMessageText;
//Button to Save Data Entered to Core Data
- (IBAction)saveData:(id)sender;

//Previous search feature is no longer required. 


@end
