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

   static var jsonUrlString = "https://jsonplaceholder.typicode.com/posts"

    // test struct for implementing json decode
    struct Post: Decodable {
        let userId: Int
        let id: Int
        let title: String
        let body: String
    }

   static func needUpdate(localVersion: Double, dbVersion: Double) -> Bool {
        // check database for version number
        if(localVersion >= dbVersion) {
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
                let posts = try JSONDecoder().decode([Post].self, from: data)
                print(posts)
            } catch let jsonErr {
                print("error serializing json:",jsonErr)
            }
        }.resume()
        
        return buildingArray
    }

    // function for generating an example test array of type KMBuilding
    // will be removed when database is fully functioning

    static func makeObjectArray() -> [KMBuilding] {

        let egnbuilding = KMBuilding(name: "Engineering 2", acronym: "EGN2", latitude: -01.234, longitude: 34.519, info: "The maing building for engineering stuff")

        let cb2building = KMBuilding(name: "Classroom Building 2", acronym: "CB2", latitude: 87.345, longitude: 20.304, info: "The slightly better building for random classes")

        let cb1building = KMBuilding(name: "Classroom Building 1", acronym: "CB1", latitude: 88.385, longitude: 22.324, info: "The slightly worse building for random classes")

        return [egnbuilding, cb2building, cb1building]
    }

}
