//
//  AppDelegate.swift
//  Colony world ios
//
//  Created by Asim Getepay 2022 on 14/12/22.
//

import UIKit
import Firebase
import Messages
import FirebaseCore
import FirebaseMessaging
import AVFoundation
import IQKeyboardManagerSwift
//import UserNotifications
var appDel:AppDelegate?
@main
class AppDelegate: UIResponder, UIApplicationDelegate{
   let gcmMessageIDKey = "gcm.Message_ID1"
    var window: UIWindow?
    var firebaseToken: String = ""
    var topViewController:UIViewController? {
        
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            
            if topController is UINavigationController {
                if let top = topController as? UINavigationController {
                    if let newTop = top.visibleViewController.self {
                        return newTop
                    }
                }
            } else {
                return topController
            }
        }
        return nil
    }
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .light
        }
        IQKeyboardManager.shared.enable = true
        UITabBar.appearance().backgroundColor = getepayYellowColor
        UITabBar.appearance().tintColor = .white
        UITabBar.appearance().unselectedItemTintColor = .white
        
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        var navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.tintColor = .black
       // navigationBarAppearace.backgroundColor = .red
        FirebaseApp.configure()
        UNUserNotificationCenter.current().delegate = self

        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
          options: authOptions,
          completionHandler: { _, _ in }
        )

        application.registerForRemoteNotifications()

        Messaging.messaging().delegate = self
        let token = Messaging.messaging().fcmToken
        print("FCM token   ttttttttttttttttttttt===================:\(token ?? "")")
        fcmTocken_Val = "\(token ?? "")"
       // UserDefaults.standard.set(fcmTocken_Val, forKey: "FCMToken")
        
        var isLoggedIn : String = UserDefaults.standard.string(forKey: "isLoggedIn") ?? ""
                     if(isLoggedIn != nil && isLoggedIn == "true"){
                        
//                         let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
//                         let vc = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
//                         navigationController.pushViewController(vc, animated: true)
                         
                         let storyboard = UIStoryboard(name: "Main", bundle: nil)
                         let appDelegate = UIApplication.shared.delegate! as! AppDelegate
                         let initialViewController = storyboard.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
                         appDelegate.window?.rootViewController = initialViewController
                         appDelegate.window?.makeKeyAndVisible()

                     }
    
        

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
extension AppDelegate :UNUserNotificationCenterDelegate{
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                  willPresent notification: UNNotification) async
        -> UNNotificationPresentationOptions {
        let userInfo = notification.request.content.userInfo

//message is here
        print("userInfo\(userInfo)")
            
        // Change this to your preferred presentation option
        return [[.alert, .sound]]
      }

      func userNotificationCenter(_ center: UNUserNotificationCenter,
                                  didReceive response: UNNotificationResponse) async {
        let userInfo = response.notification.request.content.userInfo
          print("userInfo\(userInfo)")
        // ...

        // With swizzling disabled you must let Messaging know about the message, for Analytics
         // let userInfo1 = Messaging.messaging().appDidReceiveMessage(userInfo)
         
        // Print full message.

      }

    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable: Any]) async
      -> UIBackgroundFetchResult {
      // If you are receiving a notification message while your app is in the background,
      // this callback will not be fired till the user taps on the notification launching the application.
      // TODO: Handle data of notification

      // With swizzling disabled you must let Messaging know about the message, for Analytics
      // Messaging.messaging().appDidReceiveMessage(userInfo)

      // Print message ID.
      
         
      if let messageID = userInfo[gcmMessageIDKey] {
        print("Message ID: \(messageID)")
      }
          let storyboard = UIStoryboard(name: "Main", bundle: nil)
          let viewController = storyboard.instantiateViewController(withIdentifier: "PayMaintenanceController1") as! PayMaintenanceController1
          // Set any necessary properties on the viewController based on the notification data
          // For example: viewController.itemId = notificationData.itemId
          // Present the viewController
          if let navigationController = window?.rootViewController as? UINavigationController {
              navigationController.pushViewController(viewController, animated: true)
          }

      // Print full message.
      print(userInfo)

      return UIBackgroundFetchResult.newData
    }

}
extension AppDelegate :MessagingDelegate{
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
      print("Firebase registration token: \(String(describing: fcmToken))")

      let dataDict: [String: String] = ["token": fcmToken ?? ""]
      NotificationCenter.default.post(
        name: Notification.Name("FCMToken"),
        object: nil,
        userInfo: dataDict
      )
      // TODO: If necessary send token to application server.
      // Note: This callback is fired at each app startup and whenever a new token is generated.
    }

}

