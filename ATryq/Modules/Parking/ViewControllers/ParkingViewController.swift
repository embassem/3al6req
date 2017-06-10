//
//  ParkingViewController.swift
//  AalTarek
//
//  Created by Bassem Abbas on 6/5/17.
//  Copyright © 2017 Bassem Abbas. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ParkingViewController: UIViewController {

    @IBOutlet weak var mapActionBtn: UIBarButtonItem!
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.showsUserLocation = true;
        mapView.showsPointsOfInterest = true;
        
        LocationService.requestWhenInUseAuthorization();
        LocationService.shared.delegate.append(self);
        LocationService.shared.startUpdatingLocation()
        
       showLocation()
        // Do any additional setup after loading the view.
    }

    
    func showLocation (){
        
        if let savedLocation = getSavedLocation(){
            
            
            let annotation = MKPointAnnotation()
            annotation.title = "Park Location"
            annotation.coordinate = savedLocation
            
            self.mapView.addAnnotation(annotation)
            
            self.mapView.setCenter(savedLocation, animated: true);
            
            
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func mapBtnAction(_ sender: UIBarButtonItem) {
        
        self.saveCurrentLocation()
    }
    
    func saveCurrentLocation()  {
        
        let location = self.mapView.userLocation.coordinate;
        
        UserDefaults.standard.set(location.latitude, forKey: "latitude");
        UserDefaults.standard.set(location.longitude, forKey: "longitude");
        
        showLocation();
    }
    
    
    func getSavedLocation () ->  CLLocationCoordinate2D?{
        
        let latitude =   UserDefaults.standard.double(forKey: "latitude")
        let longitude = UserDefaults.standard.double(forKey:  "longitude")
        
        if (latitude != 0.0 ){
        let coordinate =  CLLocationCoordinate2D(latitude: latitude, longitude: longitude);
        
        return coordinate;
        }else {
            
            return nil
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


extension ParkingViewController : LocationServiceDelegate {
    
    func didGetLocation(_ location: [CLLocation]) {
        
        
        guard let location = location.last as CLLocation? else { return }
        
        let userCenter = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        // Does not have to be userCenter, could replace latitude: and longitude: with any value you would like to center in on
        
        let region = MKCoordinateRegion(center: userCenter, span: MKCoordinateSpan(latitudeDelta: 6, longitudeDelta: 6))
        
        self.mapView.setRegion(region, animated: true)    }
    
    
    func didLocationFailWithError(_ error: NSError) {
        
        
    }
    
}
