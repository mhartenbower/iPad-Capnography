//
//  RFduinoObject.h
//  Capstone2
//
//  Created by Johnathan Cornella on 9/25/15.
//  Copyright (c) 2015 Johnathan Cornella. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RFduino.h"


@interface RFduinoObject : NSObject

@property (nonatomic, retain)RFduino *rfduino;

+ (id)sharedManager;

@end
