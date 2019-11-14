//
//  DetailViewController.swift
//  DatePicker
//
//  Created by Maitree Bain on 11/14/19.
//  Copyright © 2019 Maitree Bain. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    //MARK:- Outlets and Properties
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var selectedDateLabel: UILabel!
    @IBOutlet weak var switchControl: UISwitch!

    var event: Event? //default value is
    
    //DateFormatter will help us to format the Date object
    //lazy variable - is a variable that gets created the first time it's needed
    //
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
//        formatter.dateStyle = .medium
//        formatter.timeStyle = .medium
        formatter.dateFormat = "MM-dd-yyyy HH:mm"
        return formatter
    }() //calls this function (closure)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    
    }
        //method to update the UI elements
        func updateUI() {
            guard let date = event?.date else {
            
                return
            }
            
            selectedDateLabel.text = dateFormatter.string(from: date)
            //set switch position base on value of willAttend, true or false
            //if true, switch will be turned on, else switch will be turned off
            switchControl.isOn = event?.willAttend ?? false //true or false
            
            
            messageLabel.text =  event?.name ?? "Event name not available"
        }
        
    
    
    @IBAction func rsvpChanged(_ sender: UISwitch) {
        
    }
}

