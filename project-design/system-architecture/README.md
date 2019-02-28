# System Architecture
  
  ** This is a work in progress not final document or sub titles **
  
### Description of overall architecture
Our App consists of a MongoDB database, a database communication class using JSON, classes for handling the backend 
calculations for the Augmented Reality, and a GUI that has both normal UI and Augmented Reality. The overall system runs on 
any IOS device that supports AR.
  
### User Story connections


### Data Storage and Handling

The data for the app is handled in two places, It is stored both locally in a persistant Building Object array, and externally 
in a hosted database. The purpose of having it stored in two locations is it allows for a faster start up time and less usage 
of mobile data if we keep a version locally. 

On start up the app performs a version check on the database, if it is behind it will asynconously pull the new version and 
store into the persistant storage.
