
//Updates for Xcode 7/iOS 9

#import <Foundation/Foundation.h>

@protocol RFduinoDelegate <NSObject>

@optional

- (void)didReceive:(NSData *)data;

@end
