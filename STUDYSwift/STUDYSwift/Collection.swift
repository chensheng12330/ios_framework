//
//  Collection.swift
//  STUDYSwift
//
//  Created by sherwin.chen on 2020/1/8.
//  Copyright © 2020 sherwin.chen. All rights reserved.
//

import Foundation

class Collection: NSObject {
    class func main()->(Void) {

        //字典
        /*
         字典是一种存储多个相同类型的值的容器。每个值（value）都关联唯一的键（key），键作为字典中的这个值数据的标识符。和数组中的数据项不同，字典中的数据项并没有具体顺序。我们在需要通过标识符（键）访问数据的时候使用字典，
         */
        //创建一个空字典
        var namesOfIntegers = [Int: String]()
        

        //集合（Sets）
        /*
         集合(Set)用来存储相同类型并且没有确定顺序的值。
         当集合元素顺序不重要时或者希望确保每个元素只出现一次时可以使用集合而不是数组。

         */
        //创建和构造一个空的集合
        var setV = Set(arrayLiteral: 1,2,3,4)
        setV.insert(3) //重复元素,不会纳入集合中.
        setV.insert(5)
        DBLog.info.cat(setV)

        var favorSetV : Set<String> = ["1","2","3","4"]
        favorSetV.insert("5")
        favorSetV.isEmpty
        favorSetV.removeFirst()
        DBLog.cat(favorSetV)
        favorSetV.remove("1")
        DBLog.cat(favorSetV)

        //遍历一个集合
        for genre in favorSetV.sorted() {
            print("\(genre)")
        }

        //基本集合操作
        //交集
        //并集
        //子集
        //包含
        //被包含
        //
        let oddDigits: Set = [1, 3, 5, 7, 9]
        let evenDigits: Set = [0, 2, 4, 6, 8]
        let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]

        var info = oddDigits.union(evenDigits).sorted()
        DBLog.info.cat(info)

        info = oddDigits.intersection(evenDigits).sorted()
         DBLog.info.cat(info)

        info = oddDigits.subtracting(singleDigitPrimeNumbers).sorted()
         DBLog.info.cat(info)

        info = oddDigits.symmetricDifference(singleDigitPrimeNumbers).sorted()
         DBLog.info.cat(info)
        
        return;

        //创建一个带有默认值的数组
        var threeD = Array(repeating: 0.8, count: 4 )
        DBLog.cat(threeD)

        //通过两个数组相加创建一个数组
        var addD = threeD + Array(threeD)
        DBLog.cat(addD)

        addD += [1,2]
        DBLog.cat(addD)

        //使用下标语法来获取数组中的数据项
        var subAr = addD[1...3]
        DBLog.cat(subAr)

        addD[1...3] = [2,3,4]
        DBLog.cat(addD)

        addD.insert(10086, at: 0)
        DBLog.cat(addD)
        addD.removeFirst()
        DBLog.cat(addD)

    //如果我们同时需要每个数据项的值和索引值，可以使用enumerated()方法来进行数组遍历。enumerated()返回一个由每一个数据项索引值和数据值组成的元组。我们可以把这个元组分解成临时常量或者变量来进行遍历：
        for (index, value) in addD.enumerated() {
            DBLog.cat("Item \(String(index + 1)): \(value)")
        }


        return
        //创建一个空数组
        var somInts = [Int]()
        DBLog.cat(somInts.count)

        somInts .append(1024)
        DBLog.cat(somInts)

        somInts = []
        DBLog.cat(somInts)




    }
}
