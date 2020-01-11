//
//  SwStrings.swift
//  STUDYSwift
//
//  Created by sherwin.chen on 2020/1/2.
//  Copyright © 2020 sherwin.chen. All rights reserved.
//

import Foundation

class SwStrings: NSObject {
    class func main()->() { //Void = ()

        //可扩展的字形群集
        let precomposed: Character = "\u{D55C}"
        let decomposed: Character = "\u{1112}\u{1161}\u{11AB}"
        DBLog.cat(precomposed)
        DBLog.cat(decomposed)

        return
        //字符串插值 (数据字符串化)
        let num: NSInteger = 1024
        let fnum: Float = 1024.00
        let str: String = "1024"
        var apptStr :String = "nums:  \(num) , \(fnum), \(str)"
        DBLog.cat(apptStr)

        let exCha : Character  = "!"
        DBLog.cat(exCha)

        let catChs:[Character] = ["c","a","t","🐱"]
        DBLog.cat(catChs)

        //可通过for-in循环来遍历字符串
        for ch in "Dog! 汪汪" {
            DBLog.cat(ch);
        }

        //单行
        let someStr = "123 4344"

        //多行字符串字面量""" """
        let muuSomeStr =
        """
        adfb
        adfb
        adfasf
        dfa
        """
        DBLog.cat(muuSomeStr)
        DBLog.error.cat(someStr)
    }
}
