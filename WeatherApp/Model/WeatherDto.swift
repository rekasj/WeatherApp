//
//  WeatherDto.swift
//  WeatherApp
//
//  Created by Jakub Rękas on 05/10/2023.
//

import Foundation

struct WeatherDto: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}

