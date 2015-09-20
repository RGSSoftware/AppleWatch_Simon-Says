//
//  GameBoardViewController.swift
//  Simon Says
//
//  Created by PC on 5/2/15.
//  Copyright (c) 2015 Randel Smith. All rights reserved.
//

import UIKit

class GameBoardViewController: UIViewController {

    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var turnLabel: UILabel!
    
    private var colorSequence : [Int]!
    private var currentColorIndex : Int!
    
    private var currentLevel : Int!
    
    private var isAnimating : Bool!
    
    private var currentCorrectColor : Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.currentLevel = 1
        self.turnLabel.text = "Wait..."
        self.levelLabel.text = String(self.currentLevel)
        
        self.colorSequence = []
        self.colorSequence.append(self.randColor())
        
        self.animateColorSequence()
    }
    
    @IBAction func greenTouchUp(sender: AnyObject) {
        if self.isAnimating != true {
            if self.colorSequence[self.currentColorIndex] == 0 {
                if self.currentColorIndex != self.colorSequence.count - 1 {
                    self.currentColorIndex = self.currentColorIndex + 1
                } else {
                    self.nextLevel()
                }
            } else {
                self.handleGameOver()
            }
        }

    }
    @IBAction func redTouchUp() {
        if self.isAnimating != true {
            if self.colorSequence[self.currentColorIndex] == 1 {
                if self.currentColorIndex != self.colorSequence.count - 1 {
                    self.currentColorIndex = self.currentColorIndex + 1
                } else {
                    self.nextLevel()
                }
            } else {
                self.handleGameOver()
            }
        }
        
    }
    @IBAction func yellowTouchUp() {
        if self.isAnimating != true {
            if self.colorSequence[self.currentColorIndex] == 2 {
                if self.currentColorIndex != self.colorSequence.count - 1 {
                    self.currentColorIndex = self.currentColorIndex + 1
                } else {
                    self.nextLevel()
                }
            } else {
                self.handleGameOver()
            }
        }
        
    }
    @IBAction func blueTouchUp() {
        if self.isAnimating != true {
            if self.colorSequence[self.currentColorIndex] == 3 {
                if self.currentColorIndex != self.colorSequence.count - 1 {
                    self.currentColorIndex = self.currentColorIndex + 1
                } else {
                    self.nextLevel()
                }
            } else {
                self.handleGameOver()
            }
        }
        
    }
    
    private func randColor() -> Int {
        return Int(arc4random_uniform(4))
    }
    
    private func animateColorSequence () {
        
        
        self.currentColorIndex = 0
        NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: Selector("hideColor:"), userInfo: self.currentColorIndex, repeats: false)
    }
    
    func hideColor(timer : NSTimer) {
        
        var color : Int = self.colorSequence[timer.userInfo as! Int]
        
        if color == 0 {
            self.greenButton.hidden = true
        } else if color == 1 {
            self.redButton.hidden = true
        } else if color == 2 {
            self.yellowButton.hidden = true
        } else if color == 3 {
            self.blueButton.hidden = true
        }
        
        NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: Selector("showColor:"), userInfo: timer.userInfo, repeats: false)
    }
    
    
    
    func showColor(timer : NSTimer) {
        
        var color : Int = self.colorSequence[timer.userInfo as! Int]
        
        if color == 0 {
            self.greenButton.hidden = false
        } else if color == 1 {
            self.redButton.hidden = false
        } else if color == 2 {
            self.yellowButton.hidden = false
        } else if color == 3 {
            self.blueButton.hidden = false
        }
        
        if self.currentColorIndex != self.colorSequence.count - 1 {
            self.currentColorIndex = self.currentColorIndex + 1
            
            NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: Selector("hideColor:"), userInfo: self.currentColorIndex, repeats: false)
            self.turnLabel.text = "Wait..."
            self.isAnimating = true
        } else {
            self.turnLabel.text = "Your turn..."
            self.isAnimating = false
            self.currentCorrectColor = self.colorSequence[0]
            self.currentColorIndex = 0
        }
    }
    
    private func nextLevel () {
        self.currentLevel = self.currentLevel + 1
        self.levelLabel.text = String(self.currentLevel)
        
        self.colorSequence.append(self.randColor())
        self.turnLabel.text = "Wait..."
        self.animateColorSequence()
    }
    
    private func handleGameOver () {
        self.turnLabel.text = "Game Over"
        self.turnLabel.textColor = UIColor.redColor()
        
        
        NSUserDefaults.standardUserDefaults().setInteger(self.currentLevel, forKey: "lastLevel")
        if self.currentLevel > NSUserDefaults.standardUserDefaults().integerForKey("highestLevel"){
            NSUserDefaults.standardUserDefaults().setInteger(self.currentLevel, forKey: "highestLevel")
        }
        
        NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: Selector("popToMenu"), userInfo: nil, repeats: false)
        
    }

    @IBAction func popToMenu () {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
