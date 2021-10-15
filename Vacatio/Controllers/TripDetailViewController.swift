//
//  ViewController.swift
//  Vacatio
//
//  Created by Andrew Saeyang on 10/4/21.
//

import UIKit

class TripDetailViewController: UIViewController {
    // MARK: -  Properties
    var trip: Trip?
    
    enum Segues {
        static let toFirstContainer = "toFirstContainer"
        static let toSecondContainer = "toSecondContainer"
        static let toThirdContainer = "toThirdContainer"
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var tripTitleLabel: UILabel!
    @IBOutlet weak var tripDateRangeLabel: UILabel!
    
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var thirdView: UIView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Actions
    @IBAction func segmentControllTapped(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            firstView.alpha = 1
            secondView.alpha = 0
            thirdView.alpha = 0
        } else if sender.selectedSegmentIndex == 1 {
            firstView.alpha = 0
            secondView.alpha = 1
            thirdView.alpha = 0
        } else if sender.selectedSegmentIndex == 2 {
            firstView.alpha = 0
            secondView.alpha = 0
            thirdView.alpha = 1
        }
        
    }
    
    // MARK: - Helper Methods
    
    func updateViews(){
        guard let trip = trip else { return }
        tripTitleLabel.text = trip.title
        tripDateRangeLabel.text = "\(trip.startDate) - \(trip.endDate)"
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Identifier
        if segue.identifier == Segues.toFirstContainer{
            guard let destination = segue.destination as? FirstContainerViewController,
                  let trip = trip else { return }
            
            
            // Object to send
            destination.items = trip.items
            
            // Object to Recieve
            
        }else if segue.identifier == Segues.toSecondContainer{
            // TODO: Add code for map coordinates
        }else if segue.identifier == Segues.toThirdContainer{
            // TODO: Add freinds
        }
    }
}
