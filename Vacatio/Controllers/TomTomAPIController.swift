//
//  TomTomAPIController.swift
//  Vacatio
//
//  Created by Andrew Saeyang on 9/30/21.
//

import Foundation

class TomTomAPIController{
    
    static let baseURL = URL(string: "https://api.tomtom.com/search/2/")
    static let poiSearchComponent = "poiSearch"
    static let fuzzySearchcomponent = "search"
    static let formatComponent = ".json"
    static let countryKey = "countrySet"
    static let countryValue = "US"
    static let latKey = "lat"
    static let lonKey = "lon"
    static let apiKeyKey: String = "key"
    static let apiKeyValue: String = "mBYzQD3GkST13WmOTbCLbGrSYe2C2QVS"
    
    //TODO: testing coordinates. Delete when ready for production
    static let portlandLat = "45.5051"
    static let portlandLon = "122.6750"
    
    static let seattleLat = "47.6180"
    static let seattleLon = "-122.3383"
    
    static let newyorkLat = "40.7641"
    static let newyorkLong = "-73.9732"
    
    static let sanfransicoLat = "37.7749"
    static let sanfransiscoLon = "122.4194"
    
    static func fetchSearchedPOIs(with searchTerm: String, completion: @escaping(Result<TopLevelObject, NetworkError>) -> Void) {
        
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL))}
        
        let searchURL = baseURL.appendingPathComponent(poiSearchComponent)
        let completeSearchURL = searchURL.appendingPathComponent(searchTerm + formatComponent)
        var components = URLComponents(url: completeSearchURL, resolvingAgainstBaseURL: true)
        let accessQuery = URLQueryItem(name: apiKeyKey, value: apiKeyValue)
        let countryQuery = URLQueryItem(name: countryKey, value: countryValue)
        
        // TODO: Using testing variables. Delete when ready for production
        let latQuery = URLQueryItem(name: latKey, value: seattleLat)
        let lonQuery = URLQueryItem(name: lonKey, value: seattleLon)
        
        components?.queryItems = [accessQuery, countryQuery, latQuery, lonQuery]
        
        guard let finalURL = components?.url else { return completion(.failure(.invalidURL))}
        
        print(finalURL)
        let task = URLSession.shared.dataTask(with: finalURL) { data, _, error in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            guard let data = data else { return completion(.failure(.noData))}
            do {
                let topLevelObject = try JSONDecoder().decode(TopLevelObject.self, from: data)
                completion(.success(topLevelObject))
            } catch {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                completion(.failure(.unableToDecode)) 
            }
        }
        task.resume()
    }
    
}
