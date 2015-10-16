
//Updates for iOS 7/Xcode 9

#import <Foundation/Foundation.h>

@class RFduino;

@protocol RFduinoManagerDelegate <NSObject>

- (void)didDiscoverRFduino:(RFduino *)rfduino;

@optional

- (void)didUpdateDiscoveredRFduino:(RFduino *)rfduino;

- (void)didConnectRFduino:(RFduino *)rfduino;
- (void)didLoadServiceRFduino:(RFduino *)rfduino;
- (void)didDisconnectRFduino:(RFduino *)rfduino;
- (void)shouldDisplayAlertTitled:(NSString *)title messageBody:(NSString *)body;

@end
