//
//  AppDelegate.swift
//  SwiftMapApp
//
//  Created by Natsumo Ikeda on 2016/08/10.
//  Copyright © 2016年 NIFTY Corporation. All rights reserved.
//

import UIKit
import NCMB
import GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    // mBaaS APIkey
    let applicationkey = "YOUR_NCMB_APPLICATIONKEY"
    let clientkey      = "YOUR_NCMB_CLIENTKEY"

    // Google Maps APIkey
    let googleMapsAPIkey = "YOUR_GOOGLE_MAPS_APYKEY"

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // mBaaS初期化
        NCMB.setApplicationKey(applicationkey, clientKey: clientkey)
        // GoogleMaps初期化
        GMSServices.provideAPIKey(googleMapsAPIkey)
        
        return true
    }

}

