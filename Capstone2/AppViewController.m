//
//  ViewController.m
//  Capstone2 Project Dream Team
//
//  Created by Johnathan Cornella on 2/6/15.
//  Copyright (c) 2015 Johnathan Cornella. All rights reserved.
//  Modified from code made by Mark Spano ASU
//  Assistance Provided by Sean Arnes


#import "AppViewController.h"
#import "ScanViewController.h"
#import "RFduinoManager.h"
#import "RFduinoObject.h"
#import "NSNumberExtensions.h"


@interface AppViewController ()
{
    RFduinoManager *rfduinoManager;
    bool wasScanning;
}

@end

@implementation AppViewController

@synthesize rfduino;
@synthesize hasRun;
@synthesize PlayControl;

- (void)viewDidLoad {
    [super viewDidLoad];
    RFduinoObject *newRFduino = [RFduinoObject sharedManager];
    rfduino = newRFduino.rfduino;
    // Do any additional setup after loading the view, typically from a nib.
    rfduino.delegate = self;
    appData =[[AppData alloc] init];
    
    
   //Initialize a graph with a Rectangular Frame
    
    graph1 = [[CPTXYGraph alloc] initWithFrame:CGRectZero];
    graph2 = [[CPTXYGraph alloc] initWithFrame:CGRectZero];
    
    
    CPTTheme *theme1 = [CPTTheme themeNamed:kCPTPlainWhiteTheme];
    [graph1 applyTheme:theme1];
    
    CPTTheme *theme2 = [CPTTheme themeNamed:kCPTPlainWhiteTheme];
    [graph2 applyTheme:theme2];
    
    
    //Define the graph theme. The theme that I will chose from this graph can be selected from the following choices:
    
    //kCPTDarkGradientTheme =Dark Grey Background and light grey lines
    
    //kCPTPlainBlackTheme =A Graph theme with black background and white lines. Current Setting
    
    //kCPTPlainWhiteTheme =A graph theme with white background and black lines
    
    //kCPTSlateTheme =A Graph theme with default colors that match the IOS navigation Bar
    
    //kCPTStocksTheme =Graph with gradient background and white lines. What I changed it from
    
    //[graph setFrame: [[self view] bounds]];
    
    //Set up the graph specifications.
    
    //Frame Setup for Graph 1
    
    graph1.frame                       = self.view.bounds;
    
    graph1.paddingRight                = 50.0f;
    graph1.paddingLeft                 = 50.0f;
    graph1.plotAreaFrame.masksToBorder = NO;
    graph1.plotAreaFrame.cornerRadius  = 0.0f;
    CPTMutableLineStyle *borderLineStyle1 = [CPTMutableLineStyle lineStyle];
    borderLineStyle1.lineColor           = [CPTColor blackColor];
    borderLineStyle1.lineWidth           = 2.0f;
    graph1.plotAreaFrame.borderLineStyle = borderLineStyle1;
    
    //Title Setup for Graph 1
    
    CPTMutableTextStyle*titleStyle1 = [CPTMutableTextStyle textStyle];
    titleStyle1.color = [CPTColor blackColor];
    titleStyle1.fontName =@"Helvetica-Bold";
    titleStyle1.fontSize = 16.0f;
    
    NSString *title1 = @"Capnogram CO2 (Parts Per Million)";
    graph1.title = title1;
    graph1.titleTextStyle = titleStyle1;
    graph1.titlePlotAreaFrameAnchor = CPTRectAnchorTop;
    graph1.titleDisplacement = CGPointMake(0.0f, -16.0f);
    
    
    //Set up the color of the title and the font name. Also determine the size of the font for the title.
    
    //Frame Setup for Graph 2
    
    graph2.frame                   =self.view.bounds;
    
    graph2.paddingRight =50.0f;
    graph2.paddingLeft =50.0f;
    graph2.plotAreaFrame.masksToBorder = NO;
    graph2.plotAreaFrame.cornerRadius = 0.0f;
    CPTMutableLineStyle *borderLineStyle2 = [CPTMutableLineStyle lineStyle];
    borderLineStyle2.lineColor = [CPTColor blackColor];
    borderLineStyle2.lineWidth = 2.0f;
    graph2.plotAreaFrame.borderLineStyle = borderLineStyle2;
    
    
    self.graphView1.hostedGraph = graph1;
    self.graphView2.hostedGraph = graph2;
    
    //Title Setup for Graph 2
    
    CPTMutableTextStyle*titleStyle2 = [CPTMutableTextStyle textStyle];
    titleStyle2.color = [CPTColor blackColor];
    titleStyle2.fontName =@"Helvetica-Bold";
    titleStyle2.fontSize = 16.0f;
    
    NSString *title2 = @"Capnogram CO2 (mmHG)";
    graph2.title = title2;
    graph2.titleTextStyle = titleStyle2;
    graph2.titlePlotAreaFrameAnchor = CPTRectAnchorTop;
    graph2.titleDisplacement = CGPointMake(0.0f, -16.0f);
    
    
    // Axes Setup for Graph 1
    
    CPTXYAxisSet *xyAxisSet1        = (id)graph1.axisSet;
    CPTXYAxis *xAxis1               = xyAxisSet1.xAxis;
    CPTMutableLineStyle *lineStyle1 = [xAxis1.axisLineStyle mutableCopy];
    lineStyle1.lineCap   = kCGLineCapButt;
    xAxis1.axisLineStyle = lineStyle1;
    xAxis1.labelingPolicy = CPTAxisLabelingPolicyAutomatic;
    //Sets the label policy for the X axis to automatic and lets the IPad choose the graph intervals. This will be between 0 and 30 because 30 is the current number of samples.
    
    CPTXYAxis *yAxis1 = xyAxisSet1.yAxis;
    yAxis1.axisLineStyle = nil;
    
    yAxis1.labelingPolicy = CPTAxisLabelingPolicyAutomatic;
    //Sets the label policy for the Y axis to automatic and lets the IPad choose the intervals for the graph. This will be between 0 and 5000 depending on PPM reading.
    
    //yAxis(CPTAxisTitle*)
    
    //Axes Setup for Graph 2
    
    CPTXYAxisSet *xyAxisSet2        = (id)graph2.axisSet;
    CPTXYAxis *xAxis2               = xyAxisSet2.xAxis;
    CPTMutableLineStyle *lineStyle2 = [xAxis2.axisLineStyle mutableCopy];
    lineStyle2.lineCap   = kCGLineCapButt;
    xAxis2.axisLineStyle = lineStyle2;
    xAxis2.labelingPolicy = CPTAxisLabelingPolicyAutomatic;
    //Sets the label policy for the X axis to automatic and lets the IPad choose the graph intervals. This will be between 0 and 30 because 30 is the current number of samples.
    
    CPTXYAxis *yAxis2 = xyAxisSet2.yAxis;
    yAxis2.axisLineStyle = nil;
    
    yAxis2.labelingPolicy = CPTAxisLabelingPolicyAutomatic;
    
    
    // Get the (default) plotspace from the graph so we can set its x/y ranges
    
    CPTXYPlotSpace *plotSpace1 = (CPTXYPlotSpace *) graph1.defaultPlotSpace;
    CPTXYPlotSpace *plotSpace2 = (CPTXYPlotSpace *) graph2.defaultPlotSpace;
    
    // Note that these CPTPlotRange are defined by START and LENGTH (not START and END) !!
    
    //Idea Currently is to set up on the Y axis the random number from the Aurdino. In the future this will be replaced by the value from the CO2 Sensor. The Y axis will for now be named random number but in the future I will change the name to "ET CO2 Percentage". The X axis will represent time and this value will come from the Aurduino.
    
    //Current Y axis random number has been set to range from 1 to 20. Will be replaced in future by actual CO2 value reported from Rfduino.
    //Current X axis is being used to report time value from 0 to 30 seconds. In future time range will be changed to specify a different ragne.
    
    
    //Set Ranges for X and Y of Graph 1
    
    //Had to Update Graph to Work with Core Data 2.0
    
    
    //[plotSpace1 setYRange: [CPTPlotRange plotRangeWithLocation:[NSNumber numberWithCGFloat:0]length:[NSNumber numberWithCGFloat:8000]]];
    
    //[plotSpace1 setXRange: [CPTPlotRange plotRangeWithLocation:[NSNumber numberWithCGFloat:0]length:[NSNumber numberWithCGFloat:30]]];
    
    plotSpace1.yRange = [CPTPlotRange plotRangeWithLocation:@0 length:@5000];
    
    plotSpace1.xRange = [CPTPlotRange plotRangeWithLocation:@0 length:@400];
    
    
    //Set Ranges for X and Y of Graph 2
    
    //[plotSpace2 setYRange: [CPTPlotRange plotRangeWithLocation:[NSNumber numberWithCGFloat:0]length:[NSNumber numberWithCGFloat:60]]];
    //[plotSpace2 setXRange: [CPTPlotRange plotRangeWithLocation:[NSNumber numberWithCGFloat:0]length:[NSNumber numberWithCGFloat:30]]];
    
    plotSpace2.yRange = [CPTPlotRange plotRangeWithLocation:@0 length: @60];
    
    plotSpace2.xRange = [CPTPlotRange plotRangeWithLocation:@0 length: @400];
    
    //John Updated based on further research and core plot documentation
    
    
    // Create the plot (we do not define actual x/y values yet, these will be supplied by the values from the Rfduino.)
    
    CPTScatterPlot* plot1 = [[CPTScatterPlot alloc] initWithFrame:CGRectZero];
    CPTScatterPlot* plot2 = [[CPTScatterPlot alloc] initWithFrame:CGRectZero];
    
    //plot.dataLineStyle.lineColor;
    
    //Chose the line style set the line width.
    
    CPTMutableLineStyle  *datalineStyle1 = [CPTMutableLineStyle lineStyle];
    datalineStyle1.lineColor = [CPTColor colorWithComponentRed:0.0f/255.0f green:153.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
    datalineStyle1.lineWidth = 3.0f;
    plot1.dataLineStyle = datalineStyle1;
    
    CPTMutableLineStyle  *datalineStyle2 = [CPTMutableLineStyle lineStyle];
    datalineStyle2.lineColor = [CPTColor colorWithComponentRed:0.0f/255.0f green:153.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
    datalineStyle2.lineWidth = 3.0f;
    plot2.dataLineStyle = datalineStyle2;
    
    // Let's keep it simple and let this class act as datasource (therefore we implemtn <CPTPlotDataSource>)
    
    plot1.dataSource = self;
    plot2.dataSource = self;
    
    // Finally, add the created plot to the default plot space of the CPTGraph object we created before
    
    [graph1 addPlot:plot1 toPlotSpace:graph1.defaultPlotSpace];
    [graph2 addPlot:plot2 toPlotSpace:graph2.defaultPlotSpace];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)disconnect:(id)sender
{
    NSLog(@"disconnect pressed");
    
    [rfduino disconnect];
}

- (void)didReceive:(NSData *)data
{
    //NSLog(@"ReceivedRX");
    
   
    int count = 0;
    //Define given CO2 Value
    float co2Value = dataFloat(data);
    appData.co2value = co2Value;
    //store co2Value into coredata here

    
    if(PlayControl.selectedSegmentIndex == 1)
    {
        if(count <= 200)
        {
        //This returns the date that we can add into core data
        NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
        [DateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
        NSString *date = [DateFormatter stringFromDate:[NSDate date]];
        
        //------------------Core data stuff

        AppDelegate *appDelegate =[[UIApplication sharedApplication] delegate];
        
        NSManagedObjectContext *context = [appDelegate managedObjectContext];
        NSError *error;
        
        NSManagedObject *newCo2Value;
        newCo2Value = [NSEntityDescription
                       insertNewObjectForEntityForName:@"Co2Value"
                       inManagedObjectContext:context];
        
        [newCo2Value setValue: date forKey:@"timeStamp"];
        [newCo2Value setValue: [NSNumber numberWithFloat:((co2Value/10)*0.00760)] forKey:@"co2Value"];
        
        [newCo2Value.managedObjectContext save:&error];
        }
        count ++;
    }
    
    //NSLog(@"CO2 PPM=%.2f", appData.co2value);
    
    //NSLog(@"CO2 mmHG=%.4f", appData.co2value*0.00760);
    
    
    //Creates a string called string 1. % signifies data type to be filled in later. float then comma. CO2 value is the float that will fill in %f. The .2 indicates the amount of decimal places of the float.
    
    
    NSString* string1 = [NSString stringWithFormat:@"%.2f PPM", appData.co2value/10];
    
    NSString* string2 = [NSString stringWithFormat:@"%.4f mmHg", appData.co2value*0.00760];
    
    //Sets up the label in the View Controller. Set the text of label 1 to string 1.
    
    [_Label1 setText:string1];
    [_Label2 setText:string2];
    

    //Convert the float to an NS Number. And add this to the CO2 Array.
    [appData.co2ValueArray addObject:[NSNumber numberWithFloat:appData.co2value/10]];
    
    //Reload the data and refresh the graph.
    
    [graph1 reloadData];
    [graph2 reloadData];
    //how to convert back from object to float = float value = [[_co2ValueArray lastObject] floatValue];
    
    
    
}





-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plotnumberOfRecords
{
    if(plotnumberOfRecords.graph == graph1)
    {
        if ([appData.co2ValueArray count] >= 400)
        {
            return 400;
        }
        else
        {
            return [appData.co2ValueArray count];
        }
    }
    else
    {
        if ([appData.co2ValueArray count] >= 400)
        {
            return 400;
        }
        else
        {
            return [appData.co2ValueArray count];
        }
    }
    //Number of Points that go on plot. Can be updated or changed in the future depending on the data.
}


-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
    
    
    if(plot.graph == graph1)
    {
        if(fieldEnum == CPTScatterPlotFieldX)
        {
            return [NSNumber numberWithUnsignedInteger:index];
        }
        else
        {
            NSUInteger length = [appData.co2ValueArray count];
            if (length > 400)
            {
                return [appData.co2ValueArray objectAtIndex:length-(400-index)];
            }
            else
            {
                return [appData.co2ValueArray objectAtIndex:index];
            }
        }

    }
    else
    {
        if(fieldEnum == CPTScatterPlotFieldX)
        {
            return [NSNumber numberWithUnsignedInteger:index];
        }
        else
        {
            NSUInteger length = [appData.co2ValueArray count];
            if (length > 400)
            {
                float co2Value = [[appData.co2ValueArray objectAtIndex:length-(400-index)] floatValue];
                float mmHgValue = co2Value*0.00760;
                return [NSNumber numberWithFloat:mmHgValue];
            }
            else
            {
                float co2Value = [[appData.co2ValueArray objectAtIndex:index] floatValue];
                float mmHgValue = co2Value*0.00760;
                return [NSNumber numberWithFloat:mmHgValue];
            }
        }
    }

}
- (IBAction)PlayControlAction:(id)sender {
   
    
    
}
    @end


