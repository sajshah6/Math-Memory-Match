//
//  CollectionViewCell.swift
//  MyGame
//
//  Created by Sajan Shah on 9/4/20.
//  Copyright © 2020 Sajan Shah. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var frontImage: UIImageView!
    
    @IBOutlet weak var mathExpression: UILabel!
    
    @IBOutlet weak var backImage: UIImageView!
    
    var label:Label?

    func setCard(label: Label) {
        
        self.label = label
        
        // https://dribbble.com/shots/6648861-Card-Game-Design
        frontImage.image = UIImage(named: "frontCard")
        mathExpression.text = label.expression
        
        if label.isMatched == true {
            
            backImage.alpha = 0
            frontImage.alpha = 0
            mathExpression.alpha = 0
            return
        }
        else {
            
            backImage.alpha = 1
            frontImage.alpha = 1
            mathExpression.alpha = 1
        }
        
        if label.isFlipped == true {
            flipUp(time: 0)
        }
        else {
            flipDown(time: 0, time2: 0)
        }
    }

    func flipUp(time:TimeInterval = 0.3) {
        
        UIView.transition(from: backImage, to: frontImage, duration: time, options: [.showHideTransitionViews, .transitionFlipFromLeft], completion: nil)
        
        label?.isFlipped = true
    }

    func flipDown(time:TimeInterval = 0.3, time2:TimeInterval = 0.5) {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time2) {
            
            UIView.transition(from: self.frontImage, to: self.backImage, duration: time, options: [.showHideTransitionViews, .transitionFlipFromLeft], completion: nil)
        }
        
        label?.isFlipped = false
    }

    func remove() {
        
        backImage.alpha = 0
        
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseOut, animations: {
            
            self.frontImage.alpha = 0
            self.mathExpression.alpha = 0
            
        }, completion: nil)
    }
}
