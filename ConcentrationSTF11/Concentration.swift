//
//  Concentration.swift
//  ConcentrationSTF11
//
//  Created by teason23 on 2020/2/6.
//  Copyright © 2020 mamba. All rights reserved.
//翻牌游戏 class
//类 自动有一个构造方法不带参数的  free Init

import Foundation


class Concentration {
    
//    var cards = Array<Card>()  , 下面用了简洁的写法
    var cards = [Card]()
    
    func chooseCard(at index: Int) {
        
    }
    
    
    /// 初始化. 告诉我多少张牌. 然后我准备好.
    /// - Parameter numberOfPairsOfCards: 多少张牌的翻牌游戏.
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        // todo: shuffle the cards

        
    }
    
    
    
    
    
// 下面是 init(numberOfPairsOfCards: Int) { 这个方法的详细注解
    init(numberOfPairsOfCards2: Int) {
// "_"代表, 可以忽略这个变量.
        for _ in 1...numberOfPairsOfCards2 {

            let card = Card()
//--- 1. ---
//            let matchingCard = card  // 因为结构体是copy新值, 所以不用new了,可以这样写.
//            cards.append(card)
//            cards.append(matchingCard) // 因为结构体是copy新值, 所以不用new了,所以这行可以 写 append card.
//--- 2. --- 于是有了第二种写法. 因为当你传递结构体的时候, 你在copying他们
//            cards.append(card)
//            cards.append(card)
//--- 3. --- 继续简写, cards数组里加两个新值.
            cards += [card, card]
            
        }
    }

    
    
    
    
}
