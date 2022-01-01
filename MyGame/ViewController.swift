//
//  ViewController.swift
//  MyGame
//
//  Created by Sajan Shah on 8/31/20.
//  Copyright © 2020 Sajan Shah. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
 
    @IBOutlet weak var instructionsButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    
    var r = IdentityLabel()
    var labelArray = [Label]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        instructionsButton.layer.cornerRadius = 25
        playButton.layer.cornerRadius = 25
        
        labelArray = r.getLabels()
    }
}

