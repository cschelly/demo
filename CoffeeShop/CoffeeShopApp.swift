//
//  CoffeeShopApp.swift
//  CoffeeShop
//
//  Created by Christina S on 8/6/20.
//

import SwiftUI
import IterableSDK

@main
struct CoffeeShopApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            CoffeeView()
                .onOpenURL { url in
                    MParticleManager.open(url: url)
                }
                .onContinueUserActivity(NSUserActivityTypeBrowsingWeb) { activity in
                   MParticleManager.application(continue: activity) { restoring in
                        // nothing
                    }
                }
        }
    }
}

struct CoffeeView: View {
    @AppStorage("consent")
    var consentPreferences: Data = Data()
    var body: some View {
        guard let consentPreferences = try? JSONDecoder().decode(ConsentCategories.self, from: consentPreferences) else {
            return AnyView(CoffeeContentView().environmentObject(Consent()))
        }
        return AnyView(CoffeeContentView().environmentObject(Consent(categoriesFromStorage: consentPreferences)))
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        MParticleManager.start()
        setupNotifications()
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        print("😀 device token: \(token)")
        MParticleManager.register(token: deviceToken)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        MParticleManager.didReceiveRemoteNotification(application, didReceiveRemoteNotification: userInfo, fetchCompletionHandler: completionHandler)
    }
    
    private func setupNotifications() {
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            if settings.authorizationStatus != .authorized {
                // not authorized, ask for permission
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, _ in
                    if success {
                        DispatchQueue.main.async {
                            UIApplication.shared.registerForRemoteNotifications()
                        }
                    }
                    // TODO: Handle error etc.
                }
            } else {
                // already authorized
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        }
    }

}

extension AppDelegate: UNUserNotificationCenterDelegate {
    public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        MParticleManager.userNotificationCenter(center, willPresent: notification)
        completionHandler([.banner, .badge, .sound])
    }

    public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        MParticleManager.userNotificationCenter(center, didReceive: response, withCompletionHandler: completionHandler)
    }
}
