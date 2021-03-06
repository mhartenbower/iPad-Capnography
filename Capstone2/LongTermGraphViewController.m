//
//  LongTermGraphViewController.m
//  Capstone2
//
//  Created by Johnathan Cornella on 9/25/15.
//  Copyright (c) 2015 Johnathan Cornella. All rights reserved.
//

#import "LongTermGraphViewController.h"

@interface LongTermGraphViewController ()

@end

@implementation LongTermGraphViewController

@synthesize timePeriodSelector;
@synthesize coreDataArray;



- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate *appDelegate =[[UIApplication sharedApplication] delegate];
    context = [appDelegate managedObjectContext];
    coreDataArray = [[NSMutableArray alloc] init];
    
    [self.timePeriodSelector addTarget:self
                                action:@selector(whichColor:)
                   forControlEvents:UIControlEventValueChanged];
    
    // Do any additional setup after loading the view. Use this to Load the Graph
    
    
    //Summary of Graph Setups. Graph 3
    
    //Initialize the Core Data Graph for Session Data with a rectangular frame. Allocate it in the memory
    
    graph3 = [[CPTXYGraph alloc] initWithFrame:CGRectZero];
    
    //Set the theme for the graph to be the default graph theme
    
    CPTTheme *theme1 = [CPTTheme themeNamed:kCPTStocksTheme];
    
    //Apply the theme to the Graph
    
    [graph3 applyTheme:theme1];
    
    
    //Frame Setup for Graph 3 which is defined in Storyboard. Set up the padding for the graph as well as the border and line style.
    
    graph3.frame                       = self.view.bounds;
    
    graph3.paddingRight                = 50.0f;
    graph3.paddingLeft                 = 50.0f;
    graph3.plotAreaFrame.masksToBorder = NO;
    graph3.plotAreaFrame.cornerRadius  = 0.0f;
    CPTMutableLineStyle *borderLineStyle1 = [CPTMutableLineStyle lineStyle];
    borderLineStyle1.lineColor           = [CPTColor whiteColor];
    borderLineStyle1.lineWidth           = 2.0f;
    graph3.plotAreaFrame.borderLineStyle = borderLineStyle1;
    
    //Title Setup for Graph 3
    
    CPTMutableTextStyle *titleStyle3 = [CPTMutableTextStyle textStyle];
    titleStyle3.color = [CPTColor whiteColor];
    titleStyle3.fontName =@"Helvetica-Bold";
    titleStyle3.fontSize = 16.0f;
    
    //Setup the title for the Graph and Name it Core Data Graph
    
    NSString *title3 = @"Core Data Graph mmHG";
    graph3.title = title3;
    graph3.titleTextStyle = titleStyle3;
    graph3.titlePlotAreaFrameAnchor = CPTRectAnchorTop;
    graph3.titleDisplacement = CGPointMake(0.0f, -16.0f);
    
    //Set up Graph Function
    
    self.graphView3.hostedGraph = graph3;
    
    //Axis Setup for Graph 3
    
    
    CPTXYAxisSet *xyAxisSet3        = (id)graph3.axisSet;
    CPTXYAxis *xAxis3               = xyAxisSet3.xAxis;
    CPTMutableLineStyle *lineStyle3 = [xAxis3.axisLineStyle mutableCopy];
    lineStyle3.lineCap   = kCGLineCapButt;
    xAxis3.axisLineStyle = lineStyle3;
    xAxis3.labelingPolicy = CPTAxisLabelingPolicyAutomatic;
    //Sets the label policy for the X axis to automatic and lets the IPad choose the graph intervals. This will be between 0 and 30 because 30 is the current number of samples.
    
    CPTXYAxis *yAxis3 = xyAxisSet3.yAxis;
    yAxis3.axisLineStyle = nil;
    
    yAxis3.labelingPolicy = CPTAxisLabelingPolicyAutomatic;
    
    //Set the default plot space to construct the graph
    
    CPTXYPlotSpace *plotSpace3 = (CPTXYPlotSpace *) graph3.defaultPlotSpace;
    
    //Set the X and Y value ranges which can be manipulated
    //Any changes in the numbers will affect the amount of data that is displayed
    
    //[plotSpace3 setYRange: [CPTPlotRange plotRangeWithLocation:[NSNumber numberWithCGFloat:0]length:[NSNumber numberWithCGFloat:8000]]];
    
    //[plotSpace3 setXRange: [CPTPlotRange plotRangeWithLocation:[NSNumber numberWithCGFloat:0]length:[NSNumber numberWithCGFloat:30]]];
    
    plotSpace3.yRange = [CPTPlotRange plotRangeWithLocation:@0 length:@100];
    
    plotSpace3.xRange = [CPTPlotRange plotRangeWithLocation:@0 length:@800];
    
    
    //Create the plot and alloc and initialize it with the necessary frame
    
    CPTScatterPlot* plot3 = [[CPTScatterPlot alloc] initWithFrame:CGRectZero];
    
    //Chose the line style and width that will be displayed
    
    CPTMutableLineStyle  *datalineStyle3 = [CPTMutableLineStyle lineStyle];
    datalineStyle3.lineColor = [CPTColor whiteColor];
    datalineStyle3.lineWidth = 3.0f;
    plot3.dataLineStyle = datalineStyle3;
    
    plot3.dataSource = self;
    
    [graph3 addPlot:plot3 toPlotSpace:graph3.defaultPlotSpace];
    
    [graph3 reloadData];
    
    
    //Initial Graphs is set up still need to finish the graph setup to draw information from core data
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//Used to programitcally control what happens when the user selects the period of time to display on the graph

