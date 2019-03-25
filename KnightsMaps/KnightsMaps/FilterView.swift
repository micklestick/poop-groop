//
//  FilterView.swift
//  KnightsMaps
//
//  Created by Michael Aoun on 3/10/19.
//  Copyright © 2019 Alec. All rights reserved.
//

import UIKit
protocol FilterViewDelegate {
    func complete(buildingName: String)
}

class FilterView: UIViewController {

    @IBOutlet var searchBarView: UISearchBar!
    @IBOutlet var tbView: UITableView!
    
    var buildingArray: [KMBuilding]!
    
    private let searchController = UISearchController(searchResultsController: nil)


    var searching = false
    var filteredBuildings = [KMBuilding]()
    var pickedScope = ""
    var masterSearchText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchBar.scopeButtonTitles = ["All", "Building", "Restaurant", "Store", "Garage"]
        searchController.searchBar.delegate = self

        // Do any additional setup after loading the view.
    }
    
    func itemSelected(bName: String) {
        print("Selected the cell is: \(bName)")
        delegate?.complete(buildingName: bName)
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    //This is called when you tap on a specific row in the search
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searching {
            itemSelected(bName: filteredBuildings[indexPath.row].name)
        } else {
            itemSelected(bName: buildingArray[indexPath.row].name)

        }
    }
    
    var delegate: FilterViewDelegate?
    
}   //end of FilterView

extension FilterView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            print(filteredBuildings.count)
           return filteredBuildings.count
        } else {
            print(buildingArray.count)
            return buildingArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? FilterViewTableCell
        if searching {
            cell?.textLabel?.text = filteredBuildings[indexPath.row].name
            cell?.detailTextLabel?.text = filteredBuildings[indexPath.row].acronym
        } else {
            cell?.textLabel?.text = buildingArray[indexPath.row].name
            cell?.detailTextLabel?.text = buildingArray[indexPath.row].acronym
        }
        return cell!
    }
    
}

extension FilterView: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searching = true
        masterSearchText = searchText
        filteredBuildings = buildingArray.filter({($0.type == pickedScope || pickedScope == "") && ($0.name.lowercased().prefix(searchText.count) == searchText.lowercased() || $0.acronym.lowercased().prefix(searchText.count) == searchText.lowercased())})

        
        tbView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
        switch selectedScope {
        case 0:
            pickedScope = ""
            searching = true
            break
        case 1:
            pickedScope = "Building"
            searching = true
            break
        case 2:
            pickedScope = "Store"
            searching = true
            break
        case 3:
            pickedScope = "Restaurant"
            searching = true
            break
        case 4:
            pickedScope = "Garage"
            searching = true
            break
        default:
            pickedScope = ""
        }
        filteredBuildings = buildingArray.filter({($0.type == pickedScope || pickedScope == "") && ($0.name.lowercased().prefix(masterSearchText.count) == masterSearchText.lowercased() || $0.acronym.lowercased().prefix(masterSearchText.count) == masterSearchText.lowercased())})
        print(pickedScope)
        tbView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tbView.reloadData()
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
//    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
//        filteredBuildings = buildingArray.filter({( building : KMBuilding) -> Bool in
//            let doesCategoryMatch = (scope == "All") || (building.type == scope)
//
//            if searching {
//                return doesCategoryMatch && building.name.lowercased().contains(searchText.lowercased())
//            } else {
//                return doesCategoryMatch
//            }
//        })
//        tbView.reloadData()
//    }
    

    
}


