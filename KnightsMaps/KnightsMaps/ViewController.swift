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

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!

    // labels for the gps locations
    @IBOutlet var latitudeLabel: UILabel!
    @IBOutlet var longitudeLabel: UILabel!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var findLocationButton: UIButton!
    
    var locationManager = LocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self

        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true

        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/ship.scn")!

        // Set the scene to the view
        sceneView.scene = scene
        
        // Location test lables
        statusLabel.text = "Tap 'Find Location' to Start"
        latitudeLabel.text = "-"
        longitudeLabel.text = "-"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    func updateUI(loc: CLLocation) {
 
        latitudeLabel.text = String(format: "%.8f", loc.coordinate.latitude)
        longitudeLabel.text = String(format: "%.8f", loc.coordinate.longitude)
        statusLabel.text = "New Location Detected!"
    }
    
    //MARK: - Target/Action
    @IBAction func findLocation() {
        locationManager.findLocation(view: self)

    }
    

    
    
    


    // MARK: - ARSCNViewDelegate

/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()

        return node
    }
*/

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
