//
//  Photo.swift
//  MoveApp
//
//  Created by Krzysztof Lech on 25/10/2018.
//  Copyright © 2018 Krzysztof Lech. All rights reserved.
//

import Foundation

struct Photo: Decodable {
    let height: Int
    let width: Int
    let photo_reference: String
}
