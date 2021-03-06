//
//  PDFViewController.m
//  Capstone2
//
//  Created by John Appleseed on 10/6/15.
//  Copyright © 2015 Johnathan Cornella. All rights reserved.
//

#import "PDFViewController.h"
#import "PDFRenderer.h"


@interface PDFViewController ()

@end

@implementation PDFViewController

- (void)viewDidLoad

{
    
    //Code to Load the View and Show the PDF File
    
    NSString* fileName = [self getPDFFileName];
    
    [PDFRenderer drawPDF:fileName];
    
    [self showPDFFile];
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

//Makes a pdf named doctors information

-(NSString*)getPDFFileName
{
    NSString* fileName = @"DoctorInformation.PDF";
    
    //Sets the fileName to "Doctors Information".
    
    NSArray *arrayPaths =
    NSSearchPathForDirectoriesInDomains(
                                        NSDocumentDirectory,
                                        NSUserDomainMask,
                                        YES);
    NSString *path = [arrayPaths objectAtIndex:0];
    NSString* pdfFileName = [path stringByAppendingPathComponent:fileName];
    
    //Sets the savepath to the application's documents directory.
    
    return pdfFileName;
    
    //Returns the name of the PDF
}

//Shows the PDF that was generated in a webview.

-(void)showPDFFile
{
    NSString* fileName = @"DoctorInformation.PDF";
    NSArray *arrayPaths =
    NSSearchPathForDirectoriesInDomains(
                                        NSDocumentDirectory,
                                        NSUserDomainMask,
                                        YES);
    NSString *path = [arrayPaths objectAtIndex:0];
    NSString* pdfFileName = [path stringByAppendingPathComponent:fileName];
    
    UIWebView* webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 700, 900)];
    
    //Creates a webView that sets the size of the PDF rendering view. Cordinates can be chose and set here. Need to Modify in future. 
    
    //Cordinates work the following way. (x,y,l,h). x=upper left point origin, y=upper left point y origin, l=rectange length, h=height of rectangle
    
    NSURL *url = [NSURL fileURLWithPath:pdfFileName];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView setScalesPageToFit:YES];
    [webView loadRequest:request];
    
    [self.view addSubview:webView];
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

@end
