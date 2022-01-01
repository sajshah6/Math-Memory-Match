//
//  SecondViewController.swift
//  MyGame
//
//  Created by Sajan Shah on 8/31/20.
//  Copyright © 2020 Sajan Shah. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var timer: UILabel!
    
    @IBOutlet weak var highScoreLabel: UILabel!
    
    let r = IdentityLabel()
    var labelArray = [Label]()
    
    var time:Timer?
    var ms:Int = 0
    var sec:Double = 0
    var min:Int = 0
    
    var highScoreMin:Int!
    var highScoreSec:Double!
    
    var firstFlippedCard:IndexPath?
    
    var soundEffect = AllSounds()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelArray = r.getLabels()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        time = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        RunLoop.main.add(time!, forMode: .common)
        
        let userDefaults = Foundation.UserDefaults.standard
        let value = userDefaults.integer(forKey: "HIGHSCOREMIN")
        highScoreMin = value
        let value2 = userDefaults.double(forKey: "HIGHSCORESEC")
        highScoreSec = value2
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        soundEffect.play(sound: .shuffle)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let userDefaults = Foundation.UserDefaults.standard
        let value = userDefaults.integer(forKey: "HIGHSCOREMIN")
        let value2 = userDefaults.double(forKey: "HIGHSCORESEC")
        
        if value == 0 && value2 == 0.0 {
            
            highScoreLabel.text = String("HighScore:")
        }
        else {
            
            highScoreLabel.text = String("HighScore: \(value):\(value2)")
        }
    }
    
    @objc func updateTime() {
        
        ms+=1
        
        
        sec = Double(ms)/100.0
        if (ms == 6000) {
            sec = 0
            ms = 0
            min+=1
        }
        
        timer.text = String("Time: \(min):\(sec)")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return labelArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let labelCell = cell as? CollectionViewCell
        
        let label = labelArray[indexPath.row]
        
        labelCell?.setCard(label: label)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let card = collectionView.cellForItem(at: indexPath) as? CollectionViewCell
        
        if card?.label?.isFlipped == false && card?.label?.isMatched == false {
            
            card?.flipUp()
            
            soundEffect.play(sound: .flip)
            
            if firstFlippedCard == nil {
                
                firstFlippedCard = indexPath
            }
            else {
                
                match(indexPath)
            }
        }
    }
    
    func match(_ secondFlippedCard:IndexPath) {
        
        let labelOne = labelArray[firstFlippedCard!.row]
        let labelTwo = labelArray[secondFlippedCard.row]
        
        let labelOneCell = collectionView.cellForItem(at: firstFlippedCard!) as? CollectionViewCell
        let labelTwoCell = collectionView.cellForItem(at: secondFlippedCard) as? CollectionViewCell
        
        if labelOne.value == labelTwo.value {
            
            soundEffect.play(sound: .correct)
            
            labelOne.isMatched = true
            labelTwo.isMatched = true
            
            labelOneCell?.remove()
            labelTwoCell?.remove()
            
            gameEnd()
        }
        else {
            
            soundEffect.play(sound: .wrong)
            
            labelOne.isFlipped = false
            labelTwo.isFlipped = false
            
            labelOneCell?.flipDown()
            labelTwoCell?.flipDown()
        }
        
        firstFlippedCard = nil
    }
    
    func gameEnd() {
        
        var win = true
        
        for label in labelArray {
            
            if label.isMatched == false {
                
                win = false
                break
            }
        }
        
        if win == true {
            
            time?.invalidate()
            
            if highScoreMin == 0 && highScoreSec == 0.0 {
                
                let userDefaults = Foundation.UserDefaults.standard
                userDefaults.setValue(min, forKey: "HIGHSCOREMIN")
                userDefaults.setValue(sec, forKey: "HIGHSCORESEC")
                alert(title: "New High Score", message: "You beat your high score!")
            }
            else if highScoreMin > min {
                
                let userDefaults = Foundation.UserDefaults.standard
                userDefaults.setValue(min, forKey: "HIGHSCOREMIN")
                userDefaults.setValue(sec, forKey: "HIGHSCORESEC")
                alert(title: "New High Score", message: "You beat your high score!")
            }
            else if highScoreMin == min {
                if highScoreSec > sec {
                    
                    let userDefaults = Foundation.UserDefaults.standard
                    userDefaults.setValue(sec, forKey: "HIGHSCORESEC")
                    alert(title: "New High Score", message: "You beat your high score!")
                }
                else {
                    alert(title: "Congratulations", message: "You've won!")
                }
            }
            else {
                alert(title: "Congratulations", message: "You've won!")
            }
        }
    }
    
    func alert(title:String, message:String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Return to Home", style: .default, handler: {(action) in
            self.dismiss(animated: false, completion: nil)
        })
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func close(_ sender: Any) {
    
        self.dismiss(animated: false, completion: nil)
    }
}
