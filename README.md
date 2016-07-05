![dooit](icon/small-icon.png)

[![Build Status](https://travis-ci.org/ricardo0100/dooit.svg?branch=master)](https://travis-ci.org/ricardo0100/dooit)
[![codecov](https://codecov.io/gh/ricardo0100/dooit/branch/master/graph/badge.svg?precision=2)](https://codecov.io/gh/ricardo0100/dooit)
[![Code Climate](https://codeclimate.com/github/ricardo0100/dooit/badges/gpa.svg)](https://codeclimate.com/github/ricardo0100/dooit)

### What is this?

This is a MVVM based project used for practicing iOS development including the following concepts:
- Core Data
- Presentation Controllers
- Unit Testing
- UI Testing
- Auto Layout
- Size Classes
- UIKit
- Publication in App Store including TestFlight

The app goal is to be a simple, but awesome, to do list app.

### Project Structure
- **Model**: Data model and some data rules validation
- **ViewModel**: Business rules
- **View**: View Controllers and Views
- **Dependency manager**: For now I'm trying not to use external libraries so I can learn the core concepts. But I'll probably have to use CocoaPods or Carthage soon

### Tests and CI

All the business rules are contained in the ViewModel layer and unit tested. The View layer is going to be test covered by the XCode UI Tests.

The goal is 100% test coverage 🎯

Travis CI is used for Continuous Integration

Codecov for test coverage analysis

Code Climate for code quality

### Future

- [ ] UI improvements for iPad
- [ ] Animations
- [ ] Custom colors defined by the user
- [ ] Alarms
- [ ] Integration with REST API

### Data Model

Core Data is used for persistence and migrations. The model evolution is represented bellow:

##### Version 1
- List
  - __title__: String
  - __items__: [Item]
- Item
  - __title__: String
  - __marked__: Bool

##### Version 2

  - List
    - __title__: String
    - __items__: [Item]
    - __updateTime__: NSDate
    - __creationTime__: NSDate
  - Item
    - __title__: String
    - __marked__: Bool
    - __updateTime__: NSDate
    - __creationTime__: NSDate
