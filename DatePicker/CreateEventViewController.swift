//
//  ViewController.swift
//  DatePicker
//
//  Created by Maitree Bain on 11/14/19.
//  Copyright © 2019 Maitree Bain. All rights reserved.
//

import UIKit

class CreateEventViewController: UIViewController {

    @IBOutlet weak var eventTextField: UITextField!
    @IBOutlet weak var createEventButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var rsvpLabel: UILabel!
    
    var event: Event! {
        didSet { //property observer, gets called when the property changes
            //update UI whenever the event changes
            if event.willAttend {
                rsvpLabel.text = "Yes"
                createEventButton.setTitle("View Event", for: .normal)
            } else {
                rsvpLabel.text = "RSVP No"
                createEventButton.setTitle("RSVP to Event", for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        //Date() creates initializes a new Date object with the current date and time
        event = Event(name: "Event name not set", willAttend: false, date: Date())
        eventTextField.delegate = self
        
        datePicker.minimumDate = Date() //user is NOT allowed to set a event prior to today's date.
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepare(for segue: )")
        
        
        //1. we need to get an instance of the detail view controller
//        guard let detailViewController = segue.destination //this is a UIViewController
//
        guard let detailViewController = segue.destination as? DetailViewController else {
            return
        }
        
        // we could set the event on the detail view controller
        
        //where we segueing to now has its event set successfully
        detailViewController.event = event
    }
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        event.date = sender.date
    }
    

}

extension CreateEventViewController: UITextFieldDelegate{
func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    
    event.name = eventTextField.text ?? "" // unwrap
    return true
}
    
}
