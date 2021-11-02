#import "RNPushKit.h"

@implementation RNPushKit {
    RNPushKitEventListener* _pushKitEventListener;
}

- (instancetype)initWithEventHandler:(RNPushKitEventHandler *)pushKitEventHandler andSoftphone:(id<PKPushRegistryDelegate>)softphone {
    self = [super init];
    
    _pushKitEventListener = [[RNPushKitEventListener alloc] initWithPushKitEventHandler:pushKitEventHandler andSoftphone:(id<PKPushRegistryDelegate>)softphone];
    
    PKPushRegistry* pushKitRegistry = [[PKPushRegistry alloc] initWithQueue:dispatch_get_main_queue()];
    pushKitRegistry.delegate = _pushKitEventListener;
    pushKitRegistry.desiredPushTypes = [NSSet setWithObject:PKPushTypeVoIP];
    
    return self;
}

@end
