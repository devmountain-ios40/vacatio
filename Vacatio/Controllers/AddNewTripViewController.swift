//
//  AddNewTripViewController.swift
//  Vacatio
//
//  Created by Andrew Saeyang on 10/5/21.
//

import UIKit

class AddNewTripViewController: UIViewController {
    
    // MARK: - Properties
    var tripLength: Int = 0
    
    @IBOutlet weak var tripNameTextField: UITextField!
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func calculate(_ sender: Any) {
        let diffInDays = Calendar.current.dateComponents([.day], from: startDatePicker.date, to: endDatePicker.date)
        
        print(diffInDays.day!)
    }
}// End of class

