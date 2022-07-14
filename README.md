# Pirate Ships app
### Created by Gaetano Cerniglia on December 2020.
###  Copyright © 2020 Gaetano Cerniglia. All rights reserved.

## This app includes:
    - Parse data from ​https://raw.githubusercontent.com/gaecer/SampleProject1/main/pirates.json
    - First (main) screen: 
        - display a list of pirate ships * display the ships in a UICollectionView
        - show image, title & price
    - Second screen:
        - ship details
        - this screen opens when the user selects a ship from the list * show image, title, description, price
    - There are 4 types of greetings for a pirate ship, defined by the property "greeting_type". 
        - "ah" -> "Ahoi!" (default)
        - "ay" -> "Aye Aye!"
        - "ar" -> "Arrr!"
        - "yo" -> "Yo ho hooo!"

## Tech notes

    - Language Swift 5
    - Support iOS: 13.0+
    - Use of UIKit programmatically, without storyboard or Xib
    - Pattern: MVVM-C
    - Combine Apple Framework is used to bind the Model with the UI
    - Apple NSCache is used to manage the Cache
    - Approach: SOLID
    - Dependency Manager: No Dependency
    - Unit test
    - UI test
    
## Features

    = there is a button that displays a simple greeting with the greeting defined by "greeting_type" for each pirate ship
    - swiping down on the collection view will reload the data
    
## Additional information

    - The app handles errors and responses with completion escape blocks and enumerations
    - The cache is managed by the NSCache class, configured with a limit that controls any memory warnings
    - MVVM-C design model applied following a SOLID approach
    - UI tests are in a different scheme to speed up the normal work-flow
    - There is an Active Compilation Condition, in PirateShipsTests Target to switch from online to offline data during testing
    - The whole network layer is wrapped in the NetworkFramework, to be isolated from the project and easily reused in another project
    
## Improvements
    
    - We may use a database to store the results before closing the app
    - All the classes should be mocked to improve the quality of the tests
    - Tests should cover 100% of the app
    - Images can be optimized before saved
    - Some animations could improve the UX
    - The coordinator can be improved to handle larger UI
    - Mocked offline data for testing can be handled more generally 
