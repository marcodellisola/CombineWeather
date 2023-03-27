//
//  WeatherAPIViewModel.swift
//  Weather
//
//  Created by Marco Dell'Isola on 27/03/23.
//

import Foundation
import CoreLocation
import Combine

final class WeatherAPIViewModel: ObservableObject {
    @Published var forecast: ResponseBody?
    @Published var hasError = false

    private var bag = Set<AnyCancellable>()

    func fetchWeatherAPI(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let baseURL = "api.openweathermap.org/data/2.5/forecast/daily"
        let appid = "760cb0970ae941895591c62f42d4e50e"
        var urlComponents = URLComponents(string: baseURL)!
        urlComponents.queryItems = [
            URLQueryItem(name: "lat", value: "\(latitude)"),
            URLQueryItem(name: "lon", value: "\(longitude)"),
            URLQueryItem(name: "appid", value: appid)
        ]

        let url = urlComponents.url!

        hasError = false

        URLSession.shared.dataTaskPublisher(for: url)
        .receive(on: DispatchQueue.main)
        .map(\.data)
        //Use tryMap to manage decoding error
        .decode(type: ResponseBody.self, decoder: JSONDecoder())
        .sink { [weak self] res in

            switch res {
            case .failure(let error):
                self?.hasError = true
            default: break
            }

        } receiveValue: { [weak self] forecast in
            self?.forecast = forecast
        }
        .store(in: &bag)
    }

}
