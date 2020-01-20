//
//  Enumerations.swift
//  STUDYSwift
//
//  Created by sherwin.chen on 2020/1/19.
//  Copyright © 2020 sherwin.chen. All rights reserved.
//  枚举
/**
 枚举类型是一等（first-class）类型。它们采用了很多在传统上只被类（class）所支持的特性，例如计算属性（computed properties），用于提供枚举值的附加信息，实例方法（instance methods），用于提供和枚举值相关联的功能。枚举也可以定义构造函数（initializers）来提供一个初始值；可以在原始实现的基础上扩展它们的功能；还可以遵循协议（protocols）来提供标准的功能
 */

import Foundation
class Enumerations: NSObject {
    class func main() -> Void {

        var productBarcode = Barcode.upc(8, 3, 32, 4)
        var productBarcode1 = Barcode.qrCode("abcd")

        DBLog.cat(productBarcode)
        DBLog.cat(productBarcode1)

        testBarcode(code: productBarcode)
        testBarcode(code: productBarcode1)

        //使用枚举成员的rawValue属性可以访问该枚举成员的原始值
        CompassPoint.north.rawValue
        
        return

        let enuCP : CompassPoint = CompassPoint.earth
        CompassPoint.north.out()

        switch enuCP {
        case .earth:
            DBLog.cat("earth")
        case .south, .east , .west:
            DBLog.cat("south, east, west")
        default:
            DBLog.cat("nothing.")
        }


    }
}

/**
 不会被隐式地赋值为0，1，2和3。相反，这些枚举成员本身就是完备的值，这些值的类型是已经明确定义好的CompassPoint类型
 */
enum CompassPoint : Int {
    case north = 1
    case south
    case east
    case west
    case mercury, venus, earth, mars, jupiter, saturn, uranus, neptune

    func out() -> Void {
        DBLog.cat("i'm out.")
    }

}

/** 关联值
可以定义 Swift 枚举来存储任意类型的关联值，如果需要的话，每个枚举成员的关联值类型可以各不相同。枚举的这种特性跟其他语言中的可识别联合（discriminated unions），标签联合（tagged unions），或者变体（variants）相似

 */

enum Barcode {
    case upc(Int,Int,Int,Int) //多元关联值
    case qrCode(String)
}

func testBarcode(code:Barcode) -> Void {
    switch code {
    case .upc(let numberSystem, let manufacturer, let product, let check):
        print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
    case .qrCode(let productCode):
        print("QR code: \(productCode).")
    }
}
