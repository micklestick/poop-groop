//
//  SearchBuilding.swift
//  KnightsMaps
//
//  Created by Sean Hall on 3/8/19.
//  Copyright © 2019 Alec. All rights reserved.
//



// Really basic search using either building name or acronym as an input string
// Example of how to use and error trap the search
//
//    let input = "Classroom building 2"
//    let array = KMDatabaseHelper.makeObjectArray()
//
//    if let building = SearchBuilding.searchArray(input: input, buildingArray: array) {
//        print(building.name)
//    }
//    else {
//        print("error with your typing")
//    }

import Foundation

class SearchBuilding {
    
    static func searchArray(input: String, buildingArray: [KMBuilding]) -> KMBuilding? {
        
        let inputString = input.lowercased()
        let size = inputString.count
        
        // if string is an acronym ie < 4 characters, it searches by acronym
        if(size < 4) {
            for building in buildingArray {
                if(building.acronym == inputString) {
                    return building
                }
            }
        }
        // else it searches by the building name
        else {
            for building in buildingArray {
                if(building.name == inputString) {
                    return building
                }
            }
        }

        return nil
    }
    
}
