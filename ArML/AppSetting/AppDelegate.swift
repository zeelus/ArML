//
//  AppDelegate.swift
//  ArML
//
//  Created by Gilbert Gwizdała on 03/10/2017.
//  Copyright © 2017 Gilbert Gwizdała. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow()
        self.window = window
        window.rootViewController = ViewControllerManager.shered.getVC(.mainArScene)
        window.makeKeyAndVisible()
        return true
    }

}

