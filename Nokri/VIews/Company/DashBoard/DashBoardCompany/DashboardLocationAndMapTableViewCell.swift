//
//  DashboardLocationAndMapTableViewCell.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 5/5/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class DashboardLocationAndMapTableViewCell: UITableViewCell,GMSMapViewDelegate {

    var markerDict: [Int: GMSMarker] = [:]
    var zoom: Float = 30

    @IBOutlet weak var btnDeleteAccount: UIButton!
    @IBOutlet weak var mapView: GMSMapView!
    var latitude:String?
    var longitude:String?
    
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

    func map(){

        let camera = GMSCameraPosition.camera(withLatitude: (latitude! as NSString).doubleValue, longitude: (longitude! as NSString).doubleValue, zoom: zoom)
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
            Place(id: 0, name: "MrMins", lat: (latitude! as NSString).doubleValue, lng: (longitude! as NSString).doubleValue, icon: "i01"),
            ]

        for place in places {
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: place.lat, longitude: place.lng)
            marker.title = place.name
            marker.snippet = "\(place.name)"

            //marker.icon = self.imageWithImage(image: UIImage(named: place.icon)!, scaledToSize: CGSize(width: 35.0, height: 35.0))
            marker.map = self.mapView
            markerDict[place.id] = marker
        }

    }
    
    
}
