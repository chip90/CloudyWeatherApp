//
//  APIError.swift
//  CloudyWeatherApp
//
//  Created by Carleton C Snow III on 2/19/22.
//

import Foundation

struct APIError: Codable {
    let cod: Int
    let message: String
}
