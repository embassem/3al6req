//
//  extension.swift
//  TaxiPay
//
//  Created by Macintosh on 5/4/16.
//  Copyright © 2016 EMBassem. All rights reserved.
//

import Foundation

extension UserDefaults {
    // check for is first launch - only true on first invocation after app install, false on all further invocations
    static func isFirstLaunch() -> Bool {
        let firstLaunchFlag = "FirstLaunchFlag"
        let isFirstLaunch = UserDefaults.standard.string(forKey: firstLaunchFlag) == nil
        if (isFirstLaunch) {
            UserDefaults.standard.set("false", forKey: firstLaunchFlag)
            UserDefaults.standard.synchronize()
            
             UserDefaults.standard.set(2.0, forKey: "Base_Fair");
             UserDefaults.standard.set(1.25, forKey: "HSD_Fair");
             UserDefaults.standard.set(1.50, forKey: "LSD_Fair");
             UserDefaults.standard.set(1.75, forKey: "JSD_Fair");
             UserDefaults.standard.set(0.25, forKey: "STOP_Fair");
        }
        return isFirstLaunch
    }
}
