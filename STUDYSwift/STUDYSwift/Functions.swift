//
//  Functions.swift
//  STUDYSwift
//
//  Created by sherwin.chen on 2020/1/13.
//  Copyright © 2020 sherwin.chen. All rights reserved.
//

import Foundation
class Functions: NSObject {
    class func main()->Void {
        let ar = [20,1,9]
        let fun =  Functions()

        var retV = fun.minMax(array: ar)
        DBLog.info.cat(retV)

        /////

        //let matFunc : (String, String) -> Void = someFunction1


        return
    }

    //1参,单返回值
    func greet(part : String) -> String {

        let matFunc : (_ P1: String, _ P2 : String) -> Void = someFunction1
        someFunction1(NB: "1", defat: "2")

        matFunc("1", "2")


        return ""
    }
    //2参,单返回 值
    func greet(part : String ,part2 : String) -> String {
        return ""
    }
    //无参,无返回值
    func gree2() {

    }
    //多重返回值
    func minMax(array: Array<Int>) -> (min:Int, max:Int) {
        if array.count < 1 {
            return (0,0)
        }

        let one = array.first!
        let two = array.last!
        if one < two {
            return (one , two)
        }

        return (two,one)
    }

    // 指定参数标签
    func greet(person: String, from hometown: String) -> String {
        return "Hello \(person)! Glad you could visit from \(hometown)."
    }
    //如果你不希望为某个参数添加一个标签，可以使用一个下划线(_)来代替一个明确的参数标签
    func someFunction(_ firstParameterName: Int, secondParameterName: Int) {
         // 在函数体内，firstParameterName 和 secondParameterName 代表参数中的第一个和第二个参数值
    }

    //默认参数值
    func someFunction1(NB firP : String, defat :String = "111") -> Void {

    }
    //可变参数
    /**
     一个可变参数（variadic parameter）可以接受零个或多个值。函数调用时，你可以用可变参数来指定函数参数可以被传入不确定数量的输入值。通过在变量类型名后面加入（...）的方式来定义可变参数。

     可变参数的传入值在函数体中变为此类型的一个数组。例如，一个叫做 numbers 的 Double... 型可变参数，在函数体内可以当做一个叫 numbers 的 [Double] 型的数组常量。

     PS: 一个函数最多只能拥有一个可变参数。
     */

    func sum(_ numbers: Int...) -> Int {
        var total : Int = 0
        for number in numbers {
            total += number
        }

        return total
    }

    //输入输出参数
    func swapTwoInts(_ a:inout Int, _ b:inout Int ) -> Void {
        a = 1
        b = 2
    }

    //函数类型作为参数类型
    func greet2(part : String) -> String {

        let matFunc : (_ P1: String, _ P2 : String) -> Void = someFunction1
        someFunction1(NB: "1", defat: "2")

        matFunc("1", "2")

        return ""
    }

    //函数类型作为返回类型
    /**
     可以用函数类型作为另一个函数的返回类型。你需要做的是在返回箭头（->）后写一个完整的函数类型
     */
    func chooseStepFunction(backward: Bool) -> (String) -> String {
        return greet2
    }


    //嵌套函数
    func chooseStepFunction2(backward: Bool) -> (Int) -> Int {

        func stepForward(input: Int) -> Int { return input + 1 }
        func stepBackward(input: Int) -> Int { return input - 1 }
        return backward==true ? stepForward:stepBackward
    }

}

