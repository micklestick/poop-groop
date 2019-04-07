### This file details the manual test procedures necessary for fully testing InfoView.swift

### InfoView: viewDidLoad()   "Checks if the InfoView loads and looks correct"

| Step | Action | Observation |
|-|-|-|
| 1 | Tap on the magnifying glass icon in the top right corner. | A list of buildings and a search bar should appear |
| 2 | Tap on the search bar and search "Classroom Building 1" | The table will filter out results as you type. "Classroom Building 1 is listed as an entry" |
| 3 | Tap on the Info button that looks like an I in a circle | The app should transition to another page |
| 4 | Verify The page that is loaded Has a top search bar with a back button in the top left corner and a "Navigate" button in the top right | The page should have a navigation bar as described |
| 5 | Verify there is a Title in the Center that says "Classroom Building 1" | There should be a large label that displays the name of the building |
| 6 | Verify there is a Map in the middle of the page with a pin placed | There should be a map with a pin placed on Classroom building 1. |
| 7 | Verify there is a label below the map that displays information on Classroom building 1 | There should be a paragraph below the map displaying information. Do not verify if this is correct information. That is another test. |

### InfoView Correct information "Checks if the information is correct"

| Step | Action | Observation |
|-|-|-|
| 1 | Complete test "InfoView: viewDidLoad()" first | The layout should be tested first to verify it loads correctly |
| 2 | Tap on the magnifying glass icon in the top right corner. | A list of buildings and a search bar should appear |
| 3 | Tap on the search bar and search "Classroom Building 1" | The table will filter out results as you type. "Classroom Building 1 is listed as an entry" |
| 4 | Tap on the Info button that looks like an I in a circle | The app should transition to another page |
| 5 | Verify that the label above the map displays the text "Classroom Building 1" | The name of the building should appear as the first label |
| 6 | Verify that the map pin points the the correct location by running test "InfoView: setPin" | The correctness of the pin location is another test. Just verify that it appears on a zoomed in map for now |
| 7 | Verify that the Information displayed below the map says "Faculty Center For Teaching and Learning Room 207 Contact: 407-823-3544\nOffice of Instructional Resources Room 203 Contact: 407-823-2571\nTech Commons Computer Lab Hours: Mon-Fri 8am-5pm" | The text should display that exact information. Every where there is a "\n" The text should be on a new line. |


### InfoView: setPin "Tests if the pin places on the correct location on the map"

| Step | Action | Observation |
|-|-|-|
| 1 | Complete test "InfoView: viewDidLoad()" first | The layout should be tested first to verify it loads correctly |
| 2 | Complete test "Info View Correct Information" | The app should be tested first to verify the correct information is being passed |
| 3 | Tap on the magnifying glass icon in the top right corner. | A list of buildings and a search bar should appear |
| 4 | Tap on the search bar and search "Classroom Building 1" | The table will filter out results as you type. "Classroom Building 1 is listed as an entry" |
| 5 | Tap on the Info button that looks like an I in a circle | The app should transition to another page |
| 6 | Pull up apple maps and the knightsmaps_buildings.json file | This will be used for testing the correct location |
| 7 | Find the latitude and longitude of Classroom Building 1 from the knightsmaps_buildings.json file. | The latitude and longitude should match "latitude: 28.60349053 and longitude: -81.20042043" |
| 8 | Search that location on apple maps | Apple maps should put a pin on Classroom Building 1 |
| 9 | Compare the pin from the InfoView to the pin from Apple Maps | The pin should be in the same location |
| 10 | Verify that the zoom on the map is not too far out and detail can be seen of the map. | This part is subjective, use best judgment. |