//
//  WeatherData.swift
//  Clima
//
//  Created by Noman Ashraf on 7/20/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Codable{
    let name: String
    let main: Main
    let weather: [weatherInfo]
}
struct Main: Codable{
    let temp: Double
}
struct weatherInfo: Codable{
    let id: Int
}
