//
//  WeatherManager.swift
//  Cab share
//
//  Created by Marco Dell'Isola on 19/01/23.
//

import Foundation
import CoreLocation
import Combine

class WeatherManager {
    let baseURL = "http://api.openweathermap.org/data/2.5/weather"
    let appid = "760cb0970ae941895591c62f42d4e50e"
    // MARK: - Request weather to Open Weather
    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) -> AnyPublisher<ResponseBody, Error> {
        Deferred {
            Future { promise in
                var urlComponents = URLComponents(string: self.baseURL)!
                urlComponents.queryItems = [
                    URLQueryItem(name: "lat", value: "\(latitude)"),
                    URLQueryItem(name: "lon", value: "\(longitude)"),
                    URLQueryItem(name: "appid", value: self.appid)
                ]

                let url = urlComponents.url!

                let urlRequest = URLRequest(url: url)
                let (data, response) = URLSession.shared.data(for: urlRequest)
                guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                    promise(.failure(response as! Error))
                }
                let decodedData = JSONDecoder().decode(ResponseBody.self, from: data)
                promise(.success(decodedData))
            }
        }
        .eraseToAnyPublisher()
    }
}
