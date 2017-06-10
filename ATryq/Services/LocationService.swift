//
//  LocationService.swift
//
//
//  Created by Anak Mirasing on 5/18/2558 BE.
//
//

import Foundation
import CoreLocation

protocol LocationServiceDelegate {
    func didGetLocation(_ location: [CLLocation])
    func didLocationFailWithError(_ error: NSError)
}

class LocationService: NSObject, CLLocationManagerDelegate {
    static let shared: LocationService = {
        let instance = LocationService()
        return instance
    }()

    var locationManager: CLLocationManager?
    var currentLocation: CLLocation?
    var delegate: [LocationServiceDelegate] = [];

    var authorizationStatus: CLAuthorizationStatus {
        get {
            return CLLocationManager.authorizationStatus()
        }
    }
    

    override init() {
        super.init()

        self.locationManager = CLLocationManager()
        guard let locationManager = self.locationManager else {
            return
        }
        
        if CLLocationManager.authorizationStatus() == .notDetermined {
            // you have 2 choice 
            // 1. requestAlwaysAuthorization
            // 2. requestWhenInUseAuthorization
            locationManager.requestWhenInUseAuthorization()
        }
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation// The accuracy of the location data
        locationManager.distanceFilter = 10 // The minimum distance (measured in meters) a device must move horizontally before an update event is generated.
        locationManager.delegate = self
    }
    
    func requestLocation() {
        print(" Location requestLocation")
        self.locationManager?.requestLocation()
    }
    
    
    func startUpdatingLocation() {
        print("Starting Location Updates")
        self.locationManager?.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        print("Stop Location Updates")
        self.locationManager?.stopUpdatingLocation()
    }
    
    
    
    // CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        guard let location = locations.last else {
            return
        }
        
        // singleton for get last(current) location
        currentLocation = location
        
        // use for real time update location
        updateLocation(locations)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        // do on error
        updateLocationDidFailWithError(error as NSError)
    }
    
    // Private function
    fileprivate func updateLocation(_ currentLocation: [CLLocation]){

//        guard let delegate = self.delegate else {
//            return
//        }
        
        delegate.forEach({ (locationServiceDelegate) in
            locationServiceDelegate.didGetLocation(currentLocation)
        })
    }
    
    fileprivate func updateLocationDidFailWithError(_ error: NSError) {
        
//        guard let delegate = self.delegate else {
//            return
//        }
        
        delegate.forEach({ (locationServiceDelegate) in
            locationServiceDelegate.didLocationFailWithError(error)
        })
    }
    
    func getQuickLocationUpdate() {
        // Request location authorization
        if (self.authorizationStatus == .notDetermined || self.authorizationStatus == .denied || self.authorizationStatus == .restricted ) {
       LocationService.requestWhenInUseAuthorization()
        
        }
        // Request a location update
        self.locationManager?.requestLocation()
        // Note: requestLocation may timeout and produce an error if authorization has not yet been granted by the user
    }
    
    //Mark:- Request Authorization
    
    public class  func requestWhenInUseAuthorization(){
        
        LocationService.shared.locationManager?.requestWhenInUseAuthorization()
        self.shared.locationManager?.allowsBackgroundLocationUpdates = false;
    }
    
    public class func requestAlwaysAuthorization(){
        
        LocationService.shared.locationManager!.requestAlwaysAuthorization()
        self.shared.locationManager?.allowsBackgroundLocationUpdates = true;
    }
    
    func appDidEnterBackground(){
        LocationService.requestWhenInUseAuthorization();
    }
    func appDidBecomeActive(){
        LocationService.requestWhenInUseAuthorization();
    }
    
}
