//
//  GeoFenceModel.swift
//  MyGeoFence
//
//  Created by Reginald Grant on 5/27/26.
//

import Foundation


struct GeoFenceModel:Identifiable {
    let id:UUID
    let date:Date
    let message:String
    
    init(id:UUID = UUID(), date:Date = Date(), message:String) {
        self.id = id
        self.date = date
        self.message  = message
    }
}
