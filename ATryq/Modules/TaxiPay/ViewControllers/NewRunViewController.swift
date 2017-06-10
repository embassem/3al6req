/*
 * Copyright (c) 2015 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit
import CoreData
import CoreLocation
import HealthKit
import MapKit
import AudioToolbox

let DetailSegueName = "Details"

class NewRunViewController: UIViewController {
    var managedObjectContext: NSManagedObjectContext?
    
    var run: Run!
    
    @IBOutlet weak var ShowDetailSwitch: UISwitch!
    
    
    
//    @IBOutlet weak var promptLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var rideStarted = false;
    
    @IBOutlet weak var highSpeedDistanceLabel: UILabel!
    @IBOutlet weak var SpeedLabel: UILabel!
    @IBOutlet weak var SpeedShowLabel: UILabel!
    @IBOutlet weak var DistanceShowLabel: UILabel!
    @IBOutlet weak var TimeShowLabel: UILabel!
    @IBOutlet weak var JamDistanceLabel: UILabel!
    @IBOutlet weak var lowSpeedDistanceLabel: UILabel!
    @IBOutlet weak var StopTimestampLabel: UILabel!
    
//    @IBOutlet weak var discriptionTextView: UITextView!
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    @IBOutlet weak var mapView: MKMapView!
    
    var seconds = 0.0
    var distance = 0.0
    var lowSpeedDistance = 0.0 ;
    var highSpeedDistance = 0.0 ;
    var jamDistance = 0.0 ;
    var StopTimestamp = 0.0 ;
    lazy var locationManager: CLLocationManager = {
        var _locationManager = CLLocationManager()
        _locationManager.delegate = self
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest
        _locationManager.activityType  = CLActivityType.automotiveNavigation
        
        // Movement threshold for new events
        _locationManager.distanceFilter = 1.0
        
        
        _locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        return _locationManager
    }()
    
    lazy var locations = [CLLocation]()
    lazy var timer = Timer()
    var requestTimer: Timer?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        startButton.isHidden = false
//        promptLabel.isHidden = false
        
        timeLabel.isHidden = true
        JamDistanceLabel.isHidden = true
        SpeedLabel.isHidden = true
        stopButton.isHidden = true
        
        let status = CLLocationManager.authorizationStatus()
        if status == .notDetermined || status == .denied || status == .authorizedWhenInUse {
            // present an alert indicating location authorization required
            // and offer to take the user to Settings for the app via
            // UIApplication -openUrl: and UIApplicationOpenSettingsURLString
            locationManager.requestAlwaysAuthorization()
            
        }
        if CLLocationManager.locationServicesEnabled() {
            // Find the current location
            locationManager.startMonitoringSignificantLocationChanges()
            locationManager.startUpdatingLocation()
            locationManager.startUpdatingHeading()
            
            
            //rest of code...
        }
        
        
        locationManager.delegate = self;
        
        
        mapView.isHidden = false
        mapView.showsUserLocation = true
        mapView.setUserTrackingMode(MKUserTrackingMode.followWithHeading, animated: true)
        
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer.invalidate()
        requestTimer?.invalidate();
    }
    
    func eachSecond() {
        seconds += 1
        
        
        //SpeedLabel.text = "\(self.locations.last?.speed)";
        SpeedShowLabel.text = "0";
        if (self.locations.count > 0){
            SpeedShowLabel.text = "\(self.locations.last!.speed)";
        }
        
        
        let totalDistancedQuantity = HKQuantity(unit: HKUnit.meter(), doubleValue: distance)
        
        DistanceShowLabel.text =  totalDistancedQuantity.description
        
        
        
        let secondsQuantity = HKQuantity(unit: HKUnit.second(), doubleValue: seconds)
        // timeLabel.text = "Time: " + secondsQuantity.description
        TimeShowLabel.text =  secondsQuantity.description
        
        let StopQuantity = HKQuantity(unit: HKUnit.second(), doubleValue: StopTimestamp)
        StopTimestampLabel.text =  StopQuantity.description
        
        let lowSpeedQuantity = HKQuantity(unit: HKUnit.meter(), doubleValue: lowSpeedDistance)
        lowSpeedDistanceLabel.text =  lowSpeedQuantity.description
        
        let highSpeedQuantity = HKQuantity(unit: HKUnit.meter(), doubleValue: highSpeedDistance)
        highSpeedDistanceLabel.text =  highSpeedQuantity.description
        
        let jamQuantity = HKQuantity(unit: HKUnit.meter(), doubleValue: jamDistance)
        JamDistanceLabel.text =  jamQuantity.description
        
        
        
        //    let paceUnit = HKUnit.secondUnit().unitDividedByUnit(HKUnit.meterUnit())
        //    let paceQuantity = HKQuantity(unit: paceUnit, doubleValue: seconds / distance)
        
        //    let speedUnit = HKUnit.meterUnit().unitDividedByUnit(HKUnit.secondUnit())
        //    let speedQuantity = HKQuantity(unit: speedUnit, doubleValue: distance / seconds  )
        //    paceLabel.text = "Speed : " + speedQuantity.description
        
        //
        //    checkNextBadge()
        //    if let upcomingBadge = upcomingBadge {
        //      let nextBadgeDistanceQuantity = HKQuantity(unit: HKUnit.meterUnit(), doubleValue: upcomingBadge.distance! - distance)
        //      nextBadgeLabel.text = "\(nextBadgeDistanceQuantity.description) until \(upcomingBadge.name!)"
        //      nextBadgeImageView.image = UIImage(named: upcomingBadge.imageName!)
        //    }
    }
    
    func requestCurrentLocation(){
        locationManager.requestLocation();
    }
    
    func startLocationUpdates() {
        let status = CLLocationManager.authorizationStatus()
        if status == .notDetermined || status == .denied || status == .authorizedWhenInUse {
            // present an alert indicating location authorization required
            // and offer to take the user to Settings for the app via
            // UIApplication -openUrl: and UIApplicationOpenSettingsURLString
            locationManager.requestAlwaysAuthorization()
        }
        
        
        // Here, the location manager will be lazily instantiated
        locationManager.startUpdatingLocation()
    }
    
    
    @IBAction func shoeDetailGps(_ sender:UISwitch) {
        
//        discriptionTextView.isHidden = !sender.isOn
        
        
    }
    
    func saveRun() {
        
        let savedRun = Run();
        savedRun.distance = distance
        savedRun.duration = seconds
        savedRun.timestamp = Date()
        savedRun.HSD = highSpeedDistance;
        savedRun.LSD = lowSpeedDistance;
        savedRun.JSD = jamDistance;
        savedRun.Stop = StopTimestamp;
        // 2
        var savedLocations = [Location]()
        for location in locations {
            let savedLocation = Location();
            savedLocation.timestamp = location.timestamp
            savedLocation.latitude = location.coordinate.latitude
            savedLocation.longitude = location.coordinate.longitude
            savedLocations.append(savedLocation)
        }
        
        savedRun.locations = NSOrderedSet(array: savedLocations)
        run = savedRun
        
        // 1
        //    let savedRun = NSEntityDescription.insertNewObjectForEntityForName("Run",
        //      inManagedObjectContext: managedObjectContext!) as! Run
        //    savedRun.distance = distance
        //    savedRun.duration = seconds
        //    savedRun.timestamp = NSDate()
        //
        //    // 2
        //    var savedLocations = [Location]()
        //    for location in locations {
        //      let savedLocation = NSEntityDescription.insertNewObjectForEntityForName("Location",
        //        inManagedObjectContext: managedObjectContext!) as! Location
        //      savedLocation.timestamp = location.timestamp
        //      savedLocation.latitude = location.coordinate.latitude
        //      savedLocation.longitude = location.coordinate.longitude  
        //      savedLocations.append(savedLocation)
        //    }
        //
        //    savedRun.locations = NSOrderedSet(array: savedLocations)
        //    run = savedRun
        //
        //    // 3
        //    var error: NSError?
        //    let success: Bool
        //    do {
        //      try managedObjectContext!.save()
        //      success = true
        //    } catch let error1 as NSError {
        //      error = error1
        //      success = false
        //    }
        //    if !success {
        //      print("Could not save the run!")
        //    }
    }
    
    @IBAction func startPressed(_ sender: AnyObject) {
        startButton.isHidden = true
//        promptLabel.isHidden = true
        
        timeLabel.isHidden = false
        SpeedLabel.isHidden = false
        StopTimestampLabel.isHidden = false
        highSpeedDistanceLabel.isHidden = false
        lowSpeedDistanceLabel.isHidden = false
        JamDistanceLabel.isHidden = false
        
        stopButton.isHidden = false
        
        seconds = 0.0
        distance = 0.0
        locations.removeAll(keepingCapacity: false)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(NewRunViewController.eachSecond), userInfo: nil, repeats: true)
        requestTimer?.invalidate()
        requestTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(NewRunViewController.requestCurrentLocation), userInfo: nil, repeats: true)
        
        
        startLocationUpdates()
        rideStarted = true;
        mapView.isHidden = false
        
    }
    
    func resetCounters(){
        self.seconds = 0.0
        self.distance = 0.0
        self.lowSpeedDistance = 0.0 ;
        self.highSpeedDistance = 0.0 ;
        self.jamDistance = 0.0 ;
        self.StopTimestamp = 0.0 ;
        self.locations.removeAll();
    }
    
    @IBAction func stopPressed(_ sender: AnyObject) {
        let actionSheet = UIActionSheet(title: "Run Stopped", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "Save", "Discard")
        actionSheet.actionSheetStyle = .default
        actionSheet.show(in: view)
        locationManager.stopMonitoringSignificantLocationChanges();
        rideStarted = false;
    }
    
    func playSuccessSound() {
        let soundURL = Bundle.main.url(forResource: "success", withExtension: "wav")
        var soundID : SystemSoundID = 0
        AudioServicesCreateSystemSoundID(soundURL! as CFURL, &soundID)
        AudioServicesPlaySystemSound(soundID)
        
        //also vibrate
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate));
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailViewController = segue.destination as? DetailViewController {
            detailViewController.run = run
        }
    }
}

// MARK: - MKMapViewDelegate
extension NewRunViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer! {
        if !overlay.isKind(of: MKPolyline.self) {
            return nil
        }
        
        let polyline = overlay as! MKPolyline
        let renderer = MKPolylineRenderer(polyline: polyline)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 3
        return renderer
    }
}

// MARK: - CLLocationManagerDelegate
extension NewRunViewController: CLLocationManagerDelegate {
    
    //MARK: - Calculation
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // self.locations.sortInPlace( { s1, s2 in return s1.timestamp.timeIntervalSince1970 < s2.timestamp.timeIntervalSince1970 } )
        
        for location in locations {
            let howRecent = location.timestamp.timeIntervalSinceNow
            print ("New Point  =========>")
            print(location.speed , howRecent , location.horizontalAccuracy)
            
            if abs(howRecent) < 10  && location.horizontalAccuracy < 100 {//
                //update distance
                if self.locations.count > 0 {
                    
                    let lastPoint = self.locations.last!
                    if (lastPoint.speed > 0 &&  location.speed > 0){
                        //First Condation  user still moving  ;
                        
                        print("1st First Condation  user still moving", lastPoint.speed,location.speed )
                        
                        let Distance =   location.distance(from: lastPoint)
                        if (location.speed < 5.56){
                            jamDistance += Distance;
                            
                        }
                        else if (location.speed < 16.6667){
                            lowSpeedDistance += Distance
                        }else {
                            highSpeedDistance += Distance;
                            
                            
                        }
                        
                    }else if (lastPoint.speed > 0 &&  location.speed <= 0.6){
                        //Secand Condation  user was moving then stoped  ;
                        print("2nd Secand Condation  user was moving then stoped ", lastPoint.speed,location.speed )
                        
                        let Distance =   location.distance(from: lastPoint)
                        if (location.speed < 5.56){
                            jamDistance += Distance;
                            
                        }
                        else if (location.speed < 16.6667){
                            lowSpeedDistance += Distance
                        }else {
                            highSpeedDistance += Distance;
                            
                            
                        }
                        
                    }
                    else if (lastPoint.speed <= 0.6 &&  location.speed <= 0.6){
                        //third  Condation  user still  stoped  ;
                        print("3rd third  Condation  user still  stoped", lastPoint.speed,location.speed )
                        print ("Stop  Time  : \(location.timestamp.timeIntervalSince(lastPoint.timestamp))")
                        
                        StopTimestamp += location.timestamp.timeIntervalSince(lastPoint.timestamp)
                        
                        
                    }else if (lastPoint.speed <= 0.6 &&  location.speed > 0){
                        //fourth  Condation  user was  stoped  and now moving  ;
                        print("4th fourth  Condation  user was  stoped  and now moving ", lastPoint.speed,location.speed )
                        StopTimestamp += location.timestamp.timeIntervalSince(lastPoint.timestamp)
                        let Distance =   location.distance(from: lastPoint)
                        if (location.speed < 5.56){
                            jamDistance += Distance;
                            
                        }
                        else if (location.speed < 16.6667){
                            lowSpeedDistance += Distance
                        }else {
                            highSpeedDistance += Distance;
                            
                            
                        }
                        
                        
                    }else {
                        
                        print("***** unknown  Condation  user still moving", lastPoint.speed,location.speed )
                        
                    }
                    distance += location.distance(from: self.locations.last!)
                    
                    let str = "point speed: \(location.speed) horizontalAccuracy :\(location.horizontalAccuracy) timeIntervalSinceNow :\(location.timestamp.timeIntervalSinceNow) distanceFromLastLocation:\(location.distance(from: lastPoint)) timeIntervalSinceLast:\(location.timestamp.timeIntervalSince(lastPoint.timestamp)) \n__________________________________\n "
                    
//                    let oldtext =  self.discriptionTextView.text
//                    let newStr =  oldtext! + str;
//                    
//                    self.discriptionTextView.text = newStr ;
                    
                    
                    
                    var coords = [CLLocationCoordinate2D]()
                    coords.append(self.locations.last!.coordinate)
                    coords.append(location.coordinate)
                    
                    let region = MKCoordinateRegionMakeWithDistance(location.coordinate, 500, 500)
                    mapView.setRegion(region, animated: true)
                    
                    mapView.add(MKPolyline(coordinates: &coords, count: coords.count))
                }
                
                //save location
                self.locations.append(location)
            }else {
                  print("***** point neglected ", location.horizontalAccuracy,location.timestamp )
                
            }
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print(error.localizedDescription)
    }
}

// MARK: - UIActionSheetDelegate
extension NewRunViewController: UIActionSheetDelegate {
    func actionSheet(_ actionSheet: UIActionSheet, clickedButtonAt buttonIndex: Int) {
        //save
        if buttonIndex == 1 {
            saveRun()
            performSegue(withIdentifier: DetailSegueName, sender: nil)
        }
            //discard
        else if buttonIndex == 2 {
            navigationController?.popToRootViewController(animated: true)
        }
    }
}
