//
//  FirstTabViewController.swift
//  MoveApp
//
//  Created by Krzysztof Lech on 25/10/2018.
//  Copyright © 2018 Krzysztof Lech. All rights reserved.
//

import UIKit

class FirstTabViewController: UIViewController {
    
    @IBOutlet weak var placeImageView: UIImageView!
    
    let apiService = APIService()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let url = apiService.nearbyPlacesRequest(location: Constants.warsawLocation, andType: "restaurant")
        apiService.fetchNearbyPlaces(url: url) { (nearbyPlaces) in
            let photoReference = nearbyPlaces.results[2].photos[0].photo_reference
            let url = self.apiService.imageRequest(width: 400, photoReference: photoReference)
            self.apiService.fetchPlaceImage(url: url, completion: { (image) in
                self.placeImageView.image = image
            })
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}
