//
//  AppDelegate.swift
//  Swifty-Forecast
//
//  Created by Pawel Milek on 26/09/16.
//  Copyright © 2016 Pawel Milek. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    setupStyle()
    return true
  }
}


extension AppDelegate {
  
  func setupStyle() {
    setStatusBarStyle()
    setNavigationBarStyle()
  }
  
}


// MARK: - Set UINAvigationBar Attributes
private extension AppDelegate {
  
  func setStatusBarStyle() {
    UIApplication.shared.statusBarStyle = .default
  }
  
  func setNavigationBarStyle() {
    func setTransparentBackground() {
      UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
      UINavigationBar.appearance().shadowImage = UIImage()
      UINavigationBar.appearance().isTranslucent = true
      UINavigationBar.appearance().clipsToBounds = false
    }
    
    func setTitleTextColor() {
      let textAttributes = [NSAttributedStringKey.foregroundColor : UIColor.blackShade]
      UINavigationBar.appearance().titleTextAttributes = textAttributes
    }
    
    func setBarButtonItemColor() {
      UINavigationBar.appearance().tintColor = .blackShade
    }
    
    setTransparentBackground()
    setTitleTextColor()
    setBarButtonItemColor()
  }
  
}
