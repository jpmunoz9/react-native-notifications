#import "RNPushKitEventListener.h"
#import "RNNotificationUtils.h"

@implementation RNPushKitEventListener {
    PKPushRegistry* _pushRegistry;
    RNPushKitEventHandler* _pushKitEventHandler;
    id<PKPushRegistryDelegate> _softphone;
}

- (instancetype)initWithPushKitEventHandler:(RNPushKitEventHandler *)pushKitEventHandler andSoftphone:(id<PKPushRegistryDelegate>)softphone {
    self = [super init];
    
    _pushRegistry = [[PKPushRegistry alloc] initWithQueue:dispatch_get_main_queue()];
    _pushKitEventHandler = pushKitEventHandler;
    _softphone = softphone;
    
    return self;
}

- (void)pushRegistry:(PKPushRegistry *)registry didUpdatePushCredentials:(PKPushCredentials *)credentials forType:(NSString *)type {
    [_pushKitEventHandler registeredWithToken:[RNNotificationUtils deviceTokenToString:credentials.token]];
    [_softphone pushRegistry:registry didUpdatePushCredentials:credentials forType:type];
}

- (void)pushRegistry:(PKPushRegistry *)registry didReceiveIncomingPushWithPayload:(PKPushPayload *)payload
             forType:(PKPushType)type
             withCompletionHandler:(void (^)(void))completionHandler {
  [_pushKitEventHandler didReceiveIncomingPushWithPayload:payload.dictionaryPayload withCompletionHandler:completionHandler];
  [_softphone pushRegistry:registry didReceiveIncomingPushWithPayload:payload forType:type withCompletionHandler:completionHandler];
}

- (void)pushRegistry:(PKPushRegistry *)registry didInvalidatePushTokenForType:(PKPushType)type {
  [_softphone pushRegistry:registry didInvalidatePushTokenForType:type];
}
 
@end
