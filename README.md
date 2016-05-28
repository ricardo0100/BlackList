![dooit](icon/small-icon.png)

[![Build Status](https://travis-ci.org/ricardo0100/dooit.svg?branch=master)](https://travis-ci.org/ricardo0100/dooit)
[![codecov](https://codecov.io/gh/ricardo0100/dooit/branch/master/graph/badge.svg?precision=2)](https://codecov.io/gh/ricardo0100/dooit)
[![Code Climate](https://codeclimate.com/github/ricardo0100/dooit/badges/gpa.svg)](https://codeclimate.com/github/ricardo0100/dooit)

### What is this?

### Project Structure

### Technologies

### Tests and CI

### Data Model
#### version: 1
- List
  - __title__: String
  - __items__: [Item]
- Item
  - __title__: String
  - __marked__: Bool

#### version: 2

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
