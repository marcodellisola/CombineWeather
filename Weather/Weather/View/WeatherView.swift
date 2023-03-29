//
//  WeatherView.swift
//  Weather
//
//  Created by Marco Dell'Isola on 27/03/23.
//

import SwiftUI
import WeatherKit
import CoreLocation

struct WeatherView: View {
    @ObservedObject var weatherViewModel = WeatherViewModel(location: LocationManager(), service: WeatherForecastService())
    let weatherService = WeatherService.shared
    
    var body: some View {
        VStack{
            HStack {
                if let weather = weatherViewModel.weatherKit {
                    VStack {
                        VStack {
                            Text("San Francisco")
                                .font(.largeTitle)
                            Text("\(weather.currentWeather.temperature.converted(to: .celsius).formatted())")
                        }
                        HourlyForecastView(hourWeatherList: weather.hourlyForecast.forecast)
                    }
                }
                if let openWeather = weatherViewModel.openWeather {
                    VStack{
                        Text("Hourly Forecasts")
                            .font(.caption)
                            .opacity(0.5)
                        ScrollView(.vertical) {
                            VStack(spacing: 20) {
                                ForEach(openWeather.list, id: \.dt) { hourWeatherItem in
                                    HStack {
                                        Text("\(hourWeatherItem.dtTxt)")
                                        Image(systemName: "\(hourWeatherItem.weather[0].icon)")
                                            .foregroundColor(.yellow)
                                        Text("\(hourWeatherItem.main.temp)")
                                            .fontWeight(.medium)
                                    }.padding()
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

struct HourlyForecastView: View {
    let hourWeatherList: [HourWeather]

    var body: some View {
        VStack {
            Text("Hourly Forecasts")
                .font(.caption)
                .opacity(0.5)
            ScrollView(.vertical) {
                VStack(spacing: 20) {
                    ForEach(hourWeatherList, id:\.date) { hourWeatherItem in
                        HStack {
                            Text(hourWeatherItem.date.formatted(date: .omitted, time: .shortened))
                            Image(systemName: "\(hourWeatherItem.symbolName).fill")
                                .foregroundColor(.yellow)
                            Text(hourWeatherItem.temperature.converted(to: .celsius).formatted())
                                .fontWeight(.medium)
                        }.padding()
                    }
                }
            }

        }
    }

}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
