//
//  ViewController.swift
//  ConcentrationSTF11
//
//  Created by mamba on 2020/1/6.
//  Copyright © 2020 mamba. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

/// Props
    // game 变量 翻牌游戏
    // 加lazy. 因为属性必须在self初始化之后. 所以这里. 一个依赖着另一个.
    // 但是加了lazy不能用property Observer(didSet) .
    // 除以2,因为有两对.  因为我在Concentration每次会生成一对card
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    // flipCount 翻牌翻过的次数 , 运用property Observer. didSet
    var flipCount: Int = 0 {
        // didSet表示每次setFlipCount变量的时候，都会走到这里下面的。
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
        
/// UIs
    // lb flip count
    @IBOutlet weak var flipCountLabel: UILabel!
    // IBOutlet collection 数组 所有card button
    // @IBOutlet var cardButtons: Array<UIButton>!
    @IBOutlet var cardButtons: [UIButton]!
    
    
    // 点击卡片 IBAction
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        //因为. func firstIndex(of element: UIButton) -> Int? 返回的是可选类型. 拿到按钮数组的index下标
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
    }
            
    func updateViewFromModel() {
        //var indices: Range<Int> { get }
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0) : #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
            }
        }
    }
    
    
    var emojiChoices: [String] = ["🎃","👻","😝","🦇","🐖","🐱","🐔","🍬","🐦","🚄","🚗"]

//    var emoji = Dictionary<Int,String>()
    var emoji = [Int:String]() // 声明字典, 简写
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))  // 明确类型转换.
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    /**
     上面方法 emoji[card.identifier] ?? "?" 这里的注解
     //        if emoji[card.identifier] != nil {
     //            return emoji[card.identifier]!
     //        }
     //        else {
     //            return "?"
     //        }
     // 因为emoji[card.identifier]是个可选类型. 所以这里也可以用if let , 甚至可以用默认值"??" 简写.
     */
}

 
