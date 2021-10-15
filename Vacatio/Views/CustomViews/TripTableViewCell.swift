//
//  TripTableViewCell.swift
//  Vacatio
//
//  Created by Andrew Saeyang on 10/4/21.
//

import UIKit

class TripTableViewCell: UITableViewCell {

    // MARK: - Properties
    var trip: Trip?{
        didSet{
            updateView()
        }
    }
    // MARK: - Outlets
    @IBOutlet weak var tripTitleLabel: UILabel!
    @IBOutlet weak var tripDateRangeLabel: UILabel!
    
    // MARK: - Helper methods
    func updateView(){
        guard let trip = trip else { return }
        tripTitleLabel.text = trip.title
        tripDateRangeLabel.text = "\(trip.startDate) - \(trip.endDate)"
    }

}// End of class
