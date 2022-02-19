//
//  LocationFound.swift
//  LocationFound
//
//  Created by comviva on 19/02/22.
//

import Foundation
import CoreLocation


public class LocationManager : NSObject, CLLocationManagerDelegate {
    
    public var lManager : CLLocationManager
    public var currentLocation : CLLocation?
    public var isPermissionGranted = false
    
    public override init() {
        lManager = CLLocationManager()
        lManager.requestWhenInUseAuthorization()
        lManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        super.init()
        lManager.delegate = self
    }
    
    static var instance = LocationManager()
    
    public func startTracking() -> Bool{
        
        if isPermissionGranted {
            lManager.startUpdatingLocation()
            return true
        }
        
        return false
    }
    
    public func stopTracking() -> Bool {
        if isPermissionGranted {
            lManager.stopUpdatingLocation()
            return true
        }
        return false
    }
    
    public func getCurrentAddress(completion: @escaping (String) -> Void ){
        // geocoding
        let gc = CLGeocoder()
        if let loc = currentLocation {
            gc.reverseGeocodeLocation(loc) { (placeResult, err) in
                if let addr = placeResult?.first {
                    let streetAddr = "\(addr.subLocality ?? ""), \(addr.locality ?? ""), \(addr.country ?? ""), \(addr.administrativeArea ?? "")"
                    let city = addr.locality ?? ""
                    print("Address: \(streetAddr)")
                    
                    completion(city)
                }
            }
        }
    }
    
    
    public func getGeoCoord(address: String, completion: @escaping (CLLocation) -> Void){
        // forward geocoding
        let gc = CLGeocoder()
        gc.geocodeAddressString(address) { (result, err) in
            if let place = result?.first {
                if let loc = place.location {
                    print("Lat:\(loc.coordinate.latitude)")
                    print("Long: \(loc.coordinate.longitude)")
                    completion(loc)
                }
            }
        }
    }
    
    
    // From delegate
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Location updated..")
        if let loc = locations.last {
            currentLocation = loc
        }
        
    }
    
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status{
        case .denied:
            isPermissionGranted = false
            print("Denied")
        case .authorizedWhenInUse:
            isPermissionGranted = true
            startTracking()
            print("Granted")
        default:
            isPermissionGranted = false
            print("Unknown auth")
        }
    }
}
