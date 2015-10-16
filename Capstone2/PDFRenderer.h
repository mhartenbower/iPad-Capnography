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

+(void)drawPDF:(NSString*)fileName;
+(void)drawText;
+(void)drawImage:(UIImage*)image inRect:(CGRect)rect;


@end
