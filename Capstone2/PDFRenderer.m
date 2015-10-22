//
//  PDFRenderer.m
//  Capstone2
//
//  Created by John Appleseed on 10/6/15.
//  Copyright © 2015 Johnathan Cornella. All rights reserved.
//

#import "PDFRenderer.h"

@implementation PDFRenderer


+(void)drawPDF:(NSString*)fileName withImage:(UIImage*)graphImage
{
    // Create the PDF context using the default page size of 612 x 792. Use the given file name from PDF View Controller.
    UIGraphicsBeginPDFContextToFile(fileName, CGRectZero, nil);
    // Mark the beginning of a new page. Makes a PDF document with 612 x 792.
    UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 612, 792), nil);
    
    //Code that ues UI Graphs to make and draw the PDF.
    
    
    //Draw the text from the method that it shown bellow
    
    //UIImage *logo = graphImage;
    
    //CGRect frame = CGRectMake(50, 350, 600, 400);
    
    NSLog(@"The width is %a and the height is %a", graphImage.size.width,graphImage.size.height);
    
    
    //CGRect frame = CGRectMake(0, 0, graphImage.size.width, graphImage.size.height);
    
    CGRect frame = CGRectMake(20, 350, 580, 400);
    
    [PDFRenderer drawImage:graphImage inRect:frame];
    
    //Use this Code to Draw Images will eventually be used to render the graph image.
    
    // Close the PDF context and write the contents out.
    
    int xOrigin = 50;
    int yOrigin = 100;
    
    int rowHeight = 50;
    int columnWidth = 120;
    
    int numberOfRows = 4;
    int numberOfColumns = 4;
    
    [self drawTableAt:CGPointMake(xOrigin, yOrigin) withRowHeight:rowHeight andColumnWidth:columnWidth andRowCount:numberOfRows andColumnCount:numberOfColumns];
    
    [self drawTableDataAt:CGPointMake(xOrigin, yOrigin) withRowHeight:rowHeight andColumnWidth:columnWidth andRowCount:numberOfRows andColumnCount:numberOfColumns];
    
    
    
    UIGraphicsEndPDFContext();
}


+(void)drawLineFromPoint:(CGPoint)from toPoint:(CGPoint)to
{
    //Method to draw lines if necessary
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 2.0);
    
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    
    CGFloat components[] = {0.2, 0.2, 0.2, 0.3};
    
    CGColorRef color = CGColorCreate(colorspace, components);
    
    CGContextSetStrokeColorWithColor(context, color);
    
    
    CGContextMoveToPoint(context, from.x, from.y);
    CGContextAddLineToPoint(context, to.x, to.y);
    
    CGContextStrokePath(context);
    CGColorSpaceRelease(colorspace);
    CGColorRelease(color);
    
}

//Code to draw an image into the PDF. Cordinates can be changed above in the draw PDF Method. 
+(void)drawImage:(UIImage*)image inRect:(CGRect)rect
{
    
    [image drawInRect:rect];
    
}



+(void)drawText:(NSString*)textToDraw inFrame:(CGRect)frameRect
{
    
    CFStringRef stringRef = (__bridge CFStringRef)textToDraw;
    // Prepare the text using a Core Text Framesetter
    CFAttributedStringRef currentText = CFAttributedStringCreate(NULL, stringRef, NULL);
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(currentText);
    
    
    CGMutablePathRef framePath = CGPathCreateMutable();
    CGPathAddRect(framePath, NULL, frameRect);
    
    // Get the frame that will do the rendering.
    CFRange currentRange = CFRangeMake(0, 0);
    CTFrameRef frameRef = CTFramesetterCreateFrame(framesetter, currentRange, framePath, NULL);
    CGPathRelease(framePath);
    
    // Get the graphics context.
    CGContextRef    currentContext = UIGraphicsGetCurrentContext();
    
    // Put the text matrix into a known state. This ensures
    // that no old scaling factors are left in place.
    CGContextSetTextMatrix(currentContext, CGAffineTransformIdentity);
    
    
    // Core Text draws from the bottom-left corner up, so flip
    // the current transform prior to drawing.
    CGContextTranslateCTM(currentContext, 0, frameRect.origin.y*2);
    CGContextScaleCTM(currentContext, 1.0, -1.0);
    
    // Draw the frame.
    CTFrameDraw(frameRef, currentContext);
    
    CGContextScaleCTM(currentContext, 1.0, -1.0);
    CGContextTranslateCTM(currentContext, 0, (-1)*frameRect.origin.y*2);
    
    
    CFRelease(frameRef);
    CFRelease(stringRef);
    CFRelease(framesetter);
}

