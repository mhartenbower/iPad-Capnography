//
//  Person.h
//  CoreData
//
//  Created by Matt Hartenbower on 9/29/15.
//  Copyright (c) 2015 Matt Hartenbower. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Co2Value;

@interface Person : NSManagedObject

@property (nonatomic, retain) NSString * dateOfBirth;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * medicalID;
@property (nonatomic, retain) NSSet *hasA;
@end

@interface Person (CoreDataGeneratedAccessors)

- (void)addHasAObject:(Co2Value *)value;
- (void)removeHasAObject:(Co2Value *)value;
- (void)addHasA:(NSSet *)values;
- (void)removeHasA:(NSSet *)values;

@end
