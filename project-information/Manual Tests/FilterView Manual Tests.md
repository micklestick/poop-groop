### This file details the manual test procedures necessary for fully testing FilterView.swift.

### filterView: didPressButton
| Step | Action | Observation |
|-|-|-|
| 1 | Tap on the magnifying glass icon in the top right corner. | A list of buildings and a search bar slide up from the bottom.|
| 2 | Tap on the heart icon next to the first cell. | The heart icon is now filled in.|
| 3 | Tap on the "Favorites" tab in the scoping bar. | The only cell on screen is the cell that was favorited.|

### filterView: saveFavorites/loadFavorites
| Step | Action | Observation |
|-|-|-|
| 1 | Tap on the magnifying glass icon in the top right corner. | A list of buildings and a search bar slide up from the bottom.|
| 2 | Tap on the heart icon next to the first cell. | The heart icon is now filled in.|
| 3 | Tap on the "Favorites" tab in the scoping bar. | The only cell on screen is the cell that was favorited.|
| 4 | Close the app completely | The device is back at the home screen.|
| 5 | Tap on the "Knights Map" app icon.| The "Knights Map" application launches.|
| 6 | Tap on the magnifying glass icon in the top right corner. | A list of buildings and a search bar slide up from the bottom.|
| 7 | Tap on the "Favorites" tab in the scoping bar. | The only cell on screen is the cell that was originally favorited before closing out of the app.|

### filterView: didPressInfoButton
| Step | Action | Observation |
|-|-|-|
| 1 | Tap on the magnifying glass icon in the top right corner. | A list of buildings and a search bar slide up from the bottom.|
| 2 | Tap on the information button next to the first cell. | The app transitions to an information page specific to the building within the tapped cell.|

### tableView: didSelectRowAt
| Step | Action | Observation |
|-|-|-|
| 1 | Tap on the magnifying glass icon in the top right corner. | A list of buildings and a search bar slide up from the bottom.|
| 2 | Tap on the search bar. | The search bar is now selected with a cursor blinking and the keyboard pulled up.|
| 3 | Type "Engineering I" in to the search bar. | The table will filter out results as you type. "Engineering I" is listed as an entry.|
| 4 | Tap on the "Engineering I" row. | The search view disappears and now the application is back at the main Augmented Reality View.|
| 5 | Verify the console outputs "Engineering I"| The console in XCode prints out "Engineering I"|


### tableView: numberOfRowsInSection
| Step | Action | Observation |
|-|-|-|
| 1 | Tap on the magnifying glass icon in the top right corner. | A list of buildings and a search bar slide up from the bottom.|
| 2 | Verify that there are 130 buildings. | The console in XCode prints out the number "130" |
| 3 | Tap on the search bar. | The search bar is now selected with a cursor blinking and the keyboard pulled up.|
| 4 | Type "Engine" in to the search bar. | The table filters out as results as you type. Three entries remain in the list.|
| 5 | Verify that there are 3 buildings. | The console in XCode prints out the number "3" |


### tableView: cellForRowAt
| Step | Action | Observation |
|-|-|-|
| 1 | Tap on the magnifying glass icon in the top right corner. | A list of buildings and a search bar slide up from the bottom.|
| 2 | Scroll through the entire list. | Every entry in the list has a name in big letters and an acronym in small letters.|
| 3 | Tap on the search bar. | The search bar is now selected with a cursor blinking and the keyboard pulled up.|
| 4 | Type "Business Administration" in to the serach bar. | The table will filter out results a you type. |
| 5 | Verify the search result rows have names and acronyms. | Every row still available contains a name in big letters and an acronym in smaller letters. |

### searchBar: textDidChange
| Step | Action | Observation |
|-|-|-|
| 1 | Tap on the magnifying glass icon in the top right corner. | A list of buildings and a search bar slide up from the bottom.|
| 2 | Tap on the search bar. | The search bar is now selected with a cursor blinking and the keyboard pulled up.|
| 3 | Type "Engineering I" in to the search bar. | "Engineering I" is now in the search bar. |
| 4 | Verify that the view reloads upon text changing. | The results continuously filter out as more letters are typed in without the need to hit a search/return button. |

### searchBar: searchBarCancelButtonClicked
| Step | Action | Observation |
|-|-|-|
| 1 | Tap on the magnifying glass icon in the top right corner. | A list of buildings and a search bar slide up from the bottom.|
| 2 | Tap on the search bar. | The search bar is now selected with a cursor blinking and the keyboard pulled up.|
| 3 | Tap on the "Cancel" button to the right of the search bar. | The search view disappears and now the application is back at the main Augmented Reality View.|



