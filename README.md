# CombineWeather

## Learning Focus
The main goal of this project is to test and learn technologies related to Concurrency and Combine Framework in Swift.

## About the Project
One of the most struggle that I have daily, is to check more company's weather forecasts to have a more reliable idea of how the weather will be. 
This is the reason why I decided to implement an app that combine information from WeatherKit by Apple and OpenWeather API.

## What I learnt and What I did
Core operation are all developed into [WeatherService](./Weather/Weather/Service/WeatherService.swift) file. What I bascially did is to make a function that implement a Publisher to the API request and in this way I was able to explore Combine and a simple asynchronus function to explore concurrency.
### Combine 
Without doing something of too complex I used base Combine function that are of standard use like:
* .recive
* .map
* .eraseToAnyPublisher
* .sink
* .store
### Concurrency
I just made asynchronus function that are essential for external request, in this case to take WeatherKit's forecasts. Through this I also leant how to exploit Apple services that are very simple to use and intuitive.
### Architecture
I implemented a MVVM architecture that was essential to understand, in a better way, how a Subscrieber(a View) exploit services. Also because we should always remember that a simple ObservableObject is not else that a class that uses the Combine Framework.
This helped me to better design my app and also clearify the code. 
In fact through this structure I was able to provide to a single view multiple services that in this specific case are also of the same type and because of this groupable into one file.

## To Do
* Error Handling
* Prettify View
* Manage the fetchWeatherKit() function that should be execute into main thread
* Understand why API works intermittently
