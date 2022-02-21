//
//  WeatherViewModel.swift
//  Project
//
//  Created by comviva on 19/02/22.
//

import Foundation

class WeatherViewModel {
    var dailyList : [DailyResult] = []
    var hourlyList : [HourlyResult] = []
    var today : Current?
    
    let model = AFUtility.instance //strong reference model
    
    
    //Downloading Images
    func getImages(imgURL : String, completion : @escaping (Data) -> Void ) {
        model.downloadImage(imgURL: imgURL) { Data in
            completion(Data)
        }
    }
    
    //getting data for today
    func todayForecast(Lat : Double, Lon : Double, completion : @escaping() -> Void) {
        model.getToday(Lat: Lat, Long: Lon) { (data) in
            self.today = data.current
            completion()
        }
    }
    
    //getting hourly forecast and updating hourlyList
    func hourlyForecast(Lat : Double, Lon : Double , completion : @escaping() -> Void ){
        model.getHourlyData(Lat: Lat, Long: Lon) { data in
            self.hourlyList = data.hourly
            completion()
        }
    }
    
    //getting daily forecast and updating dailyList
    func sevenDayForecast(Lat : Double, Long : Double, completion: @escaping() -> Void){
        model.getDailyForecast(Lat: Lat, Long: Long) { data in
            self.dailyList = data.daily
            completion() 
        }
    }
    
}
