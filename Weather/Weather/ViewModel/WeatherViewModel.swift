//
//  WeatherKitViewModel.swift
//  Weather
//
//  Created by Marco Dell'Isola on 28/03/23.
//

import Foundation
import Combine
import WeatherKit

final class WeatherViewModel: ObservableObject {
    let weatherService: WeatherForecastService
    let locationManager: LocationManager
    private var subscriptions = Set<AnyCancellable>()
    @Published var weatherKit: WeatherKit.Weather?
    @Published var openWeather: OpenWeatherForecasts?

    init(location: LocationManager, service: WeatherForecastService) {
        self.weatherService = service
        self.locationManager = location
        fetchWeatherApi()
        fetchWeatherKit()
    }

    func  fetchWeatherKit() {
        Task {
            self.weatherKit =  try await weatherService.getWeatherKitForecast(locationManager: locationManager)
        }
    }

    func fetchWeatherApi() {
        weatherService.getWeatherApiForecast(latitude: locationManager.currentLocation?.coordinate.latitude ?? 40.853294, longitude: locationManager.currentLocation?.coordinate.longitude ?? 14.305573)
                .sink { [weak self] res in

                    switch res {
                    case .failure(_):
                        print("Error WeatherApi")
                    default: break
                    }

                } receiveValue: { [weak self] forecast in
                    self?.openWeather = forecast
                }
                .store(in: &subscriptions)
    }
    
}
