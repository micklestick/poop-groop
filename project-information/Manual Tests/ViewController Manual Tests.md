### Manual Test for Search Button

| Step | Action | Observation |
|-|-|-|
| 1 | Launch the application from the home screen. | The application opens to the main Augmented Reality View.|
| 2 | Press on the magnifying glass icon in the top right corner. | The app transitions to the search screen. |
| 3 | Verify the search screen is active. | The screen should show a search bar at the top with a list of all available buildings below it. |

### Manual Test for trackLocation()

| Step | Action | Observation |
|-|-|-|
| 1 | Launch the application from the home screen. | The application opens to the main Augmented Reality View.|
| 2 | Verify lattitude/longitude labels are populated. | The lattitude/longitude labels at the bottom of the screen display your current latitude/longitude. |
| 3 | Verify lattitude/longitude labels are correct. | Navigate to https://www.maps.ie/coordinates.html and make sure the lattitude/longitude labels in the app match with the website's lattitude/longitude.|

### Manual Test for drawBuildingNode()

| Step | Action | Observation |
|-|-|-|
| 1 | Launch the application from the home screen. | The application opens to the main Augmented Reality View.|
| 2 | Move the phone and camera around. | Different building tags are located above buildings around UCF containing the names of buildings.|
| 3 | Point the phone at the Reflection Pond. | A node appears above the Reflection pond in 3D space.|
| 4 | Verify node is correctly displaying. | The node should be in a blue, rounded rectangle with the words "Reflection Pond" above it.|
| 5 | Point the phone away from the Reflection Pond. | The "Reflection Pond" node disappears out of view as you turn away.|

### Manual Test for addBuildingTags()

| Step | Action | Observation |
|-|-|-|
| 1 | Launch the application from the home screen. | The application opens to the main Augmented Reality View.|
| 2 | Move the phone and camera around. | Different building tags are located above buildings around UCF containing the names of buildings.|
| 3 | Point the phone at the Reflection Pond. | A node appears above the Reflection pond in 3D space.|
| 4 | Walk 100 meters away from the Reflection Pond. | The node disappears off of the screen once you are over 100 meters away.|
