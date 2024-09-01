//
//  MParticleManager.swift
//  AppClipTest
//
//  Created by Christina S on 7/22/20.
//

import Foundation
import mParticle_Apple_SDK
import mParticle_Iterable
//import IterableSDK


public struct MParticleFlag {
    var key: String
    var value: String
}

class MParticleManager {

    static let shared = MParticleManager()

    var options = MParticleOptions(key: MparticleTokens.apiKey,
                                   secret: MparticleTokens.secret)

    private init() {
        options.environment = .development
        options.logLevel = .debug
        options.proxyAppDelegate = false // this might be the issue (the app delegate proxy)
        
        let request = MPIdentityApiRequest()
        request.email = "email@example.com"
        options.identifyRequest = request
        
        options.onIdentifyComplete = { (apiResult, error) in
            print("🍩 MParticle Identify complete. userId = \(apiResult?.user.userId.stringValue ?? "Null User ID") error = \(error?.localizedDescription ?? "No Error Available")")
            
            if MParticle.sharedInstance().isKitActive(1003) {
                print("🍩 iterable active")
            }
            
        }
        
        options.onAttributionComplete = { result, error in
            if let error = error {
                print("🍩 Attribution fetching for kitCode=\(String(describing: (error as NSError).userInfo[mParticleKitInstanceKey])) failed with error=\(error)")
                return
            }

            if let kitCode = result?.kitCode,
               let linkInfo = result?.linkInfo {
                print("🍩 Attribution fetching for kitCode=\(kitCode) completed with linkInfo: \(linkInfo)")
            }

        }
        
        MParticle.sharedInstance().start(with: options)
    }

    static var visitor: MParticleUser? {
        MParticle.sharedInstance().identity.currentUser
    }

    static public func start() {
        _ = MParticleManager.shared
    }
    
    class func logEvent(_ name: String,
                     type: MPEventType,
                     attributes: [String: Any]? = nil,
                     flags: [MParticleFlag]? = nil) {
        
        guard let event = MPEvent(name: name, type: type) else {
            return
        }
        
        if let attributes = attributes {
            event.customAttributes = attributes
        }
        
        if let flags = flags {
            flags.forEach {
                event.addCustomFlag($0.value, withKey: $0.key)
            }
        }

        MParticle.sharedInstance().logEvent(event)
    }
    
    class func logScreen(_ name: String, info: [String: Any]? = nil) {
        MParticle.sharedInstance().logScreen(name, eventInfo: info)
    }
    
    class func logProductEvent(action: MPCommerceEventAction,
                               product: MPProduct?,
                               attributes: MPTransactionAttributes? = nil) {
        let event = MPCommerceEvent(action: action, product: product)
        event.transactionAttributes = attributes
        MParticle.sharedInstance().logEvent(event)
    }
    
    class func logProductImpression(with name: String, product: MPProduct?) {
        let event = MPCommerceEvent(impressionName: name, product: product)
        MParticle.sharedInstance().logEvent(event)
    }
    
    class func productFrom(id: String, name: String, price: Double) -> MPProduct {
       return MPProduct(name: name,
               sku: id,
               quantity: 1,
               price: price as NSNumber)
    }
    
    // MARK: Push and In App
    class func didReceiveRemoteNotification(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        MParticle.sharedInstance().didReceiveRemoteNotification(userInfo)
        // Do I need this?
//        IterableAppIntegration.application(application, didReceiveRemoteNotification: userInfo, fetchCompletionHandler: completionHandler)
    }
    
    class func open(url: URL) {
        MParticle.sharedInstance().open(url, options: [:])
    }
    
    class func register(token: Data) {
        MParticle.sharedInstance().didRegisterForRemoteNotifications(withDeviceToken: token)
        // Do I need this?
        // IterableAPI.register(token: token)
    }
    
    class func application(continue userActivity: NSUserActivity,
                     restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) {
        MParticle.sharedInstance().continue(userActivity, restorationHandler: restorationHandler)
    }
    
    class func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) {
        MParticle.sharedInstance().userNotificationCenter(center, willPresent: notification)
    }
    
    class func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        MParticle.sharedInstance().userNotificationCenter(center, didReceive: response)
        // Do I need this?
//        IterableAppIntegration.userNotificationCenter(center, didReceive: response, withCompletionHandler: completionHandler)
    }
    
    // MARK: Consent Management
//    class func consentPreferencesUpdated(with categories: [String]) {
//        guard categories.count > 0 else {
//            [Vendor].userConsentStatus = .notConsented
//            return
//        }
//        [Vendor].userConsentCategories = [Vendor].consentCategoriesStringArrayToEnum(categories)
//    }

}
