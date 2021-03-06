//
//  ViewController.swift
//  ConcentrationSTF11
//
//  Created by mamba on 2020/1/6.
//  Copyright © 2020 mamba. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: test mark mark mark
    // TODO: test todo todo todo
    
    /// Props
    // game 变量 翻牌游戏
    // 加lazy. 因为这里Concentration在初始化,self还没初始化好,属性必须在self初始化之后. 所以这里. 一个依赖着另一个.
    // 但是加了lazy不能用property Observer(didSet) .
    // 除以2,因为有两对.因为我在Concentration每次会生成一对card
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    //Concentration（）是class免费的构造器
    
    var numberOfPairsOfCards: Int {
//        get {
//            return (cardButtons.count + 1) / 2
//        }
        //如果是readonly的属性,可以去掉get{}
        return (cardButtons.count + 1) / 2
    }
    
    // flipCount 翻牌翻过的次数 , 运用property Observer. didSet
    private(set) var flipCount: Int = 0 {
        // didSet表示每次setFlipCount变量的时候，都会走到这里下面的。
        didSet {
            updateFlipCountLabel()
        }
    }
    
    private func updateFlipCountLabel() {
        let attributes: [NSAttributedString.Key:Any] = [
            .strokeWidth : 5.0,
            .strokeColor : UIColor.orange
        ]
        let attrStr = NSAttributedString(string: "Flips: \(flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attrStr
    }
    
    /// UIs
    // lb flip count
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
            updateFlipCountLabel()
        }
    }
    // IBOutlet collection 数组 所有card button
    // @IBOutlet var cardButtons: Array<UIButton>!
    @IBOutlet private var cardButtons: [UIButton]!
    //直接用了IBOutlet的collection,这样可以直接取到按钮数组的下标!
    
    // 点击卡片 IBAction
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        //因为. func firstIndex(of element: UIButton) -> Int? 返回的是可选类型. 拿到按钮数组的index下标
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
    }
    
    private func updateViewFromModel() {
        //var indices: Range<Int> { get }
        //for index in 0..<cardButtons.count {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle( emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0) : #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
            }
        }
    }
        
//    private var emojiChoices: [String] = ["🎃","👻","😝","🦇","🐖","🐱","🐔","🍬","🐦","🚄","🚗"]
    private var emojiChoices: String = "🎃👻😝🦇🐖🐱🐔🍬🐦🚄🚗"
    
    
    // var emoji = Dictionary<Int,String>()
    private var emoji = [Int:String]() // 声明字典, 简写
    
    private func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            // 把删掉的对应的set到字典里
            emoji[card.identifier] = String(emojiChoices.remove(at: randomStringIndex))
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

// 扩展Int类型,加属性
extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))  // 明确类型转换.
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
