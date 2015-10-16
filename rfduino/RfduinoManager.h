
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR
#import <CoreBluetooth/CoreBluetooth.h>
#elif TARGET_OS_MAC
#import <IOBluetooth/IOBluetooth.h>
#endif

#import "RFduinoManagerDelegate.h"

@interface RFduinoManager : NSObject <CBCentralManagerDelegate>
{
    CBCentralManager *central;
}

+ (RFduinoManager *)sharedRFduinoManager;

@property (nonatomic, assign) id<RFduinoManagerDelegate> delegate;
@property (nonatomic, strong) NSMutableArray *rfduinos;

- (bool)isScanning;
- (void)startScan;
- (void)stopScan;

- (void)connectRFduino:(RFduino *)rfduino;
- (void)disconnectRFduino:(RFduino *)rfduino;

- (void)loadedServiceRFduino:(RFduino *)rfduino;

@end
