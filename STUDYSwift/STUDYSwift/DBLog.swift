//
//  DBLog.swift
//  GFInsurance
//
//  Created by sherwin.chen on 2019/12/12.
//  Copyright © 2019 SSK. All rights reserved.
//

import Foundation
/// 输出日志
///
/// - info: normal
/// - success: success
/// - error: error
/// - warning: 警告，可不处理的
enum DBLog {
    case info
    case success
    case error
    case warning
}

extension DBLog {

    /// 输出默认info的日志
    static func cat<T>(_ message: T, file: String = #file, method: String = #function, line: Int = #line) {
        self.info.cat(message)
    }

    /// 输入日志，根据类型，区别符号
    ///
    /// - Parameters:
    ///   - message: 显示的信息
    func cat<T>(_ message: T, file: String = #file, method: String = #function, line: Int = #line) {

        #if DEBUG
            var log: String
            switch self {
            case .info:
                log = " 🎉 "
            case .success:
                log = " ✅ "
            case .error:
                log = " ❌ "
            case .warning:
                log = " ⚠️ "
            }
        //Thread.current.name  ↓↓↓↓
            //print(">\(NSDate()),\((file as NSString).lastPathComponent)[\(line)],\(method):\n\(log)")
        print(">\(log)\(NSDate()),\((file as NSString).lastPathComponent)[\(line)],\n>\( (Thread.current.isMainThread ? " [InMain]" : "")) \(method) ↓↓↓↓\n \(message) \n")
        #endif
    }
}
