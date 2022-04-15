//
//  CityNameData.swift
//  CloudyWeatherApp
//
//  Created by Carleton C Snow III on 3/31/22.
//

import Foundation

//struct CityNameData: Codable {
//    let cities: Array<City>
//}

struct City: Codable {
    let name: String
    let lat: Double
    let lon: Double
    let country: String
    let state: String
}
