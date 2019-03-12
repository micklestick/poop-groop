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
import SwiftLocation
import CoreMotion

class ViewController: UIViewController {

    let debug = true
    
    var sceneLocationView = SceneLocationView()

    private let manager = CMMotionManager()

    //var locationManager = LocationManager()
    var buildings = KMDatabaseHelper.makeObjectArray()
    var testPoints = KMDatabaseHelper.aTestPoints()
    
    //debug labels
    var positionLabel = UILabel()
    var distanceLabel = UILabel()
    var angleLabel = UILabel()

    //test node, will be set as last node in the list ATM
    var testNode: LocationAnnotationNode!
    
    private let motionQueue = OperationQueue()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if debug {
            createDebugLabels()
        }
        
        let searchButton = UIButton(frame: CGRect(origin: CGPoint(x: view.frame.width - 100, y: 10), size: CGSize(width: 100, height: 100)))
        //searchButton.setTitle("Search image here", for: .normal)
        searchButton.setImage(UIImage(named: "search.png"), for: .normal)
        searchButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        sceneLocationView.addSubview(searchButton)
        
        sceneLocationView.run()
        view.addSubview(sceneLocationView)

        addBuildingTags()
        /*
        manager.deviceMotionUpdateInterval = 1
        manager.startDeviceMotionUpdates(to: motionQueue) { data, error in
            guard let data = data, error == nil else { return }
            // use data here
        }
        */
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "filterSegue" {
            (segue.destination as? FilterView)?.delegate = self
        }
    }
    
    @objc func buttonAction(sender: UIButton!) {
        performSegue(withIdentifier: "filterSegue", sender: sender)
    }
    
    var hasMotion: Bool {
        return manager.isAccelerometerAvailable && manager.isDeviceMotionActive
    }
    
    func trackLocation() {
        
        Locator.subscribePosition(accuracy: .room, onUpdate: { location in
            
        }, onFail: { error, _ in
            //log.error(error.localizedDescription)
        })
    }
    
    func degreesToRadians(degrees: Double) -> Double {
        return degrees * .pi / 180.0
        
    }
    
    func radiansToDegrees(radians: Double) -> Double {
        return radians * 180.0 / .pi
        
    }
    
    func getBearingBetweenTwoPoints(point1 : CLLocation, point2 : CLLocation) -> Double {
        
        let lat1 = degreesToRadians(degrees: point1.coordinate.latitude)
        let lon1 = degreesToRadians(degrees: point1.coordinate.longitude)
        
        let lat2 = degreesToRadians(degrees: point2.coordinate.latitude)
        let lon2 = degreesToRadians(degrees: point2.coordinate.longitude)
        
        let dLon = lon2 - lon1
        
        let y = sin(dLon) * cos(lat2)
        let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon)
        let radiansBearing = atan2(y, x)
        
        return radiansToDegrees(radians: radiansBearing)
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

extension ViewController : CLLocationManagerDelegate {

    //called on location update
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //round location to display
        let location = locations.first
        var lat = Double(location?.coordinate.latitude ?? 0)
        var long = Double(location?.coordinate.longitude ?? 0)
        lat = lat.roundTo(places: 9)
        long = long.roundTo(places: 9)
        
        positionLabel.text = "Lat: \(lat), Long: \(long)"
        
        let testlocation = testNode.location
        //let vectorToTest = testNode.eulerAngles
        let distanceInMeters = Double(location?.distance(from: testlocation!) ?? 0)
        
        distanceLabel.text = "Distance: \(distanceInMeters)m"
        
        // TODO: angle needs work
        //let v = CGPoint(x: testNode.x - cameraPosition.x, y: testNode.y - cameraPosition.y);
        //let a = atan2(v.y, v.x) // Note: order of arguments
        
        //angleLabel.text = "X: \(testNode.position.x), Y: \(testNode.position.y), Z: \(testNode.position.z) "
        
        let a = getBearingBetweenTwoPoints(point1: location!, point2: testNode.location)
        angleLabel.text = "Angle: \(a) deg"
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        
    }
}

extension ViewController : FilterViewDelegate {
    
    func complete(buildingName: String) {
        print(buildingName)
        
    }
    
}


extension Double {
    
    /// Rounds the double to decimal places value
    func roundTo(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
}
