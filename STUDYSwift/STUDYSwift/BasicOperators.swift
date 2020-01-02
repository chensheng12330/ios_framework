//
//  BasicOperators.swift
//  STUDYSwift
//
//  Created by sherwin.chen on 2019/12/30.
//  Copyright © 2019 sherwin.chen. All rights reserved.
//

import Foundation

class BasicOperators: NSObject {
    class func main() -> Void {

        //区间运算符

        //闭区间运算符
        for index in 1...5 {
            DBLog.cat(index)
        }

        //半开区间运算符
        let names = ["Anna", "Alex", "Brian", "Jack"]
        let count = names.count
        for i in 0..<count {
            //DBLog.cat("第 \(i + 1) 个人叫 \(names[i])")
        }

        for name in names[1..<3] {
            DBLog.cat(name)
        }


        //单侧区间
        for j in 2..<count {
            DBLog.cat("第 \(j + 1) 个人叫 \(names[j])")
        }

        //空合运算符（Nil Coalescing Operator）
        let defCol = "red"
        var uCol : String? = nil

        var uN = uCol ?? defCol
        DBLog.cat(uN)


        //如果两个元组的元素相同，且长度相同的话，元组就可以被比较
        var bv : Bool = (1,"ze") < (2,"app")
        DBLog.cat(bv)

    }
}
