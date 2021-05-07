//
//  AppDelegate.swift
//  Food Notes
//
//  Created by admin on 2021/5/3.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //客製化navigation返回按鈕
//        let backButtonImage = UIImage(named: "back")
//        UINavigationBar.appearance().backIndicatorImage = backButtonImage
//        UINavigationBar.appearance().backIndicatorTransitionMaskImage = backButtonImage
        
        // 客製化tab bar
        UITabBar.appearance().tintColor = UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 1.0) //更改tab bar文字、圖案顏色
        UITabBar.appearance().barTintColor = .black //更改tab bar背景顏色
//        UITabBar.appearance().barTintColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1) //更改tab bar背景顏色
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

