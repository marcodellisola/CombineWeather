//
//  WeatherKitPublusher.swift
//  Weather
//
//  Created by Marco Dell'Isola on 27/03/23.
//

import WeatherKit
import CoreLocation
import Combine

func weatherKitRequest() -> AnyPublisher<Void,Error> {
    func getWeatherData(for location: CLLocation) {
        let currentConditionsRequest = CurrentConditionsRequest(location: location)

        let weatherKit = WeatherKit(apiKey: "4VVTFDGP94")

        weatherKit.getCurrentConditions(using: currentConditionsRequest) { result in
            switch result {
            case .success(let conditions):
                // Display the weather conditions to the user
                print("Current temperature: \(conditions.temperature!.value) \(conditions.temperature!.unit.symbol)")
                print("Current weather conditions: \(conditions.weatherConditions.first!.description)")
            case .failure(let error):
                // Handle any errors that occurred during the request
                print("Error retrieving weather data: \(error.localizedDescription)")
            }
        }
    }
}
