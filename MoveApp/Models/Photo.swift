//
//  Photo.swift
//  MoveApp
//
//  Created by Krzysztof Lech on 25/10/2018.
//  Copyright © 2018 Krzysztof Lech. All rights reserved.
//

import Foundation

struct Photo: Decodable {
    let width: Int
    let height: Int
    let photoReference: String
    
    enum CodingKeys: String, CodingKey {
        case width
        case height
        case photoReference = "photo_reference"
    }
}
