//
//  AppDelegate.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/09.
//  Copyright © 2022 yuoku. All rights reserved.
//

import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
  ) -> Bool {
    print(#function)

    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
      print("Permission granted: \(granted)")
    }
    UNUserNotificationCenter.current().delegate = self

    // Reset badge number
    UIApplication.shared.applicationIconBadgeNumber = 0

    return true
  }
}

// MARK: - UNUserNotificationCenterDelegate
extension AppDelegate: UNUserNotificationCenterDelegate {
  // アプリ起動中にプッシュ通知の表示するか
  func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    willPresent notification: UNNotification
  ) async -> UNNotificationPresentationOptions {
    return [.banner, .sound]
  }

  func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    didReceive response: UNNotificationResponse
  ) async {
    let userInfo = response.notification.request.content.userInfo
    print(#function, userInfo)

    guard let urlString = userInfo["url"] as? String,
      let url = URL(string: urlString)
    else {
      return
    }
    await UIApplication.shared.open(url)
  }
}
