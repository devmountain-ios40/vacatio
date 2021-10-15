//
//  TripsViewController.swift
//  Vacatio
//
//  Created by Stephen Davis on 9/24/21.
//

import UIKit

class TripViewController: UIViewController {
    
    // MARK: - Properties
    private let segueIDConstant = "toTripDetailVC"
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIDConstant{
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destination = segue.destination as? TripDetailViewController else { return }
            
            destination.trip = TripModelController.shared.samepleTrips[indexPath.row]
            
        }
    }
} // End of class

extension TripViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TripModelController.shared.samepleTrips.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "tripsCell", for: indexPath) as? TripTableViewCell else { return UITableViewCell()}
        
        //        cell.tripTitleLabel.text = "Italy Trip Winter"
        //        cell.tripDateRangeLabel.text = "December 5, 2021 - December 20th, 2021"
        
        cell.trip = TripModelController.shared.samepleTrips[indexPath.row]
        
        return cell
    }
} // End of Extension
