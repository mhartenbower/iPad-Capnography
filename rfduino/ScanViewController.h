
#import <UIKit/UIKit.h>

#import "RFduinoManagerDelegate.h"
#import "RFduinoObject.h"

@class RFduinoManager;
@class RFduino;

@interface ScanViewController : UITableViewController<RFduinoManagerDelegate, UITableViewDelegate>
{
    RFduinoManager *rfduinoManager;
}

@end
