//
//  FilterView.swift
//  KnightsMaps
//
//  Created by Michael Aoun on 3/10/19.
//  Copyright © 2019 Alec. All rights reserved.
//

import UIKit
import Disk
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
    var favoritesArray = [KMBuilding]()
    var userDefaults = UserDefaults.standard

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchBar.scopeButtonTitles = ["All", "Building", "Restaurant", "Store", "Garage", "Favorites"]
        searchController.searchBar.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    
    func itemSelected(bName: String) {
        print("Selected the cell is: \(bName)")
        delegate?.complete(buildingName: bName)
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    func saveFavorites() {
        try! Disk.save(favoritesArray, to: .documents, as: "kmfavorites.json")
        print("Attempting to save favorites....")
    }

    func loadFavorites() {
        let retreivedFavorites = try! Disk.retrieve("kmfavorites.json", from: .documents, as: [KMBuilding].self)
        favoritesArray = retreivedFavorites
        print("Attempting to load favorites.......")
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

extension FilterView: UITableViewDataSource, UITableViewDelegate, FilterViewCellDelegate {
    
    
    
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
            cell?.cellDelegate = self
            cell?.button.tag = indexPath.row
//            cell?.button.addTarget(self, action: Selector("buttonClicked:"), for: UIControl.Event.touchUpInside)

        } else {
            cell?.textLabel?.text = buildingArray[indexPath.row].name
            cell?.detailTextLabel?.text = buildingArray[indexPath.row].acronym
            cell?.cellDelegate = self
            cell?.button?.tag = indexPath.row
//            cell?.button?.addTarget(self, action: Selector("buttonClicked:"), for: UIControl.Event.touchUpInside)
        }

        
        return cell!
    }
    
    func didPressButton(_ tag: Int) {
        
        if searching {
            print("The button pressed is \(filteredBuildings[tag].name)")
            
            //Making sure we can't add duplicates
            if favoritesArray.contains(where: {$0.name == filteredBuildings[tag].name}) {
                print("Already there. Removing")
                favoritesArray.removeAll(where: {$0.name == filteredBuildings[tag].name})
                
                if(pickedScope == "Favorites") {
                    filteredBuildings = favoritesArray
                    tbView.reloadData()
                }
            }
            else {
                favoritesArray.append(filteredBuildings[tag])
            }
            
        } else {
            print("The button pressed is \(buildingArray[tag].name)")
            
            if favoritesArray.contains(where: {$0.name == buildingArray[tag].name}) {
                print("Already there. Removing.")
                favoritesArray.removeAll(where: {$0.name == buildingArray[tag].name})
                if(pickedScope == "Favorites") {
                    filteredBuildings = favoritesArray
                    tbView.reloadData()
                }
                
            }
            else {
                favoritesArray.append(buildingArray[tag])
            }
        }
        
        saveFavorites()
        
    }
    
    
}

extension FilterView: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searching = true
        masterSearchText = searchText
        
        if pickedScope == "Favorites" {
            filteredBuildings = favoritesArray.filter({($0.name.lowercased().prefix(masterSearchText.count) == masterSearchText.lowercased() || $0.acronym.lowercased().prefix(masterSearchText.count) == masterSearchText.lowercased())})

        } else {
            filteredBuildings = buildingArray.filter({($0.type == pickedScope || pickedScope == "") && ($0.name.lowercased().prefix(searchText.count) == searchText.lowercased() || $0.acronym.lowercased().prefix(searchText.count) == searchText.lowercased())})
        }
        
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
        case 5:
            pickedScope = "Favorites"
            searching = true
            break
        default:
            pickedScope = ""
        }
        
        if(selectedScope < 5) {
            filteredBuildings = buildingArray.filter({($0.type == pickedScope || pickedScope == "") && ($0.name.lowercased().prefix(masterSearchText.count) == masterSearchText.lowercased() || $0.acronym.lowercased().prefix(masterSearchText.count) == masterSearchText.lowercased())})
        }
        else {
            loadFavorites()
//            filteredBuildings = favoritesArray
            filteredBuildings = favoritesArray.filter({($0.name.lowercased().prefix(masterSearchText.count) == masterSearchText.lowercased() || $0.acronym.lowercased().prefix(masterSearchText.count) == masterSearchText.lowercased())})
            tbView.reloadData()
        }
        
        print(pickedScope)
        tbView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        self.view.endEditing(true)
        searchBar.text = ""
        tbView.reloadData()
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
}


