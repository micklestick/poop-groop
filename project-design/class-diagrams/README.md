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

