//
//  AppDelegate.swift
//  Podtest
//
//  Created by Gopal.Vaid on 08/08/16.
//  Copyright © 2016 Gopal.Vaid. All rights reserved.
//

import UIKit
import Google
import CoreData
import FBSDKCoreKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
//    // [START openurl]
//    func application(application: UIApplication,
//                     openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
//        return GIDSignIn.sharedInstance().handleURL(url,
//                                                    sourceApplication: sourceApplication,
//                                                    annotation: annotation)
//    }
//    // [END openurl]
//    
//    @available(iOS 9.0, *)
//    func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool {
//        return GIDSignIn.sharedInstance().handleURL(url,
//                                                    sourceApplication: options[UIApplicationOpenURLOptionsSourceApplicationKey] as! String?,
//                                                    annotation: options[UIApplicationOpenURLOptionsAnnotationKey])
//    }
    
    
    // MARK: - Callback handler for Facebook and Linkedln
    
    // IOS - 8
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool{
        
        let urlString: String = url.absoluteString
        print(urlString)
        if urlString.rangeOfString("fb916259321850840") != nil{
            print("exists")
            
            return  FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
            
        } else if urlString.rangeOfString("li4760035") != nil{
            
            if (LISDKCallbackHandler.shouldHandleUrl(url)) {
                return LISDKCallbackHandler.application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
            }
            
        }else {
            
            return GIDSignIn.sharedInstance().handleURL(url,
                                                        sourceApplication: sourceApplication,
                                                        annotation: annotation)
        }
        
        return false
    }
    
    
    //IOS -9
    @available(iOS 9.0, *)
    func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool{
        
        let urlString: String = url.absoluteString
        print(urlString)
        if urlString.rangeOfString("fb916259321850840") != nil{
            print("exists")
            
            return  FBSDKApplicationDelegate.sharedInstance().application(app, openURL: url, sourceApplication: options[UIApplicationOpenURLOptionsSourceApplicationKey]  as! String, annotation: nil )
            
        }else if urlString.rangeOfString("li4763215") != nil{
            
            if (LISDKCallbackHandler.shouldHandleUrl(url)) {
                return LISDKCallbackHandler.application(app, openURL: url, sourceApplication: options[UIApplicationOpenURLOptionsSourceApplicationKey]  as! String, annotation: nil)
            }
        }else {
            
            return GIDSignIn.sharedInstance().handleURL(url,
                                                        sourceApplication: options[UIApplicationOpenURLOptionsSourceApplicationKey] as! String?,
                                                        annotation: options[UIApplicationOpenURLOptionsAnnotationKey])
            
        }
        
        return false
    }
    
    

}

