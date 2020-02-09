//
//  Card.swift
//  ConcentrationSTF11
//
//  Created by teason23 on 2020/2/6.
//  Copyright © 2020 mamba. All rights reserved.
//1.结构体没有继承
//2.结构体是值类型, class是引用类型.
//3.结构体会被copy, 而不是引用

import Foundation


struct Card {
    
    var isFaceUp     = false
    var isMatched    = false
    var identifier: Int
    
    
    // 静态变量 随着类而储存, 而不是跟着实例.
    static var identifierFactory = 0
    // 静态方法
    static func getUniqueIdentifier() -> Int {
        Card.identifierFactory += 1
        return Card.identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
 
