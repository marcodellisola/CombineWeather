//
//  WeatherApp.swift
//  Weather
//
//  Created by Marco Dell'Isola on 27/03/23.
//

import SwiftUI

@main
struct WeatherApp: App {
    @StateObject var fetchWeatherAPI:
    @StateObject var fetchWeatherKit:

    var body: some Scene {
        WindowGroup {
            WeatherView()
                .environmentObject(fetchWeatherAPI)
                .environmentObject(fetchWeatherKit)
        }
    }
}
