//
//  Co2Value.h
//  CoreData
//
//  Created by Matt Hartenbower on 9/29/15.
//  Copyright (c) 2015 Matt Hartenbower. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Person;

@interface Co2Value : NSManagedObject

@property (nonatomic, retain) NSNumber * co2Value;
@property (nonatomic, retain) NSDate * timeStamp;
@property (nonatomic, retain) Person *attributedToA;

@end
