//
//  FirstContainerTableViewCell.swift
//  Vacatio
//
//  Created by Andrew Saeyang on 10/5/21.
//

import UIKit

class FirstContainerTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    var item: Item?{
        didSet{
            updateView()
        }
    }
    
    // MARK: - Outlets
    @IBOutlet weak var poiNameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    // MARK: - Helper Methods
    
    func updateView(){
        guard let item = item else { return }
        poiNameLabel.text = item.name
        locationLabel.text = item.address
        
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
} // End of class
