//
//  AppDelegate.swift
//  FeastVite
//
//  Created by student on 6/12/19.
//  Copyright © 2019 NWMSU. All rights reserved.
//

import UIKit
import UserNotifications
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    

    let APP_ID = "0AD753EE-CEF8-AE2D-FF46-4923F059BE00"  //this is the appID for backendless
    let API_KEY = "1CABE429-72C0-EBAA-FF04-7D9146269D00"//and the API key for backendless
    let backendless = Backendless.sharedInstance()
    
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        backendless?.initApp(APP_ID, apiKey:API_KEY)
//        copyandpast()
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            if error != nil {
                //
            }
        }
        // Override point for customization after application launch.
        return true
    }

    
    func copyandpast() {
        
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, false)
        let path1 = path[0]
        let finalpath = path1.appending("/feastvite.db")
        print(finalpath)
        
        let fmg = FileManager()
        print(fmg.currentDirectoryPath)
        
        if !fmg.fileExists(atPath: finalpath) {
            
            let localpath = Bundle.main.path(forResource: "feastvite", ofType: "db")
            
            do {
                
                try fmg.copyItem(atPath: localpath!, toPath: finalpath)
                
            } catch {
                
            }
        }
        
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }


    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

