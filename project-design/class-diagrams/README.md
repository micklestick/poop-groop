##  Major Classes
#### FilterView
Handles buidling searchbar. Filters and displayed the building data based on user input.

Addresses requirement 014, which relates to user story 001.

#### FilterViewTableCell
Placeholder class for additional functionality.

#### KMDatabaseHelper
Handles the database containing application data. Data is stored as JSON in a Google Firebase database and accessed using a REST API. Sample data is also provided for testing purposes.

Addresses requirement 007.

#### KMBuilding
Object representing a building. Contains building data: name, acronym, latitude, longitude, info, and type.

Helps address requirement 007.

#### SearchBuildings
Given a name or acronym, retrieves the corresponding KMBuilding from a [KMBuilding]. Acronyms are assumed to be less than four characters, while names are assumed to be four or more characters.

Addresses requirement 001, which relates to user story 006.

#### LocationManager
Begins tracking user location after asking for permission if neccesary.

Addresses requirement 009.

#### AppDelegate
Handles application launch options and initial configuration. Configures connection with Firebase.

Helps address requirement 007.

#### ViewController
Handles UI views and miscelaneous app logic.
- Loads data and sets up UI after loading. Initializes UI components, loads building data, and begins location tracking.
- Contains utility functions to track location, calculate direction of coordinate vector, convert between radians and degrees, and add tags to buildings.

Addresses requirement 005, which relates to user story 005.


## KMBuilding

### Members
- name (string)
- acronym(string)
- latitude(string)
- longitude(string)
- info(string)
- type(string)

The items above store the necessary information to identify each building. The rest of the members are self explanitory, but the type field is used to store the type of the building (building, parking lot, store) so it can be used as an extra search feature.

It has a single function that is used to initalize the members. 

This class implements the Decodable protocol and is able to be instantiated to make a building object.

## KMDatabaseHelper

### Members
- one global value named jsonUrlString
  - this string contains the url string for the json request and is global so it can be easily accessed and changed

### Functions

- needUpdate
  - This function takes two parameters, localVersion, and dbVersion
    - localVersion denotes the version of the local storage for the database and the dbVersion is the version that is pulled on start up
  - This function compares the two and returns a boolean value if the dbVersion is greater than the current local version

- getData

- makeObjectArray
  - temporary function for creating an array of building objects to use for testing and development

- aTestPoints
  - temporary function for creating another specific array of building objects modeled off a specfic location for testing the floating tag points
