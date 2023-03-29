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

    func getWeatherApiForecast(latitude: CLLocationDegrees, longitude: CLLocationDegrees) -> AnyPublisher<HourlyForecasts, WeatherError> {
        let baseURL = "https://pro.openweathermap.org/data/2.5/forecast/hourly"
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
            .decode(type: HourlyForecasts.self, decoder: JSONDecoder())
            .mapError { _ in
                return .noDataAvailable
            }
            .eraseToAnyPublisher()
    }

    func getWeatherKitForecast(locationManager: LocationManager) async throws -> WeatherKit.Weather {
        let weatherService = WeatherService.shared
        let location = locationManager.currentLocation ?? CLLocation(latitude: 40.8517746, longitude: 14.2681244)
        let weather = try await weatherService.weather(for: location)
        return weather
    }
}
