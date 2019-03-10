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

class ViewController: UIViewController {

    @IBOutlet var sceneView: ARSCNView!

    var sceneLocationView = SceneLocationView()

    // labels for the gps locations
    @IBOutlet var latitudeLabel: UILabel!
    @IBOutlet var longitudeLabel: UILabel!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var findLocationButton: UIButton!
    
    var locationManager = LocationManager()
    var buildings = KMDatabaseHelper.makeObjectArray()
    var testPoints = KMDatabaseHelper.aTestPoints()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //comment these lines for the debug view
        sceneLocationView.run()
        view.addSubview(sceneLocationView)
        
        
        addBuildingTags()
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
        locationManager.findLocation(view: self)

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

}
