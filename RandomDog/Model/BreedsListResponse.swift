//
//  BreedsListResponse.swift
//  RandomDog
//
//  Created by Mrunalini Gaddam on 10/12/20.
//  Copyright © 2020 Udacity. All rights reserved.
//

import Foundation

struct BreedsListResponse: Codable {
    let status: String
    let message: [String: [String]]
}
