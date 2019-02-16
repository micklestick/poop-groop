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

    func getConnection() {
        // get connection to database to recieve JSON
        // url request with placeholder url
        let jsonUrlString = "https://jsonplaceholder.typicode.com/users"
        guard let url = URL(string: jsonUrlString) else { return }

        // create JSON url session for get request
        let session = URLSession.shared.dataTask(with: url) { (data, response, err) in
            // error check here
        }.resume()


    }

    func decodeJSON() {
        // decode JSON from database

        // store information decoded in a KMBuilding object
        // store KMBuilding object in a KMBuilding array and return array
    }

}
