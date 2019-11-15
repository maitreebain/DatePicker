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
            //changes meaning the when it gets assigned a new value
            //update UI whenever the event changes
            if event.willAttend {
                rsvpLabel.text = "RSVP Yes"
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
    
    //unwind segue action
    //we need to create an IBAction button from the source view controller (DetailViewController)to this unwind segue action
    
    //it's required to have a parameter to type UIStoryboardSegue in the unwind segue action
    //why: this is the only way interface builder can recognize an unwind segue to connect to
    
    //Steps to create an unwind segue - returning from a source view controller
    //1. write an @IBAction func
    //2. UIStoryboardSegue parameter is required
    //3. type cast (as? )and get access to the source view controller instance
    //4. setup UI caccordingly see event = detailViewController.event, didSet{...} on event property above
    //5. in storyboard connect action button to "exit" icon in source view controller and select e.g this methods (updateUIFromUnwindSegue)
    @IBAction func updateUIFromUnwindSegue(segue: UIStoryboardSegue) {
        //we need access to the source destination
        guard let detailViewController = segue.source as? DetailViewController else {
            return //more on refactoring to fatalError later
        }
        
        event = detailViewController.event
        //after event is set here, didSet on the event property gets called and the UI (user interface) is updated
        //ui elements that gets updated are the rsvpLabel's text and createEventButton's titleLable
    }

}

extension CreateEventViewController: UITextFieldDelegate{
func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    
    event.name = eventTextField.text ?? "" // unwrap
    return true
}
    
}
