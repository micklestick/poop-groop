#  Class Diagram


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
