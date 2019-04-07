//
//  InfoView.swift
//  KnightsMaps
//
//  Created by Sean Hall on 3/24/19.
//  Copyright © 2019 Alec. All rights reserved.
//

import UIKit
import MapKit

class InfoView: UIViewController {
    
    // building for segue data transfer temp data right now
    var building: KMBuilding?
    
    var delegate: FilterViewDelegate?
    
    @IBOutlet weak var testLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var infoLabel: UILabel!
    
    @IBOutlet weak var mapDisplay: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapDisplay.layer.cornerRadius = 10.0
        self.infoLabel.numberOfLines = 7
        
        self.nameLabel.text = building?.name
        self.infoLabel.text = building?.info
        
        setCenter(latitude: building!.latitude, longitude: building!.longitude)
        setPin(latitude: building!.latitude, longitude: building!.longitude)
        
    }
    
    @IBAction func backButton(_ sender: Any) {
        // normal naviagtion back to home screen??
        dismiss(animated: true)
    }
    
    func setCenter(latitude: Float, longitude: Float) {
        let location = CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude))
        let region = MKCoordinateRegion(center: location, latitudinalMeters: CLLocationDistance(exactly: 800)!, longitudinalMeters: CLLocationDistance(exactly:800)!)
        mapDisplay.setRegion(mapDisplay.regionThatFits(region), animated: true)
    }
    
    func setPin(latitude: Float, longitude: Float) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude))
        mapDisplay.addAnnotation(annotation)
    }
    
}
