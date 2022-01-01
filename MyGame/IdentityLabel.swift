//
//  IdentityLabel.swift
//  MyGame
//
//  Created by Sajan Shah on 9/1/20.
//  Copyright © 2020 Sajan Shah. All rights reserved.
//

import Foundation

class IdentityLabel {
    
    func getLabels() -> [Label]{
        
        var createdLabels = [Label]()
        var repeated = [Int]()
        
        while createdLabels.count < 16 {
            
            var y = ""
            var g = 0
            let labelOne = Label()
            let labelTwo = Label()
            var randomNumber = Int.random(in: 1...100)
            
            while repeated.contains(randomNumber) {
                randomNumber = Int.random(in: 1...100)
            }
            labelOne.value = randomNumber
            labelTwo.value = randomNumber
            repeated.append(randomNumber)
            
            while (g != 2){
                var prime = true
                if (randomNumber != 2 && randomNumber != 1){
                    for index in 2...randomNumber-1{
                        if randomNumber % index == 0 {
                            prime = false
                        }
                    }
                }
                
                var a = 2
                var x = 0
                a = 2
                x = 0
                    while (a * randomNumber <= 100) {
                        a+=1
                        x+=1
                    }
                    
                if randomNumber == 1 {
                    let randomNumber2 = Int.random(in: 1...2)
                         
                    if randomNumber2 == 1 {
                        y = "-"
                            
                    }
                    else if randomNumber2 == 2 {
                        y = "÷"
                    }
                }
                else if randomNumber == 100 {
                    let randomNumber2 = Int.random(in: 1...2)
                         
                    if randomNumber2 == 1 {
                        y = "+"
                            
                    }
                    else if randomNumber2 == 2 {
                        y = "*"
                    }
                }
                else if prime == false && x > 0  {
                    let randomNumber2 = Int.random(in: 1...4)
                         
                    if randomNumber2 == 1 {
                        y = "+"
                            
                    }
                    else if randomNumber2 == 2 {
                        y = "-"
                    }
                    else if randomNumber2 == 3 {
                        y = "*"
                    }
                    else {
                        y = "÷"
                    }
                }
                else if prime == true && x > 0{
                    let randomNumber2 = Int.random(in: 1...3)
                         
                    if randomNumber2 == 1 {
                        y = "+"
                    }
                    else if randomNumber2 == 2{
                        y = "-"
                    }
                    else {
                        y = "÷"
                    }
                }
                else if prime == false && x == 0{
                    let randomNumber2 = Int.random(in: 1...3)
                        
                    if randomNumber2 == 1 {
                        y = "+"
                    }
                    else if randomNumber2 == 2{
                        y = "-"
                    }
                    else {
                        y = "*"
                    }
                }
                else if prime == true && x == 0{
                    let randomNumber2 = Int.random(in: 1...2)
                        
                    if randomNumber2 == 1 {
                        y = "+"
                    }
                    else {
                        y = "-"
                    }
                }
                
                var firstNumber = 0
                var secondNumber = 0

                if (y == "+"){
                    firstNumber = Int.random(in: 1...randomNumber-1)
                    secondNumber = randomNumber - firstNumber
                }
                else if (y == "-") {
                    firstNumber = Int.random(in: randomNumber+1...100)
                    secondNumber = firstNumber - randomNumber
                }
                else if (y == "*") {
                    firstNumber = Int.random(in: 2...randomNumber-1)
                    while (randomNumber % firstNumber != 0){
                        firstNumber = Int.random(in: 2...randomNumber-1)
                    }
                    secondNumber = randomNumber / firstNumber
                }
                else if (y == "÷") {
                    secondNumber = Int.random(in: 2...x+1)
                    firstNumber = randomNumber * secondNumber
                }
                
                if (g == 0)
                {
                    labelOne.expression = "\(String(firstNumber)) \(y) \(String(secondNumber))"
                }
                else if (g == 1){
                    labelTwo.expression = "\(String(firstNumber)) \(y) \(String(secondNumber))"
                }
                g+=1
            }
            
            createdLabels += [labelOne, labelTwo]
            g = 0
        }
            
        createdLabels.shuffle()
        return createdLabels
    }
        
}
    

