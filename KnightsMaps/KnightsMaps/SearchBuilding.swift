//
//  SearchBuilding.swift
//  KnightsMaps
//
//  Created by Sean Hall on 3/8/19.
//  Copyright © 2019 Alec. All rights reserved.
//

import Foundation

class SearchBuilding {
    
    static func searchArray(input: String, buildingArray: [KMBuilding]) -> KMBuilding? {
        
        let inputString = input.lowercased()
        let size = inputString.count
        
        // This may fail if the acronym is too long or the name too short. Maybe take an optional control flag instead? - Isaac
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
