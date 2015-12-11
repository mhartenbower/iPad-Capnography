//
//  ViewController.h
//  Capstone2
//
//  Created by Johnathan Cornella on 2/6/15.
//  Copyright (c) 2015 Johnathan Cornella. All rights reserved.
//

#import "RFduinoDelegate.h"
#import "RFduino.h"
#import <UIKit/UIKit.h>
#import "AppData.h"
#import "CorePlot-CocoaTouch.h"
#import "NSNumberExtensions.h"
#import "AppDelegate.h"
#import <DropboxSDK/DropboxSDK.h>


//Import the necessary frameworks

@interface AppViewController : UIViewController <RFduinoDelegate, CPTPlotDataSource, DBRestClientDelegate>

{
    CPTXYGraph *graph1;
    CPTXYGraph *graph2;
    AppData *appData;
    BOOL hasRun;
}


@property (strong, nonatomic) UIWindow *window;
@property (weak, nonatomic) IBOutlet UILabel *Label1;
@property (weak, nonatomic) IBOutlet UILabel *Label2;
@property (weak, nonatomic) IBOutlet CPTGraphHostingView *graphView1;
@property (weak, nonatomic) IBOutlet CPTGraphHostingView *graphView2;
@property(strong, nonatomic) NSMutableArray *co2ValueArray;
@property(nonatomic, assign) BOOL hasRun;
@property(nonatomic, strong) RFduino *rfduino;
@property (strong, nonatomic) IBOutlet UISegmentedControl *PlayControl;
@property (nonatomic, strong) DBRestClient *restClient;
- (IBAction)PlayControlAction:(id)sender;


@end



