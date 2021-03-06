//
//  PDFRenderer.m
//  Capstone2
//
//  Created by John Appleseed on 10/6/15.
//  Copyright © 2015 Johnathan Cornella. All rights reserved.
//

#import "PDFRenderer.h"

@implementation PDFRenderer


+(void)drawPDF:(NSString*)fileName
{
    // Create the PDF context using the default page size of 612 x 792. Use the given file name from PDF View Controller.
    UIGraphicsBeginPDFContextToFile(fileName, CGRectZero, nil);
    // Mark the beginning of a new page. Makes a PDF document with 612 x 792.
    UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 612, 792), nil);
    
    //Code that ues UI Graphs to make and draw the PDF.
    
    
    //CGPoint from = CGPointMake(0, 0);
    //CGPoint to = CGPointMake(200, 300);
    //[PDFRenderer drawLineFromPoint:from toPoint:to];
    
    //Draw the text from the method that it shown bellow
    
    [self drawText];
    
    
    UIImage* logo = [UIImage imageNamed:@"Mayo-clinic-logo.png"];
    CGRect frame = CGRectMake(20, 100, 300, 60);
    
    [PDFRenderer drawImage:logo inRect:frame];
    
    //Use this Code to Draw Images will eventually be used to render the graph image.
    
    // Close the PDF context and write the contents out.
    UIGraphicsEndPDFContext();
}

+(void)drawText
{

    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context =
    [appDelegate managedObjectContext];
    NSError *error;

    
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    [request setEntity:entityDesc];
    
    //We probably don't need a predicate right now...
    //NSPredicate *pred =
    //[NSPredicate predicateWithFormat:@"(firstName = %@)"];
    //[request setPredicate:pred];
    
    NSManagedObject *matches = nil;
    NSArray *objects = [context executeFetchRequest:request
                                              error:&error];
    
    NSString *firstName, *lastName, *dateOfBirth, *medicalID;
    
    if ([objects count] == 0) {
        NSLog(@"No matches");
    } else {
        matches = objects[0];
        firstName = [matches valueForKey:@"firstName"];
        lastName = [matches valueForKey:@"lastName"];
        dateOfBirth = [matches valueForKey:@"dateOfBirth"];
        medicalID = [matches valueForKey:@"medicalID"];
    }

    NSString *lineBreak = @"\n";
    
    NSString *joinString=[NSString stringWithFormat:@"%@,%@,%@,%@,%@,%@,%@", firstName, lineBreak, lastName, lineBreak, dateOfBirth, lineBreak, medicalID];
    
    //Method to Draw Text using a Cordinate System. Will use to draw all the text for the patient information.
    //Need to figure out necessary cordinate systems.

    NSString* textToDraw = joinString;
    CFStringRef stringRef = (__bridge CFStringRef)textToDraw;
    // Prepare the text using a Core Text Framesetter
    CFAttributedStringRef currentText = CFAttributedStringCreate(NULL, stringRef, NULL);
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(currentText);
    
    CGRect frameRect = CGRectMake(20, 100, 30, 60);
    CGMutablePathRef framePath = CGPathCreateMutable();
    CGPathAddRect(framePath, NULL, frameRect);
    
    // Get the frame that will do the rendering.
    CFRange currentRange = CFRangeMake(0, 0);
    CTFrameRef frameRef = CTFramesetterCreateFrame(framesetter, currentRange, framePath, NULL);
    CGPathRelease(framePath);
    
    // Get the graphics context.
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    // Put the text matrix into a known state. This ensures
    // that no old scaling factors are left in place.
    CGContextSetTextMatrix(currentContext, CGAffineTransformIdentity);
    
    // Core Text draws from the bottom-left corner up, so flip
    // the current transform prior to drawing.
    CGContextTranslateCTM(currentContext, 0, 100);
    CGContextScaleCTM(currentContext, 1.0, -1.0);
    
    // Draw the frame.
    CTFrameDraw(frameRef, currentContext);
    
    CFRelease(frameRef);
    CFRelease(stringRef);
    CFRelease(framesetter);
    
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


@end
