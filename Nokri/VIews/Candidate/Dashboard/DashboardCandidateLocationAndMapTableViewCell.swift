//
//  DashboardCandidateLocationAndMapTableViewCell.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 5/5/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class DashboardCandidateLocationAndMapTableViewCell: UITableViewCell,GMSMapViewDelegate {

    var markerDict: [Int: GMSMarker] = [:]
    var zoom: Float = 10
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var btnDeleteAccount: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
       // map()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    //MARKL:- Map
    
    struct Place {
        let id: Int
        let name: String
        let lat: CLLocationDegrees
        let lng: CLLocationDegrees
        let icon: String
    }
    
    func nokri_map(){
        
        let camera = GMSCameraPosition.camera(withLatitude: 34.1381168, longitude: -118.3555723, zoom: zoom)
        self.mapView.camera = camera
        
        do {
            if let styleURL = Bundle.main.url(forResource: "style", withExtension: "json") {
                mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
                NSLog("Unable to find style.json")
            }
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
        
        let places = [
            Place(id: 0, name: "MrMins", lat: 34.1331168, lng: -118.3550723, icon: "i01"),
            ]
        
        for place in places {
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: place.lat, longitude: place.lng)
            marker.title = place.name
            marker.snippet = "\(place.name)"
            marker.map = self.mapView
            markerDict[place.id] = marker
        }
        
    }
 
}
