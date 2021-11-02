#import <UIKit/UIKit.h>
#import "RNPushKitEventListener.h"
@import PushKit;

@interface RNPushKit : NSObject

- (instancetype)initWithEventHandler:(RNPushKitEventHandler *)pushKitEventHandler andSoftphone:(id<PKPushRegistryDelegate>)softphone;

@end
