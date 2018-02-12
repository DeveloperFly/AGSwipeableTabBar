# AGSwipeableTabBar

[![CI Status](http://img.shields.io/travis/DeveloperFly/AGSwipeableTabBar.svg?style=flat)](https://travis-ci.org/DeveloperFly/AGSwipeableTabBar)
[![Version](https://img.shields.io/cocoapods/v/AGSwipeableTabBar.svg?style=flat)](http://cocoapods.org/pods/AGSwipeableTabBar)
[![License](https://img.shields.io/cocoapods/l/AGSwipeableTabBar.svg?style=flat)](http://cocoapods.org/pods/AGSwipeableTabBar)
[![Platform](https://img.shields.io/cocoapods/p/AGSwipeableTabBar.svg?style=flat)](http://cocoapods.org/pods/AGSwipeableTabBar)

## Example
![Example](https://github.com/DeveloperFly/AGSwipeableTabBar/blob/master/Example/Resources/Images/Simulator%20Screen%20Shot%20-%20iPhone%208%20Plus%20-%202018-02-09%20at%2015.25.28.png)

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

AGSwipeableTabBar is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'AGSwipeableTabBar'
```

## Example for assign the AGCommonTabView 
![Example](https://github.com/DeveloperFly/AGSwipeableTabBar/blob/master/Example/Resources/Images/Screen%20Shot%202018-02-09%20at%202.50.56%20PM.png)

## Properties which are Directly set by storyborad 
* heightTabViewPerportional :- Set the height of tab view with repect to your view.
* tabBottomBarHeight: - Set the height of Tab view bottom bar.
* numberOfitemInSection: - Pass the numer of tabs you want.
* intialSelectedTab: - Pass the index which you want pre selected.
* isShowBottomTabBar: - Set the Bool value Tab view bottom bar is shown or not.


![Exapmle](https://github.com/DeveloperFly/AGSwipeableTabBar/blob/master/Example/Resources/Images/Screen%20Shot%202018-02-09%20at%202.51.32%20PM.png)


## Properties which are directly set by view Instance 
``` swift
 let arrayTitle = ["TableView", "CollectionView", "View", "Button", "Label", "SegmentedController", "switch", "progressView", "Container", "commonView"]
 @IBOutlet weak var tabView: AGCommonTabView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabView.detailCollectionView.register(UINib.init(nibName: "TabOneCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TabOneCollectionViewCell")
        tabView.delegate = self
        tabView.isShowBottomTabBar = true
        tabView.tabBottomBarHeight = 2
        tabView.tabBarData.buttonTitleTextArray = arrayTitle
        tabView.tabBarData.tabHeader = .title
        tabView.tabBarData.buttonNormalFontColor = UIColor.black
        tabView.initialSelectedTab(index: 1)
    }
```

## Delegate methods (CommonTabDelegate)
```swift
 func cellForItemForDetailView(atIndex indexPath: IndexPath) -> UICollectionViewCell
 func collectionViewCurrentPage(_ currentPage: Int)
```

## Author

aman19ish@gmail.com

## License

MIT License

Copyright (c) 2018 Developer Fly

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
