//
//  AppDelegate.swift
//  STUDYSwift
//
//  Created by sherwin.chen on 2019/12/10.
//  Copyright © 2019 sherwin.chen. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    lazy var window: UIWindow? = {
        let window = UIWindow.init(frame: UIScreen.main.bounds)
        window.backgroundColor = .white
        return window
    }()

    var rootViewController: ViewController? {
        didSet {
            self.window?.rootViewController = rootViewController
        }
    }

    static func identifier() -> String {
        return "\(self.self)"
    }


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.



        //2.1 基础 部分
        //BaseGrammar .main()

        //2.2 基本运算符（Basic Operators）
        //BasicOperators.main()

        //2.3 字符串
        //SwStrings.main()

        //2.4 集合类型
        //Collection.main()

        //2.5 控制流
        //ControlFlow.main()

        //2.6 函数
        //Functions.main()

        //2.7 Closures
        Closures.main()

        return true
    }


}

