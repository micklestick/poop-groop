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
    
    // Update the database.
    static func doUpdate(_ branch: String = "main") {
        Database.database().reference().child(branch).child("buildings").observeSingleEvent(of: .value, with: { snapshot in
            for case let child as DataSnapshot in snapshot.children {
                child.ref.child(child.key).parent?.removeValue()
            }
            loadFromJson(branch)
        })
    }

    // get connection to database to recieve JSON and run through decode
    // function returns an array of type KMBuilding with the current databse info
    static func getData(completionHandler: @escaping (_ buildings: [KMBuilding]) -> (), branch: String = "main") {
        Database.database().reference().child(branch).child("buildings").observeSingleEvent(of: .value, with: { snapshot in
            var buildings: [KMBuilding] = []
            for case let child as DataSnapshot in snapshot.children {
                do {
                    let building = try FirebaseDecoder().decode(KMBuilding.self, from: child.value!)
                    buildings.append(building)
                } catch let error {
                    print(error)
                }
            }
            completionHandler(buildings)
        })
    }
    
    // Add a building to the database.
    static func addBuilding(_ building: KMBuilding, _ branch: String = "main") {
        let buildingRef = databaseRef.child(branch).child("buildings").childByAutoId()
        let buildingEnc = try! FirebaseEncoder().encode(building)
        buildingRef.setValue(buildingEnc)
    }
    
    // Add an array of buildings to the database.
    static func addBuildings(_ buildings: [KMBuilding], _ branch: String = "main") {
        for building in buildings {
            addBuilding(building)
        }
    }
    
    // Load buildings from JSON.
    static func loadFromJson(_ branch: String = "main") {
        guard let endpoint = URL(string: buildingsURL) else {
            fatalError("Error creating endpoint")
        }
        
        // create JSON url session for get request
        URLSession.shared.dataTask(with: endpoint) { (data, response, err) in
            guard let data = data else {
                fatalError("JSONError: failed to get data")
            }
            
            do {
                let buildings = try JSONDecoder().decode([KMBuilding].self, from: data)
                addBuildings(buildings, branch)
            } catch let jsonErr {
                print("error serializing json:", jsonErr)
            }
        }.resume()
    }
}
