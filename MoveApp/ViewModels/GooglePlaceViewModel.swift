//
//  GooglePlaceViewModel.swift
//  MoveApp
//
//  Created by Krzysztof Lech on 25/10/2018.
//  Copyright © 2018 Krzysztof Lech. All rights reserved.
//

import UIKit

typealias Completion = (()->())
typealias CompletionImage = ((UIImage)->())
typealias CompletionLocation = ((Location)->())

class GooglePlaceViewModel {
    
    // MARK: - Private Properties
    
    private let apiService: APIService
    private let gpsService: GPSService
    private var _nearbyPlaces: NearbyPlaces?
    private var _userLocation: Location = Constants.warsawLocation
    
    // MARK: - Public Properties
    var nearbyPlaces: NearbyPlaces {
        if _nearbyPlaces != nil {
            return _nearbyPlaces!
        } else {
            return NearbyPlaces.init(status: "", nextPageToken: nil, results: [])
        }
    }
    
    var placesCount: Int {
        return nearbyPlaces.results.count
    }
    
    var userLocation: Location {
        return _userLocation
    }
    
    // MARK: - Init
    
    init(apiService: APIService = APIService(), gpsService: GPSService = GPSService()) {
        self.apiService = apiService
        self.gpsService = gpsService
    }
    
    // MARK: - Networking
    
    func fetchData(withLocation location: Location, andType type: String, completion: @escaping Completion) {
        let url = apiService.nearbyPlacesRequest(location: location, andType: type)
        apiService.fetchNearbyPlaces(url: url) { [weak self] nearbyPlaces in
            self?._nearbyPlaces = nearbyPlaces
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    func fetchImage(withWidth width: Int, andPlaceIndex index: Int, completion: @escaping CompletionImage) {
        guard
            let photos = nearbyPlaces.results[index].photos else { return }
        
        let photoReference = photos[0].photoReference
        let url = self.apiService.imageRequest(width: width, photoReference: photoReference)
        apiService.fetchPlaceImage(url: url) { image in
            completion(image)
        }
    }
    
    // MARK: - Data Model Methods
    
    func getPlaceData(withIndex index: Int) -> (name: String, photoReference: String) {
        let place = nearbyPlaces.results[index]
        let photoReference: String
        if let photos = place.photos {
            photoReference = photos[0].photoReference
        } else {
            photoReference = ""
        }
        return (place.name, photoReference)
    }
    
    func removeData() {
        _nearbyPlaces = nil
    }
    
    // MARK: - GPS Methods
    
    func findUserLocation(completion: @escaping Completion) {
        gpsService.getUserLocation { [weak self] userLocation in
            self?._userLocation = userLocation
            completion()
        }
    }
}
