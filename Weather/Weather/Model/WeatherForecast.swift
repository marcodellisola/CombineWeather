//
//  WeatherForecast.swift
//  Weather
//
//  Created by Marco Dell'Isola on 28/03/23.
//

import Foundation

struct WeatherForecast {
    let date: Date
    let condition: String
    let temperature: Double
}

enum WeatherError: Error {
    case invalidLocation
    case noDataAvailable
}
