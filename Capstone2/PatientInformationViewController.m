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
