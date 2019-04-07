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
import Async
import SwiftyTimer

class ViewController: UIViewController {

    // In meters
    let renderDistance = 200.0
    let tagHeight = 45.0
    let averageWalkSpeed = 1.4 //1.4 meters per second
    
    var sceneLocationView = SceneLocationView()
    private let manager = CMMotionManager()

    var buildings : [KMBuilding] = []
    
    //debug labels
    var positionLabel = UILabel()
    var distanceLabel = UILabel()
    var angleLabel = UILabel()
    var timeLeftLabel = UILabel()
    
    var searchButton = UIButton()

    var destinationNode: LocationAnnotationNode!
    
    var buildingNodes : [LocationAnnotationNode] = []
    
    private let motionQueue = OperationQueue()
    
    let arrowScene = SCNScene(named: "art.scnassets/ship.scn")!
    var arrowNode = SCNNode()
    
    var loc = CLLocation()
    private var arrowUpdateTimer: Timer?
    private var nodeUpdateTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        createLabels()
        
        searchButton = UIButton(frame: CGRect(origin: CGPoint(x: view.frame.width - 60, y: 40), size: CGSize(width: 50, height: 50)))
        searchButton.setImage(UIImage(named: "search.png"), for: .normal)
        searchButton.setImage(UIImage(named: "Xbutton.png"), for: .selected)
        searchButton.addTarget(self, action: #selector(searchTapped), for: .touchUpInside)
        
        sceneLocationView.addSubview(searchButton)
        sceneLocationView.run()
        
        view.addSubview(sceneLocationView)
        
        manager.deviceMotionUpdateInterval = 1/15
        manager.startDeviceMotionUpdates(using: .xTrueNorthZVertical, to: motionQueue) { data, error in
            guard let data = data, error == nil else { return }
            Async.main {
                self.angleLabel.text = "Heading: \(data.heading.roundTo(places: 5))"
                

            }
         
        }
        
        // TODO: we are reloading data from the DB every run
        KMDatabaseHelper.getData(completionHandler: {(array) in
            self.buildings.append(contentsOf: array)
            self.addBuildingTags()
        })
        
        trackLocation()
        
        sceneLocationView.scene = arrowScene
        arrowNode = self.arrowScene.rootNode.childNodes.first!

        arrowUpdateTimer = Timer.every(1/60) {

            if self.destinationNode != nil {
                
                self.arrowNode.isHidden = false

                let camera = self.sceneLocationView.pointOfView
                let position = SCNVector3(x: 0, y: -1.2, z: -2.5)

                let referenceNodeTransform = matrix_float4x4(camera!.transform)
                
                // Setup a translation matrix with the desired position
                var translationMatrix = matrix_identity_float4x4
                translationMatrix.columns.3.x = position.x
                translationMatrix.columns.3.y = position.y
                translationMatrix.columns.3.z = position.z
                
                // Combine the configured translation matrix with the referenceNode's transform to get the desired position AND orientation
                let updatedTransform = matrix_multiply(referenceNodeTransform, translationMatrix)

                self.arrowNode.transform = SCNMatrix4(updatedTransform)
                self.arrowNode.look(at: self.destinationNode.worldPosition)
                

            }
            else {
                self.arrowNode.isHidden = true
            }

        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "filterSegue" {
            let destinationVC = segue.destination as? FilterView
            destinationVC?.delegate = self
            destinationVC?.buildingArray = buildings
        }
        else {
            let destinationVC = segue.destination as? InfoView
           // destinationVC?.delegate = self
            destinationVC?.building = sender as? KMBuilding
        }
    }
    
    @objc func searchTapped(sender: UIButton!) {
        if sender.isSelected {
            
            sender.isSelected = false
            timeLeftLabel.isHidden = true
            distanceLabel.isHidden = true
            destinationNode = nil
        }
        else {
            performSegue(withIdentifier: "filterSegue", sender: sender)
        }
    }
    
    var hasMotion: Bool {
        return manager.isAccelerometerAvailable && manager.isDeviceMotionActive
    }
    
    func trackLocation() {
        
        Locator.subscribePosition(accuracy: .room, onUpdate: { location in
            
            self.loc = location
            
            if self.destinationNode != nil {
                self.distanceLabel.isHidden = false
                self.timeLeftLabel.isHidden = false
                
                let testlocation = self.destinationNode.location
                var distanceInMeters = Double(location.distance(from: testlocation!))
                distanceInMeters = distanceInMeters.roundTo(places: 1)
                
                self.distanceLabel.text = "Distance: \(distanceInMeters)m"
                
                let timeLeft = self.timeLeft(distance: distanceInMeters)
                //timeLeft = timeLeft.roundTo(places: 1)
                let timeStr = self.printSecondsToHoursMinutesSeconds(seconds: timeLeft)
                self.timeLeftLabel.text = "Time Left: \(timeStr)"
                
            }
            else {
                self.distanceLabel.isHidden = true
                self.timeLeftLabel.isHidden = true

            }
            
        }, onFail: { error, _ in
            //log.error(error.localizedDescription)
        })
    }
    
    func printSecondsToHoursMinutesSeconds(seconds:Double) -> (String) {
        
        let (_, m, s) = secondsToHoursMinutesSeconds (seconds: seconds)
        let mi = Int(m)
        let si = Int(s)
        return ("\(mi) m, \(si) s")
    }
    
    func secondsToHoursMinutesSeconds(seconds : Double) -> (Double, Double, Double) {
        
        let (hr, minf) = modf (seconds / 3600)
        let (min, secf) = modf (60 * minf)
        return (hr, min, 60 * secf)
    }
    
    func timeLeft(distance: Double) -> Double {
        var time: Double
        
        time = distance / averageWalkSpeed
        
        return time
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

    func addBuildingTags() {
        
        Async.main {
            //update nodes every 1 second

            for building in self.buildings {
                self.drawBuildingNode(building: building)
            }
            
            //this will hide nodes too far away
            self.nodeUpdateTimer = Timer.every(1) {
                for building in self.buildingNodes {
                    let distanceInMeters = Double(self.loc.distance(from: building.location))

                    // if distance is greater then render distance hide it and not the destination
                    if (distanceInMeters > self.renderDistance) && (building != self.destinationNode) {
                        building.isHidden = true
                    }
                    else {
                        building.isHidden = false
                    }
                }
            }
        }
    }
    
    func drawBuildingNode(building: KMBuilding) {
        let annotationNode = building.makeNode(tagHeight)
        
        self.sceneLocationView.addLocationNodeWithConfirmedLocation(locationNode: annotationNode)
        self.buildingNodes.append(annotationNode)
    }
    
    // this sets the AR View to the size of the phone's screen
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        sceneLocationView.frame = view.bounds
    }
    
    // TODO: Clean this up as we arent using the old view
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        sceneLocationView.run()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //Stop the scene when the view dissapears
        sceneLocationView.pause()

    }
    
