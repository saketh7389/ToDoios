
//
//  Utils.swift
//  Apps For Your Business
//
//  Created by Pankti on 13/02/17.
//  Copyright © 2017 Dungeon_Master. All rights reserved.
//

import UIKit
import SKActivityIndicatorView
class Utils: NSObject {
    class func ShowActivityIndicator(message : String) {
        SKActivityIndicator.show(message, userInteractionStatus: false)
        SKActivityIndicator.spinnerStyle(.spinningFadeCircle)
        SKActivityIndicator.spinnerColor(.darkGray)
    }
}

