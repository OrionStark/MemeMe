//
//  AppDelegate.swift
//  MemeMe
//
//  Created by Robby Muhammad Nst on 14/10/18.
//  Copyright © 2018 ORIONOSCODE. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var memes = [Meme]()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
}

