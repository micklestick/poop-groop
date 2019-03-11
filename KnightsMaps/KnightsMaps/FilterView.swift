//
//  FilterView.swift
//  KnightsMaps
//
//  Created by Michael Aoun on 3/10/19.
//  Copyright © 2019 Alec. All rights reserved.
//

import UIKit

class FilterView: UIViewController {

    @IBOutlet var searchBarView: UISearchBar!
    @IBOutlet var tbView: UITableView!
    
    let buildingArr2 = [KMBuilding(name: "Engineering 1", acronym: "ENG1", latitude: 100, longitude: 100, info: "blah", type:"building"),
                        KMBuilding(name: "Engineering 2", acronym: "ENG2", latitude: 100, longitude: 100, info: "blah", type:"building"),
                        KMBuilding(name: "Business Administration 1", acronym: "BA1", latitude: 100, longitude: 100, info: "blah", type:"building"),
                        KMBuilding(name: "Classroom Building 1", acronym: "CB1", latitude: 100, longitude: 100, info: "blah", type:"building"),
                        KMBuilding(name: "Classroom Building 2", acronym: "CB2", latitude: 100, longitude: 100, info: "blah", type:"building"),
                        KMBuilding(name: "Harrison Engineering Center", acronym: "HEC", latitude: 100, longitude: 100, info: "blah", type:"building"),
                        KMBuilding(name: "Visual Arts Building", acronym: "VAB", latitude: 100, longitude: 100, info: "blah", type:"building")]
    
    var searching = false
    var filteredBuildings = [KMBuilding]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //This is called when you tap on a specific row in the search
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searching {
            print("Selected the cell is: \(filteredBuildings[indexPath.row].name)")
        } else {
            print("Selected the cell is: \(buildingArr2[indexPath.row].name)")
        }
    }
    
}   //end of FilterView

extension FilterView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
           return filteredBuildings.count
        } else {
            return buildingArr2.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? FilterViewTableCell
        if searching {
            cell?.textLabel?.text = filteredBuildings[indexPath.row].name
            cell?.detailTextLabel?.text = filteredBuildings[indexPath.row].acronym
        } else {
            cell?.textLabel?.text = buildingArr2[indexPath.row].name
            cell?.detailTextLabel?.text = buildingArr2[indexPath.row].acronym
        }
        return cell!
    }
    
}

extension FilterView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searching = true
        filteredBuildings = buildingArr2.filter({$0.name.prefix(searchText.count) == searchText || $0.acronym.prefix(searchText.count) == searchText})
        
        tbView.reloadData()
        
    }
}
