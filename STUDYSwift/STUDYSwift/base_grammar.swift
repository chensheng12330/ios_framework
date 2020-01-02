//
//  base_grammar.swift
//  STUDYSwift
//
//  Created by sherwin.chen on 2019/12/27.
//  Copyright © 2019 sherwin.chen. All rights reserved.
//

import Foundation

class BaseGrammar: NSObject {

    class func main() -> Void {

        /*错误处理
        do {
            try throwing expression
        } catch pattern {
            statements
        }*/


        //可选类型>>>使用可选类型（optionals）来处理值可能缺失的情况
        //nil不能用于非可选的常量和变量。如果你的代码中有常量或者变量需要处理值缺失的情况，请把它们声明成对应的可选类型。
        //Swift 中，nil 不是指针——它是一个确定的值，用来表示值缺失。任何类型的可选状态都可以被设置为 nil，不只是对象类型。
        var sRcode:Int? = 404
        sRcode = nil

        ///如果一个变量之后可能变成nil的话请不要使用隐式解析可选类型
        ///let aab = sRcode!

        if sRcode == nil {
            sRcode = Int(500)
        }



        //元组（tuples）
        //元组在临时组织值的时候很有用，但是并不适合创建复杂的数据结构。
        //如果你的数据结构并不是临时使用，请使用类或者结构体而不是元组
        let httpcode = (200, "ok")

        DBLog.info.cat("\(httpcode.0)")
        DBLog.info.cat("\(httpcode.1)")

        let (aa,bb) =  httpcode//(404,"not fond")
        DBLog.info.cat("\(aa) - \(bb)")

        let httpC = (code : 200, value : "ok")
        DBLog.info.cat("\(httpC.code) - \(httpC.value)")

        //布尔
        let aBBB : Bool = Bool(truncating: 100)
        if aBBB {
            DBLog.info.cat("\(aBBB)")
        }

        //类型别名
        typealias AABB = UInt64
        DBLog.info.cat("\(AABB.max)")

        // 数据  转换
        let twoT : UInt16 = 2_000
        let one  : UInt8  = 1
        //let add  : UInt8  = one + UInt8(twoT)  runtime error.
        let add  : UInt16  = UInt16(one) + twoT

        let dOne : Double = 20.99933
        let dAdd : UInt16 = add + UInt16(dOne)

        DBLog.info.cat("\(add) - \(dAdd)")
        /*
         一个二进制数，前缀是0b
         一个八进制数，前缀是0o
         一个十六进制数，前缀是0x
         指数,1.25e2 表示 1.25 × 10^2, 1.25e-2 表示 1.25 × 10^-2

         */

        let bInt = 0b001
        let oInt = 0o001
        let hInt = 0x001
        let eInt = 1.25e1
        let seInt = 1.25e-1

        //数值类字面量可以包括额外的格式来增强可读性。整数和浮点数都可以添加额外的零并且包含下划线，并不会影响字面量：
        let justOverOneMillion = 1_000_000.000_000_1

        DBLog.info.cat("进制数: \(bInt) - \(oInt) - \(hInt)- \(eInt)- \(seInt) -\(justOverOneMillion)")


        let minV = UInt8.min
        let maxV = UInt8.max

        DBLog.info.cat("UInt: \(minV) - \(maxV)")


        let nickName: String? = "m"
        let fullName: String = "John Appleseed"
        let informalGreeting = "Hi \(nickName ?? fullName)"

        DBLog.info.cat(informalGreeting);

        var inPN = "ABC"
        var optN:String? = nil //"sherwin"
        var greeting = "hello"

        if let name = optN {
            greeting  = "\(greeting), \(name)";
        }
        else {
            greeting = "NO"
        }

        let ab = [1,2,34,5,6,]
        var cou = 0
        for va in ab {
            if va > 3 { cou += 1 }
            else { cou -= 1 }
        }
        /*
        /*


                let label = "The width is"
                let width = 94
                var widthLabel = label + String(width)
        */

                let implicitInteger = 70
                let implicitDouble = 70.0
                var explicitDouble: Double = 70


                explicitDouble = Double(implicitInteger) + implicitDouble
        */

    }
}