//Code to Implement Selector for time Period
/*
- (IBAction)timePeriodAction:(id)sender

{
    
if (timePeriodSelector.selectedSegmentIndex == 0)
    
{
    //Add in Code to Display only Core Data Values in the last 15 Seconds since the last measrument in the Graph
}
    
else if (timePeriodSelector.selectedSegmentIndex == 1)
    
{
    //Add in Code to Display only Core Data Values in the last 30 Seconds since the last taken measrment in the Graph
}
    
else if (timePeriodSelector.selectedSegmentIndex == 2)
    
{

    //Add in the Code to Display only Core Data Values in the last 1 minute since the last measrument in the Graph.

}
    
else if (timePeriodSelector.selectedSegmentIndex == 3)
    
{
    //Add in the Code to Display only Core Data Values from the Last Five Minutes since the last measurment in the Graph
    
}
 
 
}
 
 */

- (IBAction)saveGraphImage:(id)sender

{
    //Need to save the Graph Generate by Core Plot as an Image File. Should be able to be done by calling the method CPT Image of Layer.
    
    
}


//Information to Determine what points to add to Graph.


//Method to implement number of records that will go on plot. Needs to be changed depending on current selection of the switch.

//Need to Return amount of points in a number that will go on plot. Number of points based on time period selector switch.
//Needs to be an NSInteger. Example return 8

-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plotnumberOfRecords {
    
    
    if(timePeriodSelector.selectedSegmentIndex == 0)
    {
        NSLog(@"15 seconds");
        return 300;
    }
    else if(timePeriodSelector.selectedSegmentIndex == 1)
    {
        NSLog(@"20 seconds");
        return 400;
    }
    else if(timePeriodSelector.selectedSegmentIndex == 2)
    {
        NSLog(@"30 seconds");
        return 600;
    }
    else if(timePeriodSelector.selectedSegmentIndex == 3)
    {
        NSLog(@"40 seconds");
        return 800;
    }
    return nil;
     
   // NSLog(@"200 points");
   // return 200;
    
}






-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
    NSUInteger x = index;
    NSUInteger y = 0;
    
    NSError *error;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Co2Value" inManagedObjectContext:context];
    //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"dayEnrolled == %d", index];
    
    [fetchRequest setEntity:entity];
    //[fetchRequest setPredicate:predicate];
    
    NSArray *array1 = [context executeFetchRequest:fetchRequest error:&error];
    float co2Value;
    
    coreDataArray = [array1 valueForKey:@"co2Value"];
    
    /*Print out the elements of the array to check
    for(id value in co2Values)
    {
        co2Value = [value floatValue];
        NSLog(@"%.2f", co2Value);
    }
    */
    
    if(plot.graph == graph3)
    {
        if(fieldEnum == CPTScatterPlotFieldX)
        {
            return [NSNumber numberWithUnsignedInteger:index];
        }
        else
        {
            NSUInteger length = [coreDataArray count];
            /*
            if (length > 200)
            {
                return [coreDataArray objectAtIndex:length-(200-index)];
            }
             */
            //else
            //{
                return [coreDataArray objectAtIndex:index];
            //}
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
            NSUInteger length = [coreDataArray count];
            if (length > 200)
            {
                float co2Value = [[coreDataArray objectAtIndex:length-(200-index)] floatValue];
                return [NSNumber numberWithFloat:co2Value];
            }
            else
            {
                float co2Value = [[coreDataArray objectAtIndex:index] floatValue];
                return [NSNumber numberWithFloat:co2Value];
            }
        }
    }
    return nil;
}

- (void) whichColor:(UISegmentedControl *)paramSender{
    NSLog(@"Reloading data");
    [graph3 reloadData];

}




@end