+(void)drawTableAt:(CGPoint)origin
     withRowHeight:(int)rowHeight
    andColumnWidth:(int)columnWidth
       andRowCount:(int)numberOfRows
    andColumnCount:(int)numberOfColumns

{
    
    for (int i = 0; i <= numberOfRows; i++) {
        
        int newOrigin = origin.y + (rowHeight*i);
        
        
        CGPoint from = CGPointMake(origin.x, newOrigin);
        CGPoint to = CGPointMake(origin.x + (numberOfColumns*columnWidth), newOrigin);
        
        [self drawLineFromPoint:from toPoint:to];
        
        
    }
    
    for (int i = 0; i <= numberOfColumns; i++) {
        
        int newOrigin = origin.x + (columnWidth*i);
        
        
        CGPoint from = CGPointMake(newOrigin, origin.y);
        CGPoint to = CGPointMake(newOrigin, origin.y +(numberOfRows*rowHeight));
        
        [self drawLineFromPoint:from toPoint:to];
        
        
    }
}

+(void)drawTableDataAt:(CGPoint)origin
         withRowHeight:(int)rowHeight
        andColumnWidth:(int)columnWidth
           andRowCount:(int)numberOfRows
        andColumnCount:(int)numberOfColumns
{
    
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context =
    [appDelegate managedObjectContext];
    NSError *error;
    
    
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    [request setEntity:entityDesc];
    
    
    NSManagedObject *matches = nil;
    NSArray *objects = [context executeFetchRequest:request
                                              error:&error];
    
    NSString *firstName, *lastName, *dateOfBirth, *medicalID, *patientEmail, *patientPhone, *doctorEmail, *doctorName;
    
    if ([objects count] == 0) {
        NSLog(@"No matches");
    } else {
        matches = objects[0];
        firstName = [matches valueForKey:@"firstName"];
        lastName = [matches valueForKey:@"lastName"];
        dateOfBirth = [matches valueForKey:@"dateOfBirth"];
        medicalID = [matches valueForKey:@"medicalID"];
        patientEmail = [matches valueForKey:@"email"];
        patientPhone = [matches valueForKey:@"phoneNumber"];
        doctorEmail = [matches valueForKey:@"doctorEmail"];
        doctorName = [matches valueForKey:@"doctorName"];
        
    }
    
    int padding = 10;
    
    //Takes Items that are from core data above and renders them in a chart. 
    
   // NSArray* patientInfo1 = [NSArray arrayWithObjects:@"First Name", firstName, @"Last Name", lastName, nil];
   // NSArray* patientInfo2 = [NSArray arrayWithObjects:@"Date of Birth", dateOfBirth, @"MedicalID#", medicalID, nil];
    //NSArray* patientInfo3 = [NSArray arrayWithObjects:@"Patient Email", patientEmail, @"Patient Phone", patientPhone, nil];
    //NSArray* patientInfo4 = [NSArray arrayWithObjects:@"Doctor Email", doctorEmail, @"Doctor Name", doctorName, nil];
    
    //This works but the top does not.
    
    NSMutableArray* patientInfo1 = [[NSMutableArray alloc] init];
    [patientInfo1 addObject:firstName];
    [patientInfo1 addObject:lastName];
    
    NSMutableArray* patientInfo2 = [[NSMutableArray alloc] init];
    [patientInfo2 addObject:dateOfBirth];
    [patientInfo2 addObject:medicalID];
    
    NSMutableArray* patientInfo3 = [[NSMutableArray alloc] init];
    [patientInfo3 addObject:patientEmail];
    [patientInfo3 addObject:patientPhone];

    NSMutableArray* patientInfo4 = [[NSMutableArray alloc] init];
    [patientInfo4 addObject:doctorEmail];
    [patientInfo4 addObject:doctorName];
    
    //NSArray* patientInfo5 = [NSArray arrayWithObjects:@"Blank", @"Blank", @"Blank", @"Blank", nil];

    
    NSArray* allInfo = [NSArray arrayWithObjects:patientInfo1, patientInfo2, patientInfo3, patientInfo4, nil];
    
    for(int i = 0; i < [allInfo count]; i++)
    {
        NSArray* infoToDraw = [allInfo objectAtIndex:i];
        
        for (int j = 0; j < numberOfColumns; j++)
        {
            
            int newOriginX = origin.x + (j*columnWidth);
            int newOriginY = origin.y + ((i+1)*rowHeight);
            
            CGRect frame = CGRectMake(newOriginX + padding, newOriginY + padding, columnWidth, rowHeight);
            
            
            [self drawText:[infoToDraw objectAtIndex:j] inFrame:frame];
        }
        
    }
}

@end
