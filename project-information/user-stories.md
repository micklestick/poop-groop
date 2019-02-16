# Goals / User Stories

| Story ID | User Story | Goals | Requirements |
|-|-|-|-|
| 000 | As a student, I need to find the building containing my next class. | 001.0, 000 | 006 |
| 001 | As a student, I need to find the closest parking lot to my destination because I am in a hurry. | 002 | 000 |
| 002 | As a student, I need to determine which building I am looking at because the sign may not be in view. | 000 | 005 |
| 003 | As a student, I need to know how long it will take to reach the destination because I need to schedule my time. | 001.1 | 002 |
| 004 | As a student, I need to know the current distance to my destination because I need to choose appropriate transportation. | 001.1 | 002 |
| 005 | As a student, I need to select destinations from a list of favorites because it will save me time. | 003 | 003 |
| 006 | As a student, I need destinations to auto-complete because it will reduce typing. | 003 | 001 |
| 007 | As a student, I know I need to know which restaurants are in a building because it will help me find the restaurant I want to eat at. | 000 | 006 |
| 008 | As a student, I need to find the building containing a store I want to visit. | 001.0, 000 | 006 |
| 009 | As a student, I need the app to automatically find my location because I want my navigation to be accurate. | 004 | 009 |
| 010 | As a student, I want the app to have an icon because I want to idenitify it easily. | 010 | 010 |
| 011 | As a student, I want the app to have a launch screen because I want loading to feel faster | 011 | 011 |
| 012 | As a student, I want to search for resutarants around campus because I want to easily find somewhere to eat. | 013 | 013 |
| 013 | As a student, I want to search for stores around campus because I want to find where I can buy supplies. | 013 | 014 |
| 014 | As a student, I want to be able to change my destination during navigation so I can meet my friends. | 002.2, 002.3 | 015 |

| XXX | As an X, I need to Y because Z | TBD | TBD |

| Goal ID | Goal Description | Requirements |
|-|-|-|
| 000 | The application should provide users with basic information about nearby buildings. | 006, 005 |
| 001.0 | The application should provide users with directions to their destination. | 006 |
| 001.1 | The application should provide users metadata on the directions provided. i.e. Estimated time to destination. | 002 |
| 002.0 | The application should allow users to select a transportation method. | 000 |
| 002.1 | The application should direct user's to a convientent spot to store their transportation. i.e. A bike rack, or a parking lot. | TBD |
| 002.2 | The application should take account of the user's transportation's speed when providing directions. For instance, since cars are fast than walking, the nearest parking lot should be selected to minimize travel time. | TBD |
| 002.3 | The application should allow the user to override the aforementioned, should they so choose. i.e. Users should be allowed to select a sub-optimal parking lot so they can meet friends. | 014 |
| 003 | The application should provide ease of use functionality to increase user convience. | 001, 003 |
| 004 | The application should have the neccesary infrastructure to support implementation of other goals. | 007 |
| 005 | The application should store location data on stores around campus. | 013 |

TODO: Turn this all into a database and generate the view with a shell script (including cross references).
