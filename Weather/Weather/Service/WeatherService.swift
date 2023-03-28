//
//  WeatherAPIViewModel.swift
//  Weather
//
//  Created by Marco Dell'Isola on 27/03/23.
//

import Foundation
import CoreLocation
import Combine
import WeatherKit

final class WeatherForecastService {

    func getWeatherApiForecast(latitude: CLLocationDegrees, longitude: CLLocationDegrees) -> AnyPublisher<OpenWeatherForecasts, WeatherError> {
        let baseURL = "api.openweathermap.org/data/2.5/forecast/daily"
        let appid = "760cb0970ae941895591c62f42d4e50e"
        var urlComponents = URLComponents(string: baseURL)!
        urlComponents.queryItems = [
            URLQueryItem(name: "lat", value: "\(latitude)"),
            URLQueryItem(name: "lon", value: "\(longitude)"),
            URLQueryItem(name: "appid", value: appid)
        ]

        let url = urlComponents.url!

        return URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .map(\.data)
        //Use tryMap to manage decoding error
            .decode(type: OpenWeatherForecasts.self, decoder: JSONDecoder())
            .mapError { _ in
                return .noDataAvailable
            }
            .eraseToAnyPublisher()
    }

    func getWeatherKitForecast(locationManager: LocationManager) async throws -> WeatherKit.Weather {
        let weatherService = WeatherService.shared
        let weather = try await weatherService.weather(for: locationManager.currentLocation!)
        return weather
    }
}
