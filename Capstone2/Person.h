//
//  Person.h
//  Capstone2
//
//  Created by John Appleseed on 9/30/15.
//  Copyright © 2015 Johnathan Cornella. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Co2Value;
@interface Person : NSManagedObject

//Generic class that implements all the basic behavior required of core data model object.

//Create 

@property (nonatomic, retain) NSString * dateOfBirth;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * medicalID;
@property (nonatomic, retain) NSSet *hasA;



//Provide MetaData about the object such as the name of the entity that it represents, and its attributed and relationships.

@end

@interface Person (CoreDataGeneratedAccessors)

- (void)addHasAObject:(Co2Value *)value;
- (void)removeHasAObject:(Co2Value *)value;
- (void)addHasA:(NSSet *)values;
- (void)removeHasA:(NSSet *)values;

@end
