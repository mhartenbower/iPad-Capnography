//
//  ViewController.m
//  CoreData
//
//  Created by Matt Hartenbower on 9/12/15.
//  Copyright (c) 2015 Matt Hartenbower. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _co2ValueArray=[[NSMutableArray alloc] init];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveData:(id)sender {
    AppDelegate *appDelegate =[[UIApplication sharedApplication] delegate];
    NSError *error;

    //Bug Fix John Not sure if Correct
    
    
    
    NSManagedObjectContext *context =
    [appDelegate managedObjectContext];
     
    
    
    //The following line of code is the bugfix. Tell me if its correct.
    
   // NSManagedObjectContext* context = ((AppDelegate*)[[UIApplication sharedApplication] delegate]). managedObjectContext;
    
    //Added Code ends here
    
    //Got this code from here:http://stackoverflow.com/questions/16186838/cant-connect-my-managedobjectcontext-from-my-view-to-my-delegate
    
    
    NSManagedObject *newPerson;
    newPerson = [NSEntityDescription
                  insertNewObjectForEntityForName:@"Person"
                  inManagedObjectContext:context];
    
    NSManagedObject *newCo2Value;
    newCo2Value = [NSEntityDescription
                  insertNewObjectForEntityForName:@"Co2Value"
                  inManagedObjectContext:context];
    
    [newPerson setValue: _firstName.text forKey:@"firstName"];
    [newPerson setValue: _lastName.text forKey:@"lastName"];
    [newPerson setValue: _dateOfBirth.text forKey:@"dateOfBirth"];
    [newPerson setValue: _medicalID.text forKey:@"medicalID"];

    _firstName.text = @"";
    _lastName.text = @"";
    _dateOfBirth.text = @"";
    _medicalID.text = @"";

    [newCo2Value setValue: [NSNumber numberWithFloat:22] forKey:@"co2Value"];
    
    [newPerson setValue:[NSSet setWithObject:newCo2Value] forKey:@"hasA"];
    
    [newPerson.managedObjectContext save:&error];

    [newCo2Value setValue: [NSNumber numberWithFloat:25] forKey:@"co2Value"];
    
    [newPerson setValue:[NSSet setWithObject:newCo2Value] forKey:@"hasA"];
    
    [newPerson.managedObjectContext save:&error];


}

- (IBAction)search:(id)sender {
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context =
    [appDelegate managedObjectContext];
    
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
    
    for (id item in co2Values) {
        matches = item;
        NSNumber *floatNumber = [matches valueForKey:@"co2Value"];
        float temp = [floatNumber floatValue];
        _Co2Value.text = [_Co2Value.text stringByAppendingString:(
                        [NSString stringWithFormat:@"%f", temp])];
    }
    
    
}
@end
