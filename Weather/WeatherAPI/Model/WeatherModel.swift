//
//  WeatherModel.swift
//  Cab share
//
//  Created by Marco Dell'Isola on 22/01/23.
//

import Foundation

import Foundation

// MARK: - Welcome
struct Welcome: Decodable {
    let city: City
    let cod: String
    let message: Double
    let cnt: Int
    let list: [List]
}

// MARK: - City
struct City: Decodable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
    let population, timezone: Int
}

// MARK: - Coord
struct Coord: Decodable {
    let lon, lat: Double
}

// MARK: - List
struct List: Decodable {
    let dt, sunrise, sunset: Int
    let temp: Temp
    let feelsLike: FeelsLike
    let pressure, humidity: Int
    let weather: [Weather]
    let speed: Double
    let deg: Int
    let gust: Double
    let clouds: Int
    let pop, rain: Double

    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, temp
        case feelsLike = "feels_like"
        case pressure, humidity, weather, speed, deg, gust, clouds, pop, rain
    }
}

// MARK: - FeelsLike
struct FeelsLike: Decodable {
    let day, night, eve, morn: Double
}

// MARK: - Temp
struct Temp: Decodable {
    let day, min, max, night: Double
    let eve, morn: Double
}

// MARK: - Weather
struct Weather: Decodable {
    let id: Int
    let main, description, icon: String
}
