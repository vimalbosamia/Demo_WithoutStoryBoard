//
//  AppDelegate.swift
//  iOS-Proficiency-Excercise-Vimal
//
//  Created by Vimal on 24/06/20.
//  Copyright © 2020 Vimal. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let navigationController = UINavigationController()
        let viewModel = ViewModel()
        let viewController = ViewController(viewModel: viewModel)
        navigationController.viewControllers = [viewController]
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
}

