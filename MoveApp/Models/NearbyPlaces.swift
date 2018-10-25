//
//  NearbyPlaces.swift
//  MoveApp
//
//  Created by Krzysztof Lech on 25/10/2018.
//  Copyright © 2018 Krzysztof Lech. All rights reserved.
//

import Foundation

struct NearbyPlaces: Decodable {
    let status: String
    let nextPageToken: String?
    let results: [Place]
    
    enum CodingKeys: String, CodingKey {
        case status
        case nextPageToken = "next_page_token"
        case results
    }
}
