# System Architecture
  
  ** This is a work in progress not final document or sub titles **
  
### Description of overall architecture
Our App consists of a Firebase database, a database communication class using JSON, classes for handling the backend calculations for the Augmented Reality, and a GUI that has both normal UI and Augmented Reality. The overall system runs on any iOS device that supports AR.
  
### User Story connections
* Stories 000, 001, 003, 004, 008 are handled by both the Augmented Reality UI and the supporting backend classes that filter data and perform calculatations.
* Stories 005 and 006 are handled by the searchbar UI, which will provide a list of favorites and suggested auto-completions.
* Stories 002 and 007 are handled by The AR UI and the backend class that searches data, pulls the info data and displays onto the UI.
* Story 009 is handled by the LocationManger class which finds the users current location
* Stories 010 and 011 are handled by Xcode which allows the integration of pictures using their settings

### Data Storage and Handling

The data for the app is stored remotely in the database as JSON and accessed when the application launches.

### Augmented Reality and Core Location

This app relies on the open-source, MIT-Licensed CocoaPod named ARCL. It handles fixing Augmented Reality tags to specific GPS locations in the real world. ARKit is the built-in iOS library that will be drawing objects to the screen while Core Location is the built-in iOS library that allows us to easily find and track the device.

The GPS coordinates will be stored in a database that is linked in to the app, rather than storing all locations locally on the user's device. The database will hold the name of the location, the acronym for the location, the location's lattitude and longitude, and other information such as hours of operation and a small description. This information will be pulled by the app and used to populate the AR tags floating above each building.
