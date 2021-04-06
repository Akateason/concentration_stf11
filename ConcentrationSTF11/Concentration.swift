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
    
    //赋值右边（）是数组初始化方法
    //var cards = Array<Card>()  , 下面用了简洁的写法
    var cards = [Card]()
    
    //我要记录那一张朝上的卡片. indexOfOneAndOnlyFaceUpCard: Int?  可选类型的使用. 代表这张卡可以为nil
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    
    //做下面几件事1.
    /// 选择卡片
    ///做下面几件事
    ///1.忽略已经配对了的卡片.
    /// 1. 没有卡片朝上. 我选了, 就翻过来
    /// 2. 两张卡片朝上, 有配对了和没配对情况. 然后我要开始新一轮的配对
    /// 3. 一张卡片朝上,
    /// 我要记录那一张朝上的卡片. indexOfOneAndOnlyFaceUpCard: Int?  可选类型的使用. 代表这张卡可以为nil
    ///
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // 3. check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil //置空.
                
            } else {
                // 1 and 2 . either no cards or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    
    /// 初始化. 告诉我多少张牌. 然后我准备好.
    /// @numberOfPairsOfCards: 多少张牌的翻牌游戏.
    init(numberOfPairsOfCards: Int) {
        // ...是sequence
        //这里...表示从1开始<=numberOfPairsOfCards包含
        //如果是..<表示从1开始<numberOfPairsOfCards不包含
        //for _ in 的 "_"代表, 可以忽略这个变量.
        for _ in 1...numberOfPairsOfCards {
            let card = Card() //结构体的初始化
            cards += [card, card]
        }
        // shuffle the cards洗牌
        cards = cards.shuffled()
    }
    
    /* 这一段非常精彩,讲了上面的简写的思路!
     下面是 init(numberOfPairsOfCards: Int) { 这个方法的详细注解
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
     又因为 copy, 所以这里[card,card] identifier是一样的.  加进去后面才能matched .
     }
     }
     */
    
    
    
    
}
