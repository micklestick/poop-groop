//
//  KMDatabaseHelper.swift
//  KnightsMaps
//
//  Created by Sean Hall on 2/15/19.
//  Copyright © 2019 Alec. All rights reserved.
//

import Foundation
import Firebase
import CodableFirebase

// Class for connecting to and reading database
class KMDatabaseHelper {
    
    static let databaseRef: DatabaseReference = Database.database().reference()
    static let buildingsURL = "https://raw.githubusercontent.com/micklestick/poop-groop/master/project-information/knightsmaps_buildings.json"
    // TODO: Use this to auto-update db.
    static let versionURL = "https://raw.githubusercontent.com/micklestick/poop-groop/master/project-information/knightsmaps_db_versions.json"

    static func needUpdate(localVersion: Float, dbVersion: Float) -> Bool {
        // check database for version number
        if localVersion >= dbVersion {
            return false
        }
        else {
            return true
        }
    }
    
    static func doUpdate() {
        Database.database().reference().child("buildings").observeSingleEvent(of: .value, with: { snapshot in
            for case let child as DataSnapshot in snapshot.children {
                child.ref.child(child.key).parent?.removeValue()
            }
            loadFromJson()
        })
    }

    // get connection to database to recieve JSON and run through decode
    // function returns an array of type KMBuilding with the current databse info
    static func getData(completionHandler: @escaping (_ buildings: [KMBuilding]) -> ()) {
        Database.database().reference().child("buildings").observeSingleEvent(of: .value, with: { snapshot in
            var buildings: [KMBuilding] = []
            for case let child as DataSnapshot in snapshot.children {
                do {
                    let building = try FirebaseDecoder().decode(KMBuilding.self, from: child.value!)
                   // print(child.value!)
                    buildings.append(building)
                } catch let error {
                    print(error)
                }
            }
            completionHandler(buildings)
        })
    }
    
    static func addBuilding(_ building: KMBuilding) {
        let buildingRef = databaseRef.child("buildings").childByAutoId()
        let buildingEnc = try! FirebaseEncoder().encode(building)
        buildingRef.setValue(buildingEnc)
    }
    
    static func addBuildings(_ buildings: [KMBuilding]) {
        for building in buildings {
            addBuilding(building)
        }
    }
    
    static func loadFromJson() {
        guard let endpoint = URL(string: buildingsURL) else {
            fatalError("Error creating endpoint")
        }
        
        // create JSON url session for get request
        URLSession.shared.dataTask(with: endpoint) { (data, response, err) in
            // create instance of data pulled from get request
            guard let data = data else {
                fatalError("JSONError: failed to get data")
            }
            
            // decode the json into an array named building
            do {
                let building = try JSONDecoder().decode([KMBuilding].self, from: data)
                
                // call the completion handler to escape the URL session
                addBuildings(building)
            } catch let jsonErr {
                print("error serializing json:", jsonErr)
            }
        }.resume()
    }
    
    static func aTestPoints() -> [KMBuilding] {
        
        let testPoint1 = KMBuilding(name: "Building 1", acronym: "b1", latitude: 28.588002671651058, longitude: -81.21443616420288, info: "Far building", type:"building")
        let testPoint2 = KMBuilding(name: "Building Across", acronym: "bbb", latitude: 28.587356572418223, longitude: -81.21317020973589, info: "Building across", type:"building")
        let testPoint3 = KMBuilding(name: "The Pool", acronym: "pul", latitude: 28.587804581020393, longitude: -81.21319605320281, info: "Da pool", type:"building")
        let testPoint4 = KMBuilding(name: "Building 2", acronym: "b2", latitude: 28.588017643782457, longitude: -81.2140559129889, info: "Da pool", type:"building")
        let testPoint5 = KMBuilding(name: "Building 3", acronym: "b3", latitude: 28.588235808274305, longitude: -81.2134356521542, info: "Da pool", type:"building")
        let testPoint6 = KMBuilding(name: "Building 4", acronym: "b4", latitude: 28.58765816795291, longitude: -81.21258998104895, info: "Da pool", type:"building")
        let testPoint7 = KMBuilding(name: "Basketball Court", acronym: "bc", latitude: 28.587876333190636, longitude: 81.21225001105631, info: "Da pool", type:"building")


        return [testPoint1, testPoint2, testPoint3, testPoint4, testPoint5, testPoint6, testPoint7]
    }
}
