package com.wix.reactnativenotifications.core;


import com.wix.reactnativenotifications.core.notification.PushNotificationProps;
import java.util.List;
import java.util.ArrayList;

public class InitialNotificationHolder {

    private static InitialNotificationHolder sInstance;

    private PushNotificationProps mNotification;

    public List<PushNotificationProps> pendingNotifications;

    public static void setInstance(InitialNotificationHolder instance) {
        sInstance = instance;
    }

    /*package*/ InitialNotificationHolder() {
    }

    public static InitialNotificationHolder getInstance() {
        if (sInstance == null) {
            sInstance = new InitialNotificationHolder();
            sInstance.pendingNotifications = new ArrayList<PushNotificationProps>();
        }
        return sInstance;
    }

    public void set(PushNotificationProps pushNotificationProps) {
        if (mNotification == null) {
            mNotification = pushNotificationProps;
        }   
    }

    public void clear() {
        mNotification = null;
    }

    public PushNotificationProps get() {
        return mNotification;
    }

    public void addPendingNotification(PushNotificationProps pushNotificationProps) {
        pendingNotifications.add(pushNotificationProps);
    }

    public List<PushNotificationProps> getPendingNotifications() {
        return pendingNotifications;
    }

    public void removePendingNotifications() {
        pendingNotifications.clear();
    }
}
