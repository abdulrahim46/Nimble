# Nimble

[![CI](https://github.com/abdulrahim46/Nimble/actions/workflows/swift.yml/badge.svg)](https://github.com/abdulrahim46/Nimble/actions/workflows/swift.yml)

![Platform](https://img.shields.io/badge/Platform-iOS-orange.svg)
![Languages](https://img.shields.io/badge/Language-Swift-orange.svg)
![](https://img.shields.io/badge/Alamofire-Networking-red)


## Installation
- Pod install.
- open Nimble.xcworkproj. 
- Select the iphone simulator of your choice & run it. 
- Tested on iOS 14.3, iOS 14.5, iOS 15 ( iphone SE, iphone 12 pro etc), XCode 13, 12.3.


## Design Pattern: Model-View-ViewModel (MVVM)
is a structural design pattern that separates objects into three distinct groups:
- #### Models 
  - hold application data. They’re usually structs or simple classes.
- #### Views 
  - display visual elements and controls on the screen. They’re typically subclasses of UIView.
- #### View models
  - transform model information into values that can be displayed on a view. They’re usually classes, so they can be passed around as references.
  
  ## Requirements
  Application features
  Authentication:
  Implement the login authentication screen.
  Implement the OAuth authentication including the storage of access token.
  Implement the automatic usage of refresh tokens to keep the user logged in using the OAuth API.
  Home Screen:
  On the home screen, each survey card must display the following info:
  Cover image (background)
  Name (in bold)
  Description
  There must be 2 actions:
  Horizontal scroll through the surveys.
  A button “Take Survey” should take the user to the survey detail screen. 
  The list of surveys must be fetched when opening the application.
  Show a loading animation when fetching the list of surveys.
  The navigation indicator list (bullets) must be dynamic and based on the API response.
  
  ### Technical requirements
  Develop the application using:
  Xcode
  Cocoa Pods
  Fastlane
  Target iOS 10.0 and up.
  Use Git during the development process. Push to a public repository on Bitbucket, Github or Gitlab. Make regular commits and merge code using pull requests.
  Write unit tests using your framework of choice.
  Use either the REST or GraphQL endpoints. The choice is yours to make.


## Improvements / Need to be done
- Due to limited time constraints, wrote only few unit Tests and UI tests by using XCTest. Need to cover all unit test.
- Generic networking layer.
- Logout functionality for session flow.
- UI improvements

## Technology/Tools

- iOS 10
- Xcode 12.3
- Swift 5
- UIKit
- Github Actions CI
- Fastlane
- [Alamofire](https://github.com/Alamofire/Alamofire)
- [Alamofiremage]
- Programmaticlly UI
- AutoLayout
- MVVM
- XCTestCase for unit tests and UI Tests.
- Xcode Instruments for memory leaks and allocations.


## 📱 Screenshots

<p float="left"> 
<img src="/Documentation/sim1.png" width="200">
<img src="/Documentation/sim2.png" width="200">
<img src="/Documentation/sim3.png" width="200">
<img src="/Documentation/sim4.png" width="200">
<img src="/Documentation/sim5.png" width="200">
<img src="/Documentation/sim6.png" width="200">
</p>
