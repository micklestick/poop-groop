//
//  ViewController.swift
//  KnightsMaps
//
//  Created by Alec on 2/13/19.
//  Copyright © 2019 Alec. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import ARCL
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet var sceneView: ARSCNView!

    let debug = true
    
    var sceneLocationView = SceneLocationView()

    // labels for the gps locations
    @IBOutlet var latitudeLabel: UILabel!
    @IBOutlet var longitudeLabel: UILabel!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var findLocationButton: UIButton!
    
    //var locationManager = LocationManager()
    var buildings = KMDatabaseHelper.makeObjectArray()
    var testPoints = KMDatabaseHelper.aTestPoints()
    
    var locationManager = CLLocationManager()
    
    //debug labels
    var positionLabel = UILabel()
    var distanceLabel = UILabel()
    var angleLabel = UILabel()

    //test node, will be set as last node in the list ATM
    var testNode: LocationAnnotationNode!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if debug {
            createDebugLabels()
        }
        
        sceneLocationView.run()
        view.addSubview(sceneLocationView)
        locationManager.delegate = self
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        addBuildingTags()
    }
    
    //called on location update
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //round location to display
        var lat = Double(locations.first?.coordinate.latitude ?? 0)
        var long = Double(locations.first?.coordinate.longitude ?? 0)
        lat = (lat*100000000000).rounded()/100000000000
        long = (long*100000000000).rounded()/100000000000

        positionLabel.text = "Lat: \(lat), Long: \(long)"

        let testlocation = testNode.location
        //let vectorToTest = testNode.eulerAngles
        let distanceInMeters = Double(locations.first?.distance(from: testlocation!) ?? 0)
        
        distanceLabel.text = "Distance: \(distanceInMeters)m"
        
        // TODO: angle needs work
        //let v = CGPoint(x: testNode.x - cameraPosition.x, y: testNode.y - cameraPosition.y);
        //let a = atan2(v.y, v.x) // Note: order of arguments
        //angleLabel.text = "Angle: \(a) deg"
        angleLabel.text = "X: \(testNode.position.x), Y: \(testNode.position.y), Z: \(testNode.position.z) "

        
    }
    
    // TODO: write code to get this, The LNTouchDelegate
    // is not working, we can use the following
    /*
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
    }
    */
    func locationNodeTouched(node: AnnotationNode) {
        /* Do stuffs with the node instance
        
        // node could have either node.view or node.image
        if let nodeView = node.view{
            // Do stuffs with the nodeView
            // ...
        }
        if let nodeImage = node.image{
            // Do stuffs with the nodeImage
            // ...
        }
         */
    }
    
    // TODO: this function is using the testPoints array, when the database is hooked up
    // we will change the testPoint to buildings
    func addBuildingTags() {
        
        for building in testPoints {
            let coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(building.location.latitude), longitude: CLLocationDegrees(building.location.longitude))
            
            //changed the altitude to 5 for testing, 25-35 will be needed for buildings
            let location = CLLocation(coordinate: coordinate, altitude: 5)
            
            // we may want images to float so keep this code around for now
            //let image = UIImage(named: "pin")!
            //let annotationNode = LocationAnnotationNode(location: location, image: image)

            // TODO: FIX THE WHITE CORNERS, not clipping correctly
            //create a view with size
            let tagView = UIView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 800, height: 100)))
            tagView.backgroundColor = UIColor.clear
            tagView.layer.cornerRadius = 40.0
            tagView.layer.borderWidth = 10.0
            tagView.layer.masksToBounds = true
            tagView.layer.borderColor = UIColor(red:0.0, green:0.52, blue:1.0, alpha:1.0).cgColor
            tagView.layer.backgroundColor = UIColor.clear.cgColor
            tagView.clipsToBounds = true
            
            let buildingTitle = UILabel(frame: tagView.frame)
            buildingTitle.text = building.name
            buildingTitle.backgroundColor = UIColor(red: 0.0, green: 1.0, blue: 1.0, alpha: 0.3)
            buildingTitle.textAlignment = NSTextAlignment.center
            buildingTitle.font = UIFont.systemFont(ofSize: 100)
            
            tagView.addSubview(buildingTitle)

            let annotationNode = LocationAnnotationNode(location: location, view: tagView)
            
            annotationNode.scaleRelativeToDistance = true
            sceneLocationView.addLocationNodeWithConfirmedLocation(locationNode: annotationNode)
            
            //last node in list will be a test "selected" node
            testNode = annotationNode
        }
    }
    
    // this sets the AR View to the size of the phone's screen
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        sceneLocationView.frame = view.bounds
    }
    
    // TODO: Clean this up as we arent using the old view
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        //let configuration = ARWorldTrackingConfiguration()
        
        // Run the view's session
        //sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //Stop the scene when the view dissapears
        sceneLocationView.run()

    }
    
    // TODO: We can kill this code when we are done with testing
    // Still nice to have to gather data for now
    func updateUI(loc: CLLocation) {
 
        latitudeLabel.text = String(format: "%.8f", loc.coordinate.latitude)
        longitudeLabel.text = String(format: "%.8f", loc.coordinate.longitude)
        statusLabel.text = "New Location Detected!"
    }
    
    //MARK: - Target/Action
    @IBAction func findLocation() {
        //locationManager.findLocation(view: self)

    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user

    }

    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay

    }

    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required

    }
    
    func createDebugLabels() {
        
        let point = CGPoint(x: 10, y: view.frame.height - 200)
        let size = CGSize(width: 800, height: 100)
        let rekt = CGRect(origin: point, size: size)
        positionLabel = UILabel(frame: rekt)
        positionLabel.textColor = UIColor.green
        positionLabel.text = "Lat: 12.12121, Long: 12.121212"
        sceneLocationView.addSubview(positionLabel)
        
        let point2 = CGPoint(x: 10, y: view.frame.height - 150)
        let size2 = CGSize(width: 800, height: 100)
        let rekt2 = CGRect(origin: point2, size: size2)
        distanceLabel = UILabel(frame: rekt2)
        distanceLabel.textColor = UIColor.green
        distanceLabel.text = "Distance: 12.003m"
        sceneLocationView.addSubview(distanceLabel)
        
        let point3 = CGPoint(x: 10, y: view.frame.height - 100)
        let size3 = CGSize(width: 800, height: 100)
        let rekt3 = CGRect(origin: point3, size: size3)
        angleLabel = UILabel(frame: rekt3)
        angleLabel.textColor = UIColor.green
        angleLabel.text = "Angle: 12.12121 deg"
        sceneLocationView.addSubview(angleLabel)
    }

}
