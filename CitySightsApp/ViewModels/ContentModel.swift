//
//  ContentModel.swift
//  CitySightsApp
//
//  Created by Steve Kite on 5/13/22.
//

import Foundation
import CoreLocation


class ContentModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    // https://betterprogramming.pub/fetch-api-keys-from-property-list-files-in-swift-4a9e092e71fa
    private var apiKey: String {
      get {
        // 1
        guard let filePath = Bundle.main.path(forResource: "Yelp-Info", ofType: "plist") else {
          fatalError("Couldn't find file 'Yelp-Info.plist'.")
        }
        // 2
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "API_Key") as? String else {
          fatalError("Couldn't find key 'API_KEY' in 'Yelp-Info.plist'.")
        }
        return value
      }
    }
    var locationManager = CLLocationManager()
    
    @Published var restaurants = [Business]()
    @Published var sights = [Business]()
    
    override init() {
        // init method of NSObject
        super.init()
        
        // Set ContentModel and delegate of LocationManager
        locationManager.delegate = self
        
        // Request permission from user
        locationManager.requestWhenInUseAuthorization()
        
        // TODO: Start geolocating the user
        //locationManager.startUpdatingLocation()
    }
    // MARK - Location Manager Delegate Method
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        if locationManager.authorizationStatus == .authorizedAlways || locationManager.authorizationStatus == .authorizedWhenInUse {
            // We have permission
            locationManager.startUpdatingLocation()
            
        } else if locationManager.authorizationStatus == .denied {
            // We don't have permission
            
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // Give us the location of the user
        let userLocation = locations.first
        
        if userLocation != nil {
            // We have a location
            // Stop requesting the location after we get it once
            locationManager.stopUpdatingLocation()
            
            // TODO: If we have the coordinates of the user, send into Yelp api
            getBusinesses(category: Constants.sightsKey, location: userLocation!)
            getBusinesses(category: Constants.restaurantsKey, location: userLocation!)
        }
    }
    
    // MARK: Yelp API methods
    func getBusinesses(category: String, location:CLLocation) {
        
        // Create URL
        var URLComponents = URLComponents(string: Constants.apiUrl)
        URLComponents?.queryItems = [
            URLQueryItem(name: "latitude", value: String(location.coordinate.latitude)),
            URLQueryItem(name: "longitude", value: String(location.coordinate.longitude)),
            URLQueryItem(name: "categories", value: category),
            URLQueryItem(name: "limit", value: "20")
        ]
        let url = URLComponents?.url
        
        
        if let url = url {
            
            // Create URL Request
            var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
            request.httpMethod = "GET"
            
            request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
            
            // Get URLSesson
            let session = URLSession.shared
            // Create Data Tesk
            let dataTask = session.dataTask(with: request) { (data, response, error) in
                // check that there isn't an error
                if error == nil {
                    do{
                    //Parse JSON
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(BusinessSearch.self, from: data!)
                        DispatchQueue.main.async {
                            // Assign results to appropriate property
//                            if category == Constants.sightsKey {
//                                self.sights = result.businesses
//                            } else if category == Constants.restaurantsKey {
//                                self.restaurants = result.businesses
//                            }
                            switch category {
                            case Constants.sightsKey:
                                self.sights = result.businesses
                            case Constants.restaurantsKey:
                                self.restaurants = result.businesses
                            default:
                                break
                            }
                        }
  
                    } catch {
                        
                        print(error)
                    }
                    
                }
            }
            // Start the Data Task
            dataTask.resume()
        }
    }
}
