//
//  AppData.h
//  Capstone2
//
//  Created by Johnathan Cornella on 9/25/15.
//  Copyright (c) 2015 Johnathan Cornella. All rights reserved.
//

#ifndef Capstone2_AppData_h
#define Capstone2_AppData_h

#import "RFduinoDelegate.h"
#import "RFduino.h"
#import "CorePlot-CocoaTouch.h"

@interface AppData : NSObject
{

}


@property (strong,nonatomic) NSMutableArray *co2ValueArray;
@property (nonatomic) float co2value;


@end

#endif
