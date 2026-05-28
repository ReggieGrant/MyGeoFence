//
//  GeoFenceView.swift
//  MyGeoFence
//
//  Created by Reginald Grant on 5/27/26.
//

import SwiftUI

struct GeoFenceView: View {
    @StateObject var vm:GeoFenceViewModel = GeoFenceViewModel()
    
    var body: some View {
        VStack(spacing:20){
            Text("Geofence Alert")
                .font(.title2)
                .bold()
            
            Text(vm.statusText)
            Text(vm.lastEvent)
                .font(.footnote)
            
            HStack{
                Button("Request Permissions"){
                    vm.requestPermission()
                }.buttonStyle(.borderedProminent)
                
                Button("Start"){
                    vm.startGeo()
                }.buttonStyle(.bordered)
                
                Button("Stop"){
                    vm.stopGeo()
                    
                }.buttonStyle(.bordered)
            }
            
            List(vm.event){ event in
                VStack(spacing: 20){
                    Text(event.message)
                        .font(.title)
                        .bold()
                    Text(event.date.formatted(date:.abbreviated, time: .standard))
                    
                    
                }
                
            }
        }
    }
}

#Preview {
    GeoFenceView()
}
