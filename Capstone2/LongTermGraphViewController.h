//
//  LongTermGraphViewController.h
//  Capstone2
//
//  Created by Johnathan Cornella on 9/25/15.
//  Copyright (c) 2015 Johnathan Cornella. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "CorePlot-CocoaTouch.h"
#import "NSNumberExtensions.h"
#import "AppDelegate.h"



@interface LongTermGraphViewController : UIViewController <CPTPlotDataSource>

{
    CPTXYGraph *graph3;
    NSManagedObjectContext *context;
    
}

@property (strong, nonatomic) IBOutlet CPTGraphHostingView *graphView3;
@property (strong, nonatomic) IBOutlet UISegmentedControl *timePeriodSelector;
@property (strong, nonatomic) NSMutableArray *coreDataArray;

- (IBAction)timePeriodAction:(id)sender;
- (IBAction)saveGraphImage:(id)sender;






@end
