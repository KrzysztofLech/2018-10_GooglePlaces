//
//  Place.swift
//  MoveApp
//
//  Created by Krzysztof Lech on 25/10/2018.
//  Copyright © 2018 Krzysztof Lech. All rights reserved.
//

import Foundation

struct Place: Decodable {
    let name: String
    let address: String
    let rating: Double
    let photos: [Photo]
    
    enum CodingKeys: String, CodingKey {
        case name
        case address = "vicinity"
        case rating
        case photos
    }
}
