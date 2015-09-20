//
//  MenuViewController.swift
//  Simon Says
//
//  Created by PC on 5/2/15.
//  Copyright (c) 2015 Randel Smith. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var lastScoreLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        var highScore = NSUserDefaults.standardUserDefaults().integerForKey("highestLevel")
        self.highScoreLabel.text = ("High score: \(highScore)")
        var lastScore = NSUserDefaults.standardUserDefaults().integerForKey("lastLevel")
        self.lastScoreLabel.text = ("Last score: \(lastScore)")
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
