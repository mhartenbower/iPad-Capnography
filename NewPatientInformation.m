//
//  NewPatientInformation.m
//  Capstone2
//
//  Created by Johnathan Cornella on 10/18/15.
//  Copyright © 2015 Johnathan Cornella. All rights reserved.
//

#import "NewPatientInformation.h"

@implementation NewPatientInformation

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveData:(id)sender {
    //Code to Save Values based on User and Device Input
    
    AppDelegate *appDelegate =[[UIApplication sharedApplication] delegate];
    NSError *error;
    
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    
    
    NSManagedObject *newPerson;
    newPerson = [NSEntityDescription
                 insertNewObjectForEntityForName:@"Person"
                 inManagedObjectContext:context];
    
    //Create the custom objects NSManaged Objects that are enititys in the Data Model. Entities for CO2 value and Person.
    
    
    //Set the values for each of these using whatever text is put into the view controller.
    
    [newPerson setValue: _firstName.text forKey:@"firstName"];
    [newPerson setValue: _lastName.text forKey:@"lastName"];
    [newPerson setValue: _dateofBirth.text forKey:@"dateOfBirth"];
    [newPerson setValue: _medicalID.text forKey:@"medicalID"];
    [newPerson setValue: _patientEmail.text forKey:@"email"];
    [newPerson setValue: _patientPhoneNumber.text forKey:@"phoneNumber"];
    [newPerson setValue: _doctorEmail.text forKey:@"doctorEmail"];
    [newPerson setValue: _doctorName.text forKey:@"doctorName"];


    

    
    //Use key value coding to set the values to Core Data
    
    
    _firstName.text = @"";
    _lastName.text = @"";
    _dateofBirth.text = @"";
    _medicalID.text = @"";
    _patientEmail.text = @"";
    _patientPhoneNumber.text = @"";
    _doctorEmail.text = @"";
    _doctorName.text = @"";
    
    
    
    [newPerson.managedObjectContext save:&error];
}
@end
