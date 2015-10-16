//
//  Co2Value.h
//  Capstone2
//
//  Created by John Appleseed on 9/30/15.
//  Copyright © 2015 Johnathan Cornella. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Person;

@interface Co2Value : NSManagedObject

@property (nonatomic, retain) NSNumber * co2Value;
@property (nonatomic, retain) NSDate * timeStamp;
@property (nonatomic, retain) Person *attributedToA;


@end
