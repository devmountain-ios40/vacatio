//
//  ExploreResultTableViewCell.swift
//  Vacatio
//
//  Created by Andrew Saeyang on 10/4/21.
//

import UIKit

class ExploreResultTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    var searchResult: SearchResult?{
        didSet{
            updateViews()
        }
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var poiNameLabel: UILabel!
    @IBOutlet weak var phonenumberLabel: UILabel!
    @IBOutlet weak var catagoryLabel: UILabel!
    
    // TODO: change to a url link
    @IBOutlet weak var websiteLabel: UILabel!
    
    
    // MARK: - Actions
    @IBAction func addResultButtonTapped(_ sender: UIButton) {
        
        // TODO: Add to trips
    }
    
    // MARK: - Helper Methods
    
    func updateViews(){
        guard let searchResult = searchResult else {
            print("Update Views ran into an Error!!!!")
            return }
        let url = searchResult.poi.url ?? "No website"
        poiNameLabel.text = searchResult.poi.name
        phonenumberLabel.text = searchResult.poi.phone
        catagoryLabel.text = searchResult.poi.categories[0]
        
        // TODO: Clean this url up V
        websiteLabel.text = "\(url)"
        
       
        //print("Url for poi is: \(searchResult.poi.url)")
        
//        if let website = searchResult.poi.url{
//            if let url = URL(string: website){
//                UIApplication.shared.open(url)
//            }
//        }else{
//            websiteLabel.text = "No Website Available"
//        }
        
        
    }
    
    
}
