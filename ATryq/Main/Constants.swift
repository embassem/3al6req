//
//  Config.swift
//  GooTaxi
//
//  Created by Bassem on 3/15/17.
//  Copyright © 2017 ADLANC. All rights reserved.
//

import Foundation
import GoogleMaps



let KReciveNotification = "KReciveNotification"

struct Config {
    //Don't static base url as it might be change Dynamicly
  var apibaseUrl = ""
  
static let GOOGLE_MAP_API_KEY = "AIzaSyAAvj-jWhQQPL28SD-Y9cYDTeIQDsMYETg";//3Al-Tarek
static let GOOGLE_PLACES_API_KEY =   "AIzaSyAAvj-jWhQQPL28SD-Y9cYDTeIQDsMYETg";//3Al-Tarek
//31.200046,29.9187005  alex
//26.3546523,49.8520537   Dammam
static let GOOGLE_MAP_INITIAL_LOCATION:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 31.200046, longitude: 29.9187005)
    
    
static let GOOGLE_MAP_INITIAL_ZOME:Float = 6.0;
    
    
    static let LOCATION_SERVICE_FILTER_DISTANCE = 50.0;
    static let LOCATION_SERVICE_ACCURACY = kCLLocationAccuracyBest
    
    
}
