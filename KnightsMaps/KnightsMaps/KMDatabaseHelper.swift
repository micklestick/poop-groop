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
        URLSession.shared.dataTask(with: endpoint) { (data, response, err) in
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

        }.resume()

    }

    func decodeJSON() {
        // decode JSON from database

        // store information decoded in a KMBuilding object
        // store KMBuilding object in a KMBuilding array and return array


    }

}
