# MVVMTemplate
## Project Highlights

### MVVM architecture   
MVVM (Model-View-ViewModel) is derived from MVC(Model-View-Controller). It is introduced to solve existing problems of Cocoa's MVC architecture in iOS world. One of its feature is to make a better separation of concerns so that it is easier to maintain and extend.   
Key Features: Distribution, Testability, Reusability
* Model: It is similar to model layer in MVC (contains data business logic)
* View: UIViews + UIViewControllers (We treat both layout view and controllers as View)
* ViewModel: A mediator to glue above two layers together.

### ImageCache  
With ImageCache, we can optimize the image loading within an app and enhance user experience. After all, loading images from cache should be always faster than getting ones from the network.

### Infinite Scrolling: Requesting Next Pages  
We need to modify the view model code to request the next pages of the API. Here’s an overview of what we need to do:
* Keep track of the last page received so that we know which page is needed next when the UI calls the request method
* Build the full list of feed. When we receive a new page from the API, we have to add it to our feed’s list (instead of replacing it). When we get a response, can update the table view to include all of the feeds received thus far.

### SwiftLint
SwiftLint is an open source tool to enforce Swift style and conventions. It is developed by Realm. You can set your coding style rules and force them during development. SwiftLint has a command line tool, Xcode plugin, AppCode and Atom integration. So, it always fits your development environment. It’ll show you warnings and/or errors if you violate the linting rules.    
Configuring linting is handled from the .swiftlint.yml file. This file sits in project’s main path. We can enable, disable or write custom rules in this YML file.

### Reachability
This is a drop-in replacement for Apple's Reachability class. It is ARC-compatible, and it uses the new GCD methods to notify of network interface changes.   
In addition to the standard NSNotification, it supports the use of blocks for when the network becomes reachable and unreachable.

### XCTest
#### Unit Testing
The unit tests should cover Core functionality of Model classes and methods and their interactions with the controller.    
Use XCTAssert and related functions to verify your tests produce the correct results.

#### UI Testing
UI testing lets you test interactions with the User interface. UI testing works by finding an app’s UI objects with queries, synthesizing events, and then sending the events to those objects. The API enables you to examine a UI object’s properties and state in order to compare them against the expected state.   
Use recording to get started writing UI tests.   
Use XCTAssert and related functions to verify your tests produce the correct results.

#### Performance Testing
A performance test takes a block of code that you want to evaluate and runs it ten times, collecting the average execution time and the standard deviation for the runs. The averaging of these individual measurements form a value for the test run that can then be compared against a baseline to evaluate success or failure.   
It’s very simple to write a performance test: You just place the code you want to measure into the closure of the measure().
