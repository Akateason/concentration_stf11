//
//  ViewController.swift
//  ConcentrationSTF11
//
//  Created by mamba on 2020/1/6.
//  Copyright © 2020 mamba. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // 变量. 翻牌游戏
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    // 翻牌翻过的次数
    var flipCount: Int = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
        
    // lb flip count
    @IBOutlet weak var flipCountLabel: UILabel!
    
    // IBOutlet collection 数组 所有card button
    @IBOutlet var cardButtons: [UIButton]!
//    @IBOutlet var cardButtons: Array<UIButton>!
    
    // var emojiChoices: Array<String> = ["🎃","👻","🎃","👻"]   复制类型已经固定,所以类型可以省略
    var emojiChoices = ["🎃","👻","🎃","👻"]
    
    // 点击卡片 IBAction
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        //因为. func firstIndex(of element: UIButton) -> Int? 返回的是可选类型.
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            print("cardNumber = \(cardNumber)")
            flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
        } else {
            print("chosen card was not in cardButtons")
        }
    }
    
    // 翻转卡片 func
    func flipCard(withEmoji emoji: String, on button: UIButton) {
        if button.currentTitle == emoji {
            button.setTitle("", for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        } else {
            button.setTitle(emoji, for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
    
    
    
    
    
    
    

}

 
