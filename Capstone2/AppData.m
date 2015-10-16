//
//  AppData.m
//  Capstone2
//
//  Created by Johnathan Cornella on 9/25/15.
//  Copyright (c) 2015 Johnathan Cornella. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppData.h"

@interface AppData ()

@end

@implementation AppData

@synthesize co2ValueArray = _co2ValueArray;
@synthesize co2value = _co2value;

- (id)init {
    if (self = [super init]) {
        _co2ValueArray=[[NSMutableArray alloc] init];
    }
    return self;
}


@end