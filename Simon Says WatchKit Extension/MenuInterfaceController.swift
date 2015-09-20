//
//  MenuInterfaceController.swift
//  Simon Says
//
//  Created by PC on 5/1/15.
//  Copyright (c) 2015 Randel Smith. All rights reserved.
//

import WatchKit
import Foundation


class MenuInterfaceController: WKInterfaceController {

    @IBOutlet weak var highScoreLabel: WKInterfaceLabel!
    @IBOutlet weak var lastScoreLabel: WKInterfaceLabel!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        var highScore = NSUserDefaults.standardUserDefaults().integerForKey("highestLevel")
        self.highScoreLabel.setText("High score: \(highScore)")
        var lastScore = NSUserDefaults.standardUserDefaults().integerForKey("lastLevel")
        self.lastScoreLabel.setText("Last score: \(lastScore)")
        
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
