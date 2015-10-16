//
//  PatientInformationViewController.h
//  Capstone2
//
//  Created by Johnathan Cornella on 9/25/15.
//  Copyright (c) 2015 Johnathan Cornella. All rights reserved.
//
#import "Person.h"
#import "AppDelegate.h"
#import <UIKit/UIKit.h>
#import "AppViewController.h"
#import <CoreData/CoreData.h>

@interface PatientInformationViewController : UIViewController
{
    Person *person;
}

@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UITextField *dateOfBirth;
@property (weak, nonatomic) IBOutlet UITextField *medicalID;
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UITextField *searchFirstName;
@property (weak, nonatomic) NSMutableArray *co2ValueArray;
@property (weak, nonatomic) IBOutlet UILabel *Co2Value;

- (IBAction)saveData:(id)sender;
- (IBAction)search:(id)sender;






@end
