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

    @IBOutlet var latitudeLabel: UILabel!
    @IBOutlet var longitudeLabel: UILabel!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var findLocationButton: UIButton!
    
    let locationManager = CLLocationManager()
    var location: CLLocation?
    var isUpdatingLocation = false
    var lastLocationError: Error?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
        // Set the view's delegate
        sceneView.delegate = self

        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true

        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/ship.scn")!

        // Set the scene to the view
        sceneView.scene = scene
    }
    
    func updateUI()
    {
        if let location = location
        {
            //TODO: populate location labels with coordinate info
            latitudeLabel.text = String(format: "%.8f", location.coordinate.latitude)
            longitudeLabel.text = String(format: "%.8f", location.coordinate.longitude)
            statusLabel.text = "New Location Detected!"
        }
        else
        {
            statusLabel.text = "Tap 'Find Location' to Start"
            latitudeLabel.text = "-"
            longitudeLabel.text = "-"
            
        }
    }
    
    //MARK: - Target/Action
    @IBAction func findLocation()
    {
        //Request permission
        let authorizationStatus = CLLocationManager.authorizationStatus()
        
        if authorizationStatus == .notDetermined
        {
            locationManager.requestWhenInUseAuthorization()
            return
        }
        //Report if permission is denied
        if authorizationStatus == .denied || authorizationStatus == .restricted
        {
            reportLocationServicesDeniedError()
            return
        }
        // start / stop finding location
        if isUpdatingLocation
        {
            stopLocationManager()
        }
        else
        {
            location = nil
            lastLocationError = nil
            startLocationManager()
        }
        
        updateUI()
    }
    
    func startLocationManager()
    {
        if CLLocationManager.locationServicesEnabled()
        {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            locationManager.startUpdatingLocation()
            isUpdatingLocation = true
        }
    }
    
    func stopLocationManager()
    {
        if isUpdatingLocation
        {
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            isUpdatingLocation = false
        }
        
    }
    
    
    
    func reportLocationServicesDeniedError()
    {
        let alert = UIAlertController(title: "Location services disabled!", message: "Please go to settings and enable location services.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
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

extension ViewController : CLLocationManagerDelegate
{
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("ERROR! locationManager-didFailWithError: \(error)" )
        
        if (error as NSError).code == CLError.locationUnknown.rawValue
        {
            lastLocationError = error
            stopLocationManager()
            updateUI()
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        location = locations.last!
        print("Got the location! locationManager-didUpdateLocations: \(location)")
        stopLocationManager()
        updateUI()
    }
}
