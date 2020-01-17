//
//  Closures.swift
//  STUDYSwift
//
//  Created by sherwin.chen on 2020/1/16.
//  Copyright © 2020 sherwin.chen. All rights reserved.
//

import Foundation

class Closures: NSObject {
    class func main() -> Void {

        let clo = Closures()
        //clo.inmain()

        clo.trysomeFunctionThatTakesAClosure()
    }

    func inmain() -> Void {

        let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        var sortN = names.sorted(by: backward )
        DBLog.info.cat(sortN)

        let reverdNames = names.sorted(by: { ( s1:String, s2:String) -> Bool in
            return s1 < s2
        })
        DBLog.info.cat(reverdNames)

        //闭包表达式语法
        /******
         >闭包表达式参数 可以是 in-out 参数，但不能设定默认值。也可以使用具名的可变参数
         >元组也可以作为参数和返回值
         { (parameters) -> returnType in
             statements
         }
         *****/

        let namS2 = names.sorted { (s1, s2) -> Bool in
            return s1>s2
        }
        DBLog.info.cat(namS2)


        //参数名称缩写
        /**
         Swift 自动为内联闭包提供了参数名称缩写功能，你可以直接通过 $0，$1，$2 来顺序调用闭包的参数
         reversedNames = names.sorted(by: { $0 > $1 } )
         */

        //运算符方法
        //reversedNames = names.sorted(by: >)
    }

    func backward(_ s1: String, _ s2: String) -> Bool {
        return s1 > s2
    }

    //尾随闭包
    /**
     如果你需要将一个很长的闭包表达式作为最后一个参数传递给函数，可以使用尾随闭包来增强函数的可读性。尾随闭包是一个书写在函数括号之后的闭包表达式，函数支持将其作为最后一个参数调用。在使用尾随闭包时，你不用写出它的参数标签：
     */
    func someFunctionThatTakesAClosure(closure: () -> Void) {
        // 函数体部分
        DBLog.cat("主调")
        closure()
    }

    func trysomeFunctionThatTakesAClosure() {

        //如果闭包表达式是函数或方法的唯一参数，则当你使用尾随闭包时，你甚至可以把 () 省略掉
        someFunctionThatTakesAClosure {
            DBLog.cat("回调")
        }
    }


    //逃逸闭包
    var completionHandlers: [() -> Void] = []
    func somefucEscapClo(compHandle:@escaping () -> Void) ->Void {
        completionHandlers.append(compHandle)
    }


}
