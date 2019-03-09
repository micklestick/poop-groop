# System Architecture
  
  ** This is a work in progress not final document or sub titles **
  
### Description of overall architecture
Our App consists of a MongoDB database, a database communication class using JSON, classes for handling the backend 
calculations for the Augmented Reality, and a GUI that has both normal UI and Augmented Reality. The overall system runs on 
any IOS device that supports AR.
  
### User Story connections
* Story ID 000, 003, 008 is handled by both the Augmented Reality UI and the supporting backend classes that search data and calculate  
  pathing
* Story ID 002, 007 is handled by The AR UI and the backend class that searches data, it pulls the info data and displays onto the UI
* Story ID 009 is handled by the LocationManger class which finds the users current location
* Story ID 010 and 011 are handled by Xcode which allows the integration of pictures using their settings

### Data Storage and Handling

The data for the app is handled in two places, It is stored both locally in a persistant Building Object array, and externally 
in a hosted database. The purpose of having it stored in two locations is it allows for a faster start up time and less usage 
of mobile data if we keep a version locally. 

On start up the app performs a version check on the database, if it is behind it will asynconously pull the new version by using JSON and 
store into the persistant storage after parsing the JSON.

### Augmented Reality and Core Location

This app relies on the open-source, MIT-Licensed CocoaPod named ARCL. It handles fixing Augmented Reality tags to specific GPS locations in the real world. ARKit is the built-in iOS library that will be drawing objects to the screen while Core Location is the built-in iOS library that allows us to easily find and track the device.

The GPS coordinates will be stored in a database that is linked in to the app, rather than storing all locations locally on the user's device. The database will hold the name of the location, the acronym for the location, the location's lattitude and longitude, and other information such as hours of operation and a small description. This information will be pulled by the app and used to populate the AR tags floating above each building.
