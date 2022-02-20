//
//  weatherUtility.swift
//  Project
//
//  Created by comviva on 18/02/22.
//

import Foundation

public class weatherUtility{
    public init(){
        
    }
    public func getTime(dt:Double)->String{
        let date = Date(timeIntervalSince1970: dt)
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium
        dateFormatter.timeZone = .current
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
    
    
    public func getDate(dt:Double)->String{
        let formatter = DateFormatter()
        formatter.dateFormat =  "E, MMM, d"//"dd MM yyyy"
        let  stringDate = formatter.string(from: Date(timeIntervalSince1970: TimeInterval(dt)))
        return stringDate
    }
    
    public func sunTime(time : Double) -> String {
        let sun = Date(timeIntervalSince1970:  time)
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .medium
        
        let formattedTime = formatter.string(from: sun)
        return formattedTime
    }
    

}
