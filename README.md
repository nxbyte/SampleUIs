# iOS-Template-Code

Some interesting iOS prototypes and template code that I tinkered with in the past

![platforms](https://img.shields.io/badge/platform-ios-lightgrey.svg?style=flat)
[![DUB](https://img.shields.io/dub/l/vibe-d.svg)]()

# Requirements

- OS X 10.11+ (El Capitan or newer)
- iOS 8+
- Xcode 7.3+ (with Swift 2.3 support)

## User Interface Prototypes

- **UITableView Template**: An iOS project with a simple implementation of UITableView

- **Parallax UITableView Example**: An iOS project with moving UIImages while scrolling the UITableView

- **UICollectionView Template**: An iOS project with a simple implementation of UICollectionView


## Data Structures / Algorithms
- **A Struct Template**: A playground that shows off a simple implementation of a struct and how one can serialize and de-serialize elements.


## Swift Source
- **Core Data**: A folder of swift source files that communicates with the Core Data stack.

##### Some notes about Core Data
1. Make sure to include the Core Data helper class from the code section of this repository
2. Use scalar properties whenever possible
3. After creating the object graph and exporting the subclass, refactor and extend the helper class, in another file, with code related to the object graph
4. Make sure to save!
5. (One-Many relationships) If you want to associate a parent for a child object then set the child's parent to the parent object.



# License

All sample and template source in this repository is released under the MIT license. See LICENSE for details.