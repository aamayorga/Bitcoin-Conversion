//
//  PriceConversion.swift
//  BitcoinConversion
//
//  Created by Antonio Mayorga on 5/2/19.
//  Copyright © 2019 Rays Industrial Computers. All rights reserved.
//

import Foundation

struct PriceConversion: Decodable {
    let success: Bool
    let time: String
    let price: Double
}
