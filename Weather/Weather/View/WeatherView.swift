//
//  WeatherView.swift
//  Weather
//
//  Created by Marco Dell'Isola on 27/03/23.
//

import SwiftUI
import WeatherKit

struct WeatherView: View {
    @StateObject var weatherViewModel = WeatherViewModel(location: LocationManager(), service: WeatherForecastService())
    
    var body: some View {
        VStack {
            Text("San Francisco")
                .font(.largeTitle)
            Text("\(weatherViewModel.weatherKit?.currentWeather.temperature.formatted())")
        }
        HourlyForecastView(hourWeatherList: weatherViewModel.weatherKit?.hourlyForecast.forecast)
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
                            Text(hourWeatherItem.temperature.formatted())
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
