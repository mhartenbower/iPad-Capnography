
//Updates for iOS 9/Xcode 7 Added

#import <Foundation/Foundation.h>

#if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR
#import <CoreBluetooth/CoreBluetooth.h>
#elif TARGET_OS_MAC
#import <IOBluetooth/IOBluetooth.h>
#endif

#import "RFduinoDelegate.h"

@class RFduinoManager;

char data(NSData *data);
uint8_t dataByte(NSData *data);
int dataInt(NSData *data);
float dataFloat(NSData *data);

// default NULL (NULL = previous fixed RFduino uuid)
extern NSString *customUUID;

@interface RFduino : NSObject<CBPeripheralDelegate>
{
}

@property(assign, nonatomic) id<RFduinoDelegate> delegate;

@property(strong, nonatomic) CBPeripheral *peripheral;

@property(strong, nonatomic) RFduinoManager *rfduinoManager;

@property(strong, nonatomic) NSString *name;
// @property(strong, nonatomic) NSString *UUID;
@property(strong, nonatomic) NSData *advertisementData;
@property(strong, nonatomic) NSNumber *advertisementRSSI;
@property(assign, nonatomic) NSInteger advertisementPackets;
@property(strong, nonatomic) NSDate *lastAdvertisement;
@property(assign, nonatomic) NSInteger outOfRange;
- (void)connected;
- (void)disconnect;

- (void)send:(NSData *)data;

@end
