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

    func needUpdate() {
        // check database for version number
        // if version number is newer, call get() method
    }

    // get connection to database to recieve JSON
    func getConnection() {

        // url request with placeholder url
        let jsonUrlString = "https://jsonplaceholder.typicode.com/users"

        // create Url object
        guard let endpoint = URL(string: jsonUrlString) else {
            print("Error creating endpoint")
            return
        }

        // create JSON url session for get request
       /* URLSession.shared.dataTask(with: endpoint) { (data, response, err) in
            // error check here

            // create instance of data pulled from get request
            guard let data = data else {
                print("JSONError: failed to get data")
                return
            }

            do {
                // decode the JSON here
            } catch {
                // error trap here
            }

        }.resume()*/

    }

    func decodeJSON() {
        // decode JSON from database

        // store information decoded in a KMBuilding object
        // store KMBuilding object in a KMBuilding array and return array


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
