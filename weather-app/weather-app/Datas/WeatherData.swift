//
//  WeatherData.swift
//  weather-app
//
//  Created by admin on 26.02.22.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    let sys: Sys
    let wind: Wind
    let clouds: Clouds
}

struct Clouds: Codable {
    let all: Int
}

struct Wind: Codable {
    let speed: Float
    let deg: Int
}

struct Sys: Codable {
    let country: String
}

struct Main: Codable {
    let temp: Double
    let pressure: Int
    let humidity: Int
}

struct Weather: Codable {
    let description: String
    let id: Int
    let main: String
    let icon: String
}
