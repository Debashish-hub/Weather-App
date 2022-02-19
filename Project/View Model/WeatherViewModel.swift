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
    
    let viewModel = AFUtility.instance //strong reference model
    
    
    //Downloading Images
    func getImages(imgURL : String, completion : @escaping (Data) -> Void ) {
        viewModel.downloadImage(imgURL: imgURL) { Data in
            completion(Data)
        }
    }
    
    //getting hourly forecast and updating hourlyList
    func hourlyForecast(Lat : Double, Lon : Double , completion : @escaping() -> Void ){
        viewModel.getHourlyData(Lat: Lat, Long: Lon) { data in
            self.hourlyList = data.hourly
            completion()
        }
    }
    
    //getting daily forecast and updating dailyList

}
