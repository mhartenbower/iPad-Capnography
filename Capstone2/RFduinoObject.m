//
//  RFduinoObject.m
//  Capstone2
//
//  Created by Johnathan Cornella on 9/25/15.
//  Copyright (c) 2015 Johnathan Cornella. All rights reserved.
//

#import "RFduinoObject.h"

@implementation RFduinoObject

@synthesize rfduino;

+(id)sharedManager {
    static RFduinoObject *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

-(id)init {
    if (self = [super init]) {
        rfduino = [[RFduino alloc] init];
    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}
@end
