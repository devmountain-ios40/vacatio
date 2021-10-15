//
//  ExploreResultViewController.swift
//  Vacatio
//
//  Created by Andrew Saeyang on 10/4/21.
//

import UIKit
import MapKit
import CoreLocation

class ExploreResultViewController: UIViewController, UISearchBarDelegate, MKMapViewDelegate {
    
    // MARK: - Properties
    
    // TODO: Change to enum
    let reuseConstant = "resultCell"
    
    var searchResults: [SearchResult] = []{
        didSet{
            tableView.reloadData()
        }
    }
    var searchText: String = ""
    let newYorkCoordinate = CLLocationCoordinate2D(latitude: 40.7641, longitude: -73.9732)
    let seattleCoordinate = CLLocationCoordinate2D(latitude: 47.6180, longitude: -122.3383)
    
    var mapPins: [MKAnnotation] = []
    
    // MARK: - Outlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        mapView.delegate = self
        searchBar.text = searchText
        
        fetchPOI(search: searchText)
        
        mapView.setRegion(MKCoordinateRegion(center: seattleCoordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)), animated: true)
        
    }
    
    // MARK: - Actions
    
    
    // MARK: - Helper Methods
    
    func addCustomPin(for poi: SearchResult){
        let pin = MKPointAnnotation()
        pin.coordinate = CLLocationCoordinate2D(latitude: poi.position.lat , longitude: poi.position.lon)
        pin.title = poi.poi.name
        pin.subtitle = poi.poi.categories[0]
        mapView.addAnnotation(pin)
        
    }
    func appendAnnotations(with poi: SearchResult){
        let pin = MKPointAnnotation()
        pin.coordinate = CLLocationCoordinate2D(latitude: poi.position.lat , longitude: poi.position.lon)
        pin.title = poi.poi.name
        pin.subtitle = poi.poi.categories[0]
        
        mapView.addAnnotation(pin)
        mapPins.append(pin)
    }
    
    func annoMapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "custom")
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom")
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
    
    func fetchPOI(search: String){
        TomTomAPIController.fetchSearchedPOIs(with: search) { result in
            DispatchQueue.main.async {
                
                switch result{
                case .success(let topLevelObject):
                    self.searchResults = topLevelObject.results
                    print("Number of search results in the function: \(topLevelObject.results.count)")
                    self.tableView.reloadData()
                case .failure(let error):
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
                
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text{
            print(text)
            
            mapView.removeAnnotations(mapPins)
            
            //userInput = text
            fetchPOI(search: text)
            
        }
    }
    
}// End of class

extension ExploreResultViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseConstant, for: indexPath) as? ExploreResultTableViewCell else { return UITableViewCell()}
        let searchResult = searchResults[indexPath.row]
        cell.searchResult = searchResult
        appendAnnotations(with: searchResult)
        
        return cell
    }
}// End of Extension
