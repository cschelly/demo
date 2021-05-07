//
//  MParticleManager.swift
//  AppClipTest
//
//  Created by Christina S on 7/22/20.
//

import Foundation
import mParticle_Apple_SDK

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
    
//    class func consentPreferencesUpdated(with categories: [String]) {
//        guard categories.count > 0 else {
//            TealiumHelper.shared.tealium?.consentManager?.userConsentStatus = .notConsented
//            return
//        }
//        TealiumHelper.shared.tealium?.consentManager?.userConsentCategories = TealiumConsentCategories.consentCategoriesStringArrayToEnum(categories)
//    }

}

