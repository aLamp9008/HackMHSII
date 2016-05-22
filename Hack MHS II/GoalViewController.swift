//
//  GoalViewController.swift
//  Hack MHS II
//
//  Created by alden lamp on 5/21/16.
//  Copyright © 2016 alden lamp. All rights reserved.
//

import UIKit

var goalLoss = 0
var goalDays = 0

class GoalViewController: UIViewController {
    
    
    @IBOutlet weak var userWeight: UITextField!
    
    @IBOutlet weak var userGoalWeight: UITextField!
    
    @IBOutlet weak var goalDay: UITextField!
    
    
    
    
    @IBOutlet weak var aerobicDanceSwitch: UISwitch!
    
    @IBOutlet weak var runningSwitch: UISwitch!
    
    @IBOutlet weak var joggingSwitch: UISwitch!
    
    @IBOutlet weak var walkingSwitch: UISwitch!
    
    @IBOutlet weak var hikingSwitch: UISwitch!
    
    
    
    
    
    @IBAction func submit(sender: AnyObject) {
        
        if userWeight.text != nil && userGoalWeight.text != nil {
        
        goalLoss = Int(userWeight.text!)! - Int(userGoalWeight.text!)!
        
        print(aerobicDanceSwitch)
            
            
            
            
        }
        
        
    }
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        aerobicDanceSwitch.setOn(false, animated: true)
        runningSwitch.setOn(false, animated: true)
        joggingSwitch.setOn(false, animated: true)
        walkingSwitch.setOn(false, animated: true)
        hikingSwitch.setOn(false, animated: true)
        
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}
