//
//  InterfaceController.swift
//  Simon Says WatchKit Extension
//
//  Created by PC on 4/30/15.
//  Copyright (c) 2015 Randel Smith. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet weak var greenButton: WKInterfaceButton!
    @IBOutlet weak var redButton: WKInterfaceButton!
    @IBOutlet weak var yellowButton: WKInterfaceButton!
    @IBOutlet weak var blueButton: WKInterfaceButton!
    
    @IBOutlet weak var levelLabel: WKInterfaceLabel!
    @IBOutlet weak var turnLabel: WKInterfaceLabel!
    
    private var colorSequence : [Int]!
    private var currentColorIndex : Int!
    
    private var currentLevel : Int!
    
    private var isAnimating : Bool!
    
    private var currentCorrectColor : Int!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        self.currentLevel = 1
        self.turnLabel.setText("Wait...")
        self.levelLabel.setText(String(self.currentLevel))
        
            self.colorSequence = []
            self.colorSequence.append(self.randColor())
        
        self.animateColorSequence()

    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func greenTouchUp() {
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
    
    private func nextLevel () {
        self.currentLevel = self.currentLevel + 1
        self.levelLabel.setText(String(self.currentLevel))
        
         self.colorSequence.append(self.randColor())
         self.turnLabel.setText("Wait...")
        self.animateColorSequence()
    }
    
    private func handleGameOver () {
        self.turnLabel.setText("Game Over")
        self.turnLabel.setTextColor(UIColor.redColor())
        
        NSUserDefaults.standardUserDefaults().setInteger(self.currentLevel, forKey: "lastLevel")
        if self.currentLevel > NSUserDefaults.standardUserDefaults().integerForKey("highestLevel"){
             NSUserDefaults.standardUserDefaults().setInteger(self.currentLevel, forKey: "highestLevel")
        }
        
         NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: Selector("popToMenu"), userInfo: nil, repeats: false)
        
    }
    
    func popToMenu () {
       self.popController()
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
            self.greenButton.setBackgroundImage(nil)
        } else if color == 1 {
           self.redButton.setBackgroundImage(nil)
        } else if color == 2 {
            self.yellowButton.setBackgroundImage(nil)
        } else if color == 3 {
            self.blueButton.setBackgroundImage(nil)
        }
        
         NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: Selector("showColor:"), userInfo: timer.userInfo, repeats: false)
    }
    
    
    
     func showColor(timer : NSTimer) {
        
        var color : Int = self.colorSequence[timer.userInfo as! Int]
        
        if color == 0 {
            self.greenButton.setBackgroundImage(UIImage(named: "green-Watch.png"))
        } else if color == 1 {
            self.redButton.setBackgroundImage(UIImage(named: "red-Watch.png"))
        } else if color == 2 {
            self.yellowButton.setBackgroundImage(UIImage(named: "yellow-Watch.png"))
        } else if color == 3 {
            self.blueButton.setBackgroundImage(UIImage(named: "blue-Watch.png"))
        }
        
        if self.currentColorIndex != self.colorSequence.count - 1 {
            self.currentColorIndex = self.currentColorIndex + 1
            
            NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("hideColor:"), userInfo: self.currentColorIndex, repeats: false)
            self.turnLabel.setText("Wait...")
            self.isAnimating = true
        } else {
            self.turnLabel.setText("Your turn...")
            self.isAnimating = false
            self.currentCorrectColor = self.colorSequence[0]
            self.currentColorIndex = 0
        }
    }
    
    
}
