//
//  ExploreViewController.swift
//  Vacatio
//
//  Created by Stephen Davis on 9/23/21.
//

import UIKit
import Firebase

class ExploreViewController: UIViewController, UISearchBarDelegate {
    
    // TODO: Change to enum
    let reuseConstant = "toSearchResult"
    
    // MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
    }
    
    // MARK: - Actions
    @IBAction func serachButtonTapped(_ sender: Any) {
        // TODO: Guard against segue if search bar is empty
        
    }
    
    // MARK: - Helper methods
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text{
            print(text)
            
            //userInput = text
            performSegue(withIdentifier: reuseConstant, sender: self)
            
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == reuseConstant{
            
            guard let destination = segue.destination as? ExploreResultViewController,
                  let searchText = searchBar.text, !searchText.isEmpty else { return }
            
            destination.searchText = searchText
            
        }
    }
} // End of class
