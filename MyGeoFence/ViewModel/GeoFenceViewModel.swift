//
//  GeoFenceViewModel.swift
//  MyGeoFence
//
//  Created by Reginald Grant on 5/27/26.
//

import Foundation
import CoreLocation
import Combine

class GeoFenceViewModel:ObservableObject{
    
    @Published var statusText: String = "Not Shared"
    @Published var lastEvent: String = "No events Yet"
    @Published var event:[GeoFenceModel] = []
    
    
    // Normal init
    // private let service:GeoFenceService = GeoFenceService()
    
    private let service:GeoFenceService 
    
    
    // Set = [unique elemnts]
    private var cancellables: Set<AnyCancellable> = []
    
    // Dependency Injection
    init(service:GeoFenceService = GeoFenceService()){
        
        self.service = service
        bindService()
    }
    
    func bindService(){
        
        service.$statusText
            .receive(on: DispatchQueue.main)
            .assign(to: &$statusText)
        
        service.$lastEventText
            .receive(on: DispatchQueue.main)
            .sink{
                [weak self] eventText in
                guard let self else { return }
                
                self.lastEvent = eventText
                
                if eventText != "No events yet" {
                    self.event.insert(GeoFenceModel(message: eventText), at: 0)
                }
            }.store(in: &cancellables)
    }
    
    func requestPermission(){
        service.requestPermissions()
    }
    
    func startGeo(){
        let center: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 32.7083333, longitude: -117.155722)
        let radius: CLLocationDistance = 2000
        
        service.startGeoFence(center: center, radius: radius, id: "SDGKU")
    }
    
    func stopGeo(){
        service.stopGeoFence(id: "SDGKU")
    }
    
    func clearLogs(){
        event.removeAll()
    }
    
}
