# Sequence Diagram

** Please Review and edit if you want, prototype description of sequence diagram**

When the user opens the app, the app runs the viewcontroller.swift viewDidLoad() function which will run the database version check to 
test if the local data matches the hosted data. If the local database needs an update the app will run the function getData() to pull data 
in the form of JSON from the database and store into a local array of Building Objects after using the parseJSON function.

After the data check, the app will load the GUI where a user can type in a location on campus to travel to or they can click a location to 
see information about the building. Once the user types in and hits enter, the app will call a function that searches the local storage 
for the building name or acronym, if it is not found the app will notify the user in the GUI, otherwise if it is, the function will return 
and another function uses the coordinate data from the object to calculate the path for the user.

Once the navigation data is calculated, the AR function draws the arrow onto the GUI and provides the user with directons to travel. As 
the user navigates, their location is periodically updated on the device and the navigation data is recalculated until the destination is 
reached

Once the destination is reached, the AR function will draw the name of the building on screen so the user can confirm they reached their 
location. At the destination they will have another chance to view information on the building by clicking an on screen element that will 
display the information.
