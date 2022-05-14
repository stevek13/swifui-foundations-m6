//
//  BusinessSearch.swift
//  CitySightsApp
//
//  Created by Steve Kite on 5/14/22.
//

import Foundation

struct BusinessSearch: Decodable {
    
    var businesses = [Business]()
    var total = 0
    var region = Region()
}

struct Region: Decodable {
    var center = Coordinate()
}
