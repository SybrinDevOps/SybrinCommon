//
//  AppDelegate.swift
//  Sybrin.iOS.Common.Showcase
//
//  Created by Nico Celliers on 2020/08/25.
//  Copyright © 2020 Sybrin Systems. All rights reserved.
//

import UIKit
import Sybrin_iOS_Common

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    static var framework: SybrinConfiguration!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        CommonHelper.executeWithDeveloperAccess {
            LogHandler.globalLogLevel = .Verbose
            LogHandler.logDebugInformation = true
            
            let config = SybrinConfiguration()
            
            AppDelegate.framework = config
            FrameworkConfiguration.configuration = config
        }
        
        return true
    }


}

