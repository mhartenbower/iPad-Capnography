//
//  PatientInformationViewController.m
//  Capstone2
//
//  Created by Johnathan Cornella on 9/25/15.
//  Copyright (c) 2015 Johnathan Cornella. All rights reserved.
//

#import "PatientInformationViewController.h"


@interface PatientInformationViewController ()

@end

@implementation PatientInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   //  _co2ValueArray=[[NSMutableArray alloc] init];
    
  

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
    [newPerson setValue: _dateOfBirth.text forKey:@"dateOfBirth"];
    [newPerson setValue: _medicalID.text forKey:@"medicalID"];
    
    //Use key value coding to set the values to Core Data
    
    
    _firstName.text = @"";
    _lastName.text = @"";
    _dateOfBirth.text = @"";
    _medicalID.text = @"";
    
    
    [newPerson.managedObjectContext save:&error];
    
}

- (IBAction)search:(id)sender {
    
    
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    
    NSEntityDescription *entityDesc =
    [NSEntityDescription entityForName:@"Person"
                inManagedObjectContext:context];
    
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    [request setEntity:entityDesc];
    
    
    NSPredicate *pred =
    [NSPredicate predicateWithFormat:@"(firstName = %@)",
     _searchFirstName.text];
    [request setPredicate:pred];
    NSManagedObject *matches = nil;
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request
                                              error:&error];
    
    if ([objects count] == 0) {
        _status.text = @"No matches";
    } else {
        matches = objects[0];
        _firstName.text = [matches valueForKey:@"firstName"];
        _lastName.text = [matches valueForKey:@"lastName"];
        _dateOfBirth.text = [matches valueForKey:@"dateOfBirth"];
        _medicalID.text = [matches valueForKey:@"medicalID"];
        _status.text = [NSString stringWithFormat:
                        @"%lu matches found", (unsigned long)[objects count]];
    }
    
    person = [objects objectAtIndex:(0)];
    NSSet *co2Values = person.hasA;
    
    /*
    for (id item in co2Values) {
        matches = item;
        NSNumber *floatNumber = [matches valueForKey:@"co2Value"];
        float temp = [floatNumber floatValue];
        _Co2Value.text = [_Co2Value.text stringByAppendingString:(
                                                                  [NSString stringWithFormat:@"%f", temp])];
    }
     */
    
    
    //check
    
}
@end
