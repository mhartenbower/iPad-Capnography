//
//  ViewController.h
//  CoreData
//
//  Created by Matt Hartenbower on 9/12/15.
//  Copyright (c) 2015 Matt Hartenbower. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Person.h"


@interface ViewController : UIViewController
{
    Person *person;
}


@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UITextField *dateOfBirth;
@property (weak, nonatomic) IBOutlet UITextField *medicalID;
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UITextField *searchFirstName;
@property(strong, nonatomic) NSMutableArray *co2ValueArray;
@property (weak, nonatomic) IBOutlet UILabel *Co2Value;

- (IBAction)saveData:(id)sender;
- (IBAction)search:(id)sender;


@end

