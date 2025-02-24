
#import <UIKit/UIKit.h>
#import <PushKit/PushKit.h>
#import "RNNotifications.h"
#import "RNNotificationCenterListener.h"
#import "RNPushKit.h"
#import "RNNotificationCenterMulticast.h"

@implementation RNNotifications {
    RNPushKit* _pushKit;
    RNNotificationCenterListener* _notificationCenterListener;
    RNNotificationEventHandler* _notificationEventHandler;
    RNNotificationsStore* _store;
    RNPushKitEventHandler* _pushKitEventHandler;
    RNEventEmitter* _eventEmitter;
    RNNotificationCenterMulticast* _notificationCenterMulticast;
}

- (instancetype)init {
    self = [super init];
    _store = [RNNotificationsStore sharedInstance];
    _notificationEventHandler = [[RNNotificationEventHandler alloc] initWithStore:_store];
    return self;
}

+ (instancetype)sharedInstance {
    static RNNotifications *sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[RNNotifications alloc] init];
    });
    return sharedInstance;
}

+ (void)startMonitorNotifications {
    [[self sharedInstance] startMonitorNotifications];
}

+ (void)startMonitorPushKitNotifications:(id<PKPushRegistryDelegate>)softphone {
    [[self sharedInstance] startMonitorPushKitNotifications:softphone];
}

+ (void)didReceiveBackgroundNotification:(NSDictionary *)userInfo withCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [[self sharedInstance] didReceiveBackgroundNotification:userInfo withCompletionHandler:completionHandler];
}

+ (void)didRegisterForRemoteNotificationsWithDeviceToken:(id)deviceToken {
    [[self sharedInstance] didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

+ (void)didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    [[self sharedInstance] didFailToRegisterForRemoteNotificationsWithError:error];
}

+ (void)addNativeDelegate:(id<UNUserNotificationCenterDelegate>)delegate {
    [[self sharedInstance] addNativeDelegate:delegate];
}

+ (void)removeNativeDelegate:(id<UNUserNotificationCenterDelegate>)delegate {
    [[self sharedInstance] removeNativeDelegate:delegate];
}

- (RNNotificationCenterMulticast*)multicast {
    return _notificationCenterMulticast;
}

- (void)startMonitorNotifications {
    _notificationCenterListener = [[RNNotificationCenterListener alloc] initWithNotificationEventHandler:_notificationEventHandler];
    
    _notificationCenterMulticast = [[RNNotificationCenterMulticast alloc] init];
    [[UNUserNotificationCenter currentNotificationCenter] setDelegate:_notificationCenterMulticast];
    
    [_notificationCenterMulticast addNativeDelegate:_notificationCenterListener];
}

- (void)startMonitorPushKitNotifications:(id<PKPushRegistryDelegate>)softphone {
    _pushKitEventHandler = [[RNPushKitEventHandler alloc] initWithStore:_store];
    _pushKit = [[RNPushKit alloc] initWithEventHandler:_pushKitEventHandler andSoftphone:softphone];
}

- (void)didReceiveBackgroundNotification:(NSDictionary *)userInfo withCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [_notificationEventHandler didReceiveBackgroundNotification:userInfo withCompletionHandler:completionHandler];
}

- (void)didRegisterForRemoteNotificationsWithDeviceToken:(id)deviceToken {
    [_notificationEventHandler didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

- (void)didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    [_notificationEventHandler didFailToRegisterForRemoteNotificationsWithError:error];
}

- (void)addNativeDelegate:(id<UNUserNotificationCenterDelegate>)delegate {
    [_notificationCenterMulticast addNativeDelegate:delegate];
}

- (void)removeNativeDelegate:(id<UNUserNotificationCenterDelegate>)delegate {
    [_notificationCenterMulticast removeNativeDelegate:delegate];
}

@end
