//
//  GeoFenceService.swift
//  MyGeoFence
//
//  Created by Reginald Grant on 5/27/26.
//

import Foundation
import CoreLocation
import Combine


class GeoFenceService:NSObject,ObservableObject,CLLocationManagerDelegate{
    
    // Avalible to viewModel or View, shared varibles
    @Published var statusText:String = "Not Started"
    @Published var lastEventText:String = "No Events Yet"
    
    
    
    // Create Managers
    private let manager:CLLocationManager = CLLocationManager()
    
    override init(){
        
        super.init()
        manager.delegate = self
    }
    
    
    // STEP 1 Ask for permision
    func requestPermissions(){
        
        manager.requestAlwaysAuthorization()
    }
    
    
    // Step 2 START THE GEOFENCE FEATURE
    // REGION --> LAT,LONG -->
    // RADIUS --> IN METERS
    // ID Save the Region --> STRING
    
    func startGeoFence(center:CLLocationCoordinate2D,radius:CLLocationDistance,id:String){
        guard CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) else {
            statusText = "Geofencing not available on this device"
            return
        }
        
        // Get to this line
        let region:CLCircularRegion = CLCircularRegion(center: center, radius: radius, identifier: id)
        
        region.notifyOnEntry = true
        region.notifyOnExit = true
        
        manager.startMonitoring(for: region)
        
        statusText = "Monitoring: \(region)"
        
        
        
        
    }
    
    // Stops yhr Geofencing updates for a specific region
    func stopGeoFence(id:String){
        
        for region in manager.monitoredRegions where region.identifier == id{
            
            manager.stopMonitoring(for: region)
        }
        
        statusText = "Not monitoring \(id)"
        
    }
    
    // MARK: Delegate functions --> CoreFunction from the package
    
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        lastEventText = "Did satrt montoring \(region.identifier)"
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        lastEventText = " Entered \(region.identifier)"
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        lastEventText = " Exited \(region.identifier)"
    
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        lastEventText = "ERROR: \(error.localizedDescription)"
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        switch manager.authorizationStatus {
        case .notDetermined:
            statusText = "Permission: Not determined"
        case .restricted:
            statusText = "Permission: Restricted"
        case .denied:
            statusText = "Permission: Denied"
        case .authorizedAlways:
            statusText = "Permission: Authorized always"
        case .authorizedWhenInUse:
            statusText = "Permission: Authrized when in use"
        
            
        }
    }
    
    
    
    
    
    
    
}
