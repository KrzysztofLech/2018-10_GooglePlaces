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
    let next_page_token: String?
    let results: [Place]
}
