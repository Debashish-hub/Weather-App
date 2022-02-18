//
//  WeatherData.swift
//  Project
//
//  Created by comviva on 17/02/22.
//

import Foundation

struct Current: Codable{
    var dt: Double
    var sunset: Double
    var sunrise: Double
    var temp: Double
    var weather: [Weather]
}

struct TodayWeather: Codable {
    var current : Current
    
}

struct Coord: Codable{
    let lon: Double
    let lat: Double
}
struct Weather: Codable {
    var description: String
    var icon: String
}
struct Main: Codable {
    let temp: Double
    let humidity: Int
}
struct Wind: Codable{
    let speed: Double
}
struct Sys: Codable {
    let sunrise: Int
    let sunset: Int
}


//weekly weather
struct DailyResult: Codable{
    var dt : Double
    var humidity : Int
    var temp : temp
    var wind_speed : Double
    var weather : [Weather]
}
struct DailyForecast:Codable{
    var daily:[DailyResult]
}

struct temp : Codable{
    var min: Double
    var max: Double
}

//hourly weather
struct HourlyResult:Codable{
    var dt : Double
    var temp : Double
    var humidity : Double
    var wind_speed : Double
    var weather : [Weather]
    
}

struct HourlyForecast:Codable{
    var hourly : [HourlyResult]
}
