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

    let debug = true
    
    // In meters
    let renderDistance = 200.0
    let tagHeight = 45.0
    
    var sceneLocationView = SceneLocationView()
    var sceneLocationViewInfo = SceneLocationView()

    private let manager = CMMotionManager()

    var buildings : [KMBuilding] = []
    var testPoints = KMDatabaseHelper.aTestPoints()
    
    //debug labels
    var positionLabel = UILabel()
    var distanceLabel = UILabel()
    var angleLabel = UILabel()
    
    // temporary for data testing
    var buildingInfo = KMBuilding(name: "Engineering 2", acronym: "EGN2", latitude: 28.60198153, longitude: -81.19868504, info: "Engineering Building 2. Contatins: EPC, Academic advising services, Computer labs, and classrooms.", type: "Building" )

    var destinationNode: LocationAnnotationNode!
    
    var buildingNodes : [LocationAnnotationNode] = []
    
    private let motionQueue = OperationQueue()
    
    let scene = SCNScene(named: "art.scnassets/ship.scn")!
    var loc = CLLocation()
    private var arrowUpdateTimer: Timer?
    private var nodeUpdateTimer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if debug {
            createDebugLabels()
        }
        
        let searchButton = UIButton(frame: CGRect(origin: CGPoint(x: view.frame.width - 60, y: 40), size: CGSize(width: 50, height: 50)))
        searchButton.setImage(UIImage(named: "search.png"), for: .normal)
        searchButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        sceneLocationView.addSubview(searchButton)
        sceneLocationView.run()
        view.addSubview(sceneLocationView)
        
        let infoButton = UIButton(frame: CGRect(origin: CGPoint(x: view.frame.width - 60, y: 130), size: CGSize(width: 50, height: 50)))
        infoButton.setTitle("Info", for: .normal)
        infoButton.addTarget(self, action: #selector(buttonInfoAction), for: .touchUpInside)
        infoButton.setTitleColor(.white, for: .normal)

        view.addSubview(infoButton)
        
        manager.deviceMotionUpdateInterval = 1/15
        manager.startDeviceMotionUpdates(using: .xTrueNorthZVertical, to: motionQueue) { data, error in
            guard let data = data, error == nil else { return }
            Async.main {
                self.angleLabel.text = "Heading: \(data.heading.roundTo(places: 5))"
                

            }
         
        }
        
        // TODO: we are reloading data from the DB every run
        KMDatabaseHelper.getData {
            (array) in
            
            self.buildings.append(contentsOf: array)
            print(array.first?.name)
            // THIS IS TESTING DATA FOR ALEC
            self.buildings.append(contentsOf: self.testPoints)
            self.addBuildingTags()
        }
        
        trackLocation()
        
        sceneLocationView.scene = scene
        arrowUpdateTimer = Timer.every(1/100) {
            let arrowNode = self.scene.rootNode.childNodes.first

            if self.destinationNode != nil {
                
                arrowNode?.isHidden = false
                
                let camera = self.sceneLocationView.pointOfView
                let position = SCNVector3(x: 0, y: -1.5, z: -2.5)
                let referenceNodeTransform = matrix_float4x4(camera!.transform)
                
                // Setup a translation matrix with the desired position
                var translationMatrix = matrix_identity_float4x4
                translationMatrix.columns.3.x = position.x
                translationMatrix.columns.3.y = position.y
                translationMatrix.columns.3.z = position.z
                
                // Combine the configured translation matrix with the referenceNode's transform to get the desired position AND orientation
                let updatedTransform = matrix_multiply(referenceNodeTransform, translationMatrix)
                arrowNode!.transform = SCNMatrix4(updatedTransform)
                
                if self.destinationNode != nil {
                    arrowNode!.look(at: self.destinationNode.worldPosition)
                    
                }

            }
            else {
                arrowNode?.isHidden = true
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
            destinationVC?.building = sender as! KMBuilding
        }
    }
    
    @objc func buttonAction(sender: UIButton!) {
        performSegue(withIdentifier: "filterSegue", sender: sender)
    }
    
    @objc func buttonInfoAction(sender: UIButton!) {
        let tempBuilding = buildingInfo
        performSegue(withIdentifier: "infoSegue", sender: tempBuilding)
    }
    
    var hasMotion: Bool {
        return manager.isAccelerometerAvailable && manager.isDeviceMotionActive
    }
    
    func trackLocation() {
        
        Locator.subscribePosition(accuracy: .room, onUpdate: { location in
            
            self.loc = location
            var lat = Double(location.coordinate.latitude)
            var long = Double(location.coordinate.longitude)
            lat = lat.roundTo(places: 9)
            long = long.roundTo(places: 9)
            
            self.positionLabel.text = "Lat: \(lat), Long: \(long)"
            
            if self.destinationNode != nil {
                let testlocation = self.destinationNode.location
                //let vectorToTest = testNode.eulerAngles
                let distanceInMeters = Double(location.distance(from: testlocation!))
                
                self.distanceLabel.text = "Distance: \(distanceInMeters)m"
                
            }
            
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
        var nodeBuilding: KMBuilding
        for building in buildings {
            if building.name == node.name {
                nodeBuilding = building
                performSegue(withIdentifier: "infoSegue", sender: nodeBuilding)
            }
        }
    }
    
    // TODO: this function is using the testPoints array, when the database is hooked up
    // we will change the testPoint to buildings
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
        let coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(building.latitude), longitude: CLLocationDegrees(building.longitude))
        //changed the altitude to 5 for testing, 25-35 will be needed for buildings
        let location = CLLocation(coordinate: coordinate, altitude: tagHeight)
        
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
        annotationNode.tag = building.name
        annotationNode.scaleRelativeToDistance = true
        
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
    
    func createDebugLabels() {
        
        let point = CGPoint(x: 10, y: view.frame.height - 150)
        let size = CGSize(width: 800, height: 100)
        let rekt = CGRect(origin: point, size: size)
        positionLabel = UILabel(frame: rekt)
        positionLabel.textColor = UIColor.green
        positionLabel.text = "Lat: 12.12121, Long: 12.121212"
        sceneLocationView.addSubview(positionLabel)
        
        let point2 = CGPoint(x: 10, y: view.frame.height - 125)
        let size2 = CGSize(width: 800, height: 100)
        let rekt2 = CGRect(origin: point2, size: size2)
        distanceLabel = UILabel(frame: rekt2)
        distanceLabel.textColor = UIColor.green
        distanceLabel.text = "Distance: 0.0m"
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

extension ViewController : FilterViewDelegate {
    
    func complete(buildingName: String) {
        for building in self.buildingNodes {
            if building.tag == buildingName {
                destinationNode = building
            }
        }
    }
    
}


extension Double {
    
    /// Rounds the double to decimal places value
    func roundTo(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
}

// we may want images to float so keep this code around for now
//let image = UIImage(named: "pin")!
//let annotationNode = LocationAnnotationNode(location: location, image: image)
