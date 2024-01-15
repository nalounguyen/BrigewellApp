//
//  AppDelegate.swift
//  BrigewellApp
//
//  Created by Nalou Nguyen on 09/01/2024.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var appStart: AppStart!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        appStart = AppStart(window: window!)
        appStart.start()
        return true
    }

    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            window = UIWindow()
            appStart = AppStart(window: window!)
            appStart.start()
        }


    }


}

