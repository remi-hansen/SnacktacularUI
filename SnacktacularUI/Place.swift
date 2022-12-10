//
//  Place.swift
//  PlaceLookup
//
//  Created by Remi Pacifico Hansen on 11/28/22.
//

import Foundation
import MapKit

struct Place: Identifiable {
    let id = UUID().uuidString
    
    private var mapItem: MKMapItem
    
    init(mapItem: MKMapItem) {
        self.mapItem = mapItem
    }
    
    
    var name: String {
        self.mapItem.name ?? ""
    }
    
    var address: String {
        let placemark = self.mapItem.placemark
        var cityAndState = ""
        var address = ""
        
        cityAndState = placemark.locality ?? "" //city
        if let state = placemark.administrativeArea {
            //show either state or city,state
            cityAndState = cityAndState.isEmpty ? state: "\(cityAndState), \(state)"
        }
        address = placemark.subThoroughfare ?? "" //address #
        if let street = placemark.thoroughfare {
            //just to show street unless there is also a street #
            address = address.isEmpty ? street : "\(address) \(street)"
        }
        
        if address.trimmingCharacters(in: .whitespaces).isEmpty && !cityAndState.isEmpty {
            //No address, then just city and state
            address = cityAndState
        }else {
            address = cityAndState.isEmpty ? address : "\(address) \(cityAndState)"
        }
        
        return address
        
    }
    
    var latitude: Double {
        self.mapItem.placemark.coordinate.latitude
    }
    
    var longitude: Double {
        self.mapItem.placemark.coordinate.longitude
    }
    
}
