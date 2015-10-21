//
//  PDFRenderer.h
//  Capstone2
//
//  Created by John Appleseed on 10/6/15.
//  Copyright © 2015 Johnathan Cornella. All rights reserved.
//
#import "AppDelegate.h"
#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>
#import <UIKit/UIKit.h>
#import "AppDelegate.h"


@interface PDFRenderer : NSObject

+(void)drawPDF:(NSString*)fileName withImage:(UIImage*)graphImage;
+(void)drawText;
+(void)drawImage:(UIImage*)image inRect:(CGRect)rect;
+(void)drawText:(NSString*)textToDraw inFrame:(CGRect)frameRect;

+(void)drawTableAt:(CGPoint)origin
     withRowHeight:(int)rowHeight
    andColumnWidth:(int)columnWidth
       andRowCount:(int)numberOfRows
    andColumnCount:(int)numberOfColumns;


+(void)drawTableDataAt:(CGPoint)origin
         withRowHeight:(int)rowHeight
        andColumnWidth:(int)columnWidth
           andRowCount:(int)numberOfRows
        andColumnCount:(int)numberOfColumns;


@end
