//
//  Singleton.swift
//  Speed Dial
//
//  Created by PRAGMA on 24/08/18.
//  Copyright © 2018 PRAGMA. All rights reserved.
//

import UIKit
import Contacts

class Singleton: NSObject {
    // Declare our 'sharedInstance' property
    static let sharedInstance = Singleton()
    private override init() {}
    // MARK: - Check Reachability
    func NetworkRechability() -> Bool {
        let reachability = Reachability()!
        if reachability.isReachable {
            if reachability.isReachableViaWiFi || reachability.isReachableViaWWAN {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
}

