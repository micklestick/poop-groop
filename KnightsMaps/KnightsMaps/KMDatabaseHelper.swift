//
//  KMDatabaseHelper.swift
//  KnightsMaps
//
//  Created by Sean Hall on 2/15/19.
//  Copyright © 2019 Alec. All rights reserved.
//

import Foundation

// Class for connecting to and reading database
class KMDatabaseHelper {

   static var jsonUrlString = "https://api.myjson.com/bins/iwhci"

    // test struct for implementing json decode
    struct Building: Decodable {
        let name: String
        let acronym: String
        let location: Location
        let info: String
        let type: String
    }
    
    struct Location: Decodable {
        let latitude: Float
        let longitude: Float
    }

   static func needUpdate(localVersion: Double, dbVersion: Double) -> Bool {
        // check database for version number
        if localVersion >= dbVersion {
            return false
        }
        else {
            return true
        }
    }

    // get connection to database to recieve JSON and run through decode
    // function returns an array of type KMBuilding with the current databse info
    static func getData() -> [KMBuilding] {

        var buildingArray = [KMBuilding]()
        
        // create Url object
        guard let endpoint = URL(string: jsonUrlString) else {
            fatalError("Error creating endpoint")
        }

        // create JSON url session for get request
       URLSession.shared.dataTask(with: endpoint) { (data, response, err) in
            // error check here
        
            // create instance of data pulled from get request
            guard let data = data else {
                fatalError("JSONError: failed to get data")
            }

            do {
                var building = try JSONDecoder().decode([Building].self, from: data)
                buildingArray = createBuilding(input: building)
            } catch let jsonErr {
                print("error serializing json:", jsonErr)
            }
        }.resume()
        
        return buildingArray
    }

    // functions for generating an example test array of type KMBuilding
    // will be removed when database is fully functioning

    static func makeObjectArray() -> [KMBuilding] {

        let egnbuilding = KMBuilding(name: "engineering 2", acronym: "egn2", latitude: -01.234, longitude: 34.519, info: "The maing building for engineering stuff", type:"building")

        let cb2building = KMBuilding(name: "classroom building 2", acronym: "cb2", latitude: 87.345, longitude: 20.304, info: "The slightly better building for random classes", type:"building")

        let cb1building = KMBuilding(name: "classroom building 1", acronym: "cb1", latitude: 88.385, longitude: 22.324, info: "The slightly worse building for random classes", type:"building")

        return [egnbuilding, cb2building, cb1building]
    }
    
    static func aTestPoints() -> [KMBuilding] {
        
        let testPoint1 = KMBuilding(name: "Far Building", acronym: "fb1", latitude: 28.58799939252419, longitude: -81.21444843213033, info: "Far building", type:"building")
        
        let testPoint2 = KMBuilding(name: "Building Across", acronym: "bbb", latitude: 28.587356572418223, longitude: -81.21317020973589, info: "Building across", type:"building")
        
        let testPoint3 = KMBuilding(name: "The Pool", acronym: "pul", latitude: 28.587804581020393, longitude: -81.21319605320281, info: "Da pool", type:"building")
        
        return [testPoint1, testPoint2, testPoint3]
    }

    // Turns a building struct array into an array of building objects this should be
    // temporary until I can solve an issue using decoable with custom object
    static func createBuilding(input: [Building]) -> [KMBuilding] {
        
        var buildingObj: KMBuilding
        var buildingArray = [KMBuilding]()
        
        for building in input {
            buildingObj = KMBuilding(name: building.name, acronym: building.acronym, latitude: building.location.latitude, longitude: building.location.longitude, info: building.info, type: building.type)
            buildingArray.append(buildingObj)
        }
        
        return buildingArray
    }

}
