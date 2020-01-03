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
