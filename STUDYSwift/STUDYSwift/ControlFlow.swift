//
//  ControlFlow.swift
//  STUDYSwift
//
//  Created by sherwin.chen on 2020/1/10.
//  Copyright © 2020 sherwin.chen. All rights reserved.
//  控制流

import Foundation
class ControlFlow: NSObject {
    class func main()->Void {
        //For-In 循环
        let Arr :Array = Array(arrayLiteral: 1,2,3,4,5)
        for name in Arr{
            DBLog.cat(name)
        }

        let numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
        for (animalName, legCount) in numberOfLegs {
            DBLog.cat("\(animalName)s have \(legCount) legs")
        }

        //步进
        let minutes = 60
        let minuteInterval = 5
        for tickMark in stride(from: 0, to: minutes, by: minuteInterval) {
            // 每5分钟渲染一个刻度线 (0, 5, 10, 15 ... 45, 50, 55)
            print(tickMark)
            //print(" ")
        }
        ////
        //while 条件 {  }
        //repeat { } while 条件  {}

        //Switch
        //为了让单个case同时匹配a和A，可以将这个两个值组合成一个复合匹配
        let anotherCharacter: Character = "h"
        switch anotherCharacter {
        case "a","g": //复合匹配
            DBLog.cat("复合匹配 ")
        case "a"..."k": //区间匹配
            DBLog.cat("区间匹配 ")
        default:
            DBLog.cat("default out.")
        }

        //元组匹配
        /**
         我们可以使用元组在同一个switch语句中测试多个值。元组中的元素可以是值，也可以是区间。另外，使用下划线（_）来匹配所有可能的值。
         */
        let somePoint = (1, 1)
        switch somePoint {
        case (0, 0):
            print("\(somePoint) is at the origin")
        case (_, 0):
            print("\(somePoint) is on the x-axis")
        case (0, _):
            print("\(somePoint) is on the y-axis")
        case (-2...2, -2...2):
            print("\(somePoint) is inside the box")
        case let (x, y) where x == -y:
            print("\(somePoint) 值绑定/ where条件判断")
        default:
            print("\(somePoint) is outside of the box")
        }

        //值绑定（Value Bindings）  划重点.
        let anotherPoint = (2, 0)
        switch anotherPoint {
        case (let x, 0):
            print("on the x-axis with an x value of \(x)")
        case (0, let y):
            print("on the y-axis with a y value of \(y)")
        case let (x, y):
            print("somewhere else at (\(x), \(y))")
        }

        //检测 API 可用性
        if #available(iOS 13, *) {
            
        }

    }
}