    func createLabels() {
        
        let point = CGPoint(x: 10, y: view.frame.height - 125)
        let size = CGSize(width: 800, height: 100)
        let rekt = CGRect(origin: point, size: size)
        distanceLabel = UILabel(frame: rekt)
        distanceLabel.textColor = UIColor.white
        distanceLabel.font = UIFont(name: "Futura-CondensedExtraBold", size: 30)
        distanceLabel.text = "Distance: 0.0m"
        distanceLabel.isHidden = true
        sceneLocationView.addSubview(distanceLabel)

        let point4 = CGPoint(x: 10, y: view.frame.height - 100)
        let size4 = CGSize(width: 800, height: 100)
        let rekt4 = CGRect(origin: point4, size: size4)
        timeLeftLabel = UILabel(frame: rekt4)
        timeLeftLabel.textColor = UIColor.white
        timeLeftLabel.font = UIFont(name: "Futura-CondensedExtraBold", size: 30)
        timeLeftLabel.text = "Time Left: 0.0"
        timeLeftLabel.isHidden = true
        sceneLocationView.addSubview(timeLeftLabel)
    }
    
}


extension ViewController : FilterViewDelegate {
    
    func complete(buildingName: String) {
        for building in self.buildingNodes {
            if building.tag == buildingName {
                destinationNode = building
                searchButton.isSelected = true
                print(building.name ?? "Missing")
            }
        }
        searchButton.becomeFirstResponder()
    }
    
}


extension Double {
    
    /// Rounds the double to decimal places value
    func roundTo(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
}
