//
//  AppDelegate.swift
//  CodeChallenge
//
//  Created by Mounika Jakkampudi on 10/10/20.
//  Copyright © 2020 MVVM. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.rootViewController = DataTableViewController()
        window?.makeKeyAndVisible()
        return true
    }
}
