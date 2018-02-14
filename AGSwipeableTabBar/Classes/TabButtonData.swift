//
//  TabButtonData.swift
//  AGSwipeableTabBar
//
//  Created by Aman Gupta on 06/02/18.
//
import Foundation
import UIKit
let kAGTabBarNormalColor = "normalColor"
let kAGTabBarSelectedColor = "selectedColor"
let kAGTabBarTitleTextFont = "titleFont"
let kAGTabHeaderType = "tabHeaderType"
let kAGTabBarTitleTextArray = "titleTextArray"
let kAGTabBarImageNormalArray = "imageNormalArray"
let kAGTabBarImageSelectedArray = "imageSelectedArray"
let kAGTabBarIconTabWidth = "iconTabWidth"

public enum TabHeaderType {
    case title
    case icon
    case titleAndIcon
}

public class TabButtonData: NSObject {
    
    public var buttonNormalFontColor : UIColor!
    public var buttonSelectedFontColor : UIColor!
    public var buttonTitleTextFont : UIFont!
    public var buttonTitleTextArray = [String]()
    
    public var buttonNormalImageArray = [UIImage]()
    public var buttonSelectedImageArray = [UIImage]()
    public var buttonNormalIconColor : UIColor!
    public var buttonSelectedIconColor : UIColor!
    public var tabHeader = TabHeaderType.title
    public var iconTabWidth : CGFloat! = 50
    
    //Using TabBar Title
    var isTabBarTitle = false
    var isTabBarImages = false
    var isTabBarIconsAndTitle = false
    
    init(tabBarFeturesDictionary: Dictionary<String, Any>) {
        tabHeader = ((tabBarFeturesDictionary[kAGTabHeaderType] != nil) ? (tabBarFeturesDictionary[kAGTabHeaderType] as! TabHeaderType) : .title)
        switch tabHeader {
        case .title :
            buttonTitleTextArray = (tabBarFeturesDictionary[kAGTabBarTitleTextArray] != nil ? tabBarFeturesDictionary[kAGTabBarTitleTextArray] as! Array : [])
            buttonNormalFontColor = ((tabBarFeturesDictionary[kAGTabBarNormalColor] != nil) ? (tabBarFeturesDictionary[kAGTabBarNormalColor] as! UIColor) : UIColor.blue)
            buttonSelectedFontColor = ((tabBarFeturesDictionary[kAGTabBarSelectedColor] != nil) ? (tabBarFeturesDictionary[kAGTabBarSelectedColor] as! UIColor) : UIColor.red)
            buttonTitleTextFont = ((tabBarFeturesDictionary[kAGTabBarTitleTextFont] != nil) ? (tabBarFeturesDictionary[kAGTabBarTitleTextFont] as! UIFont) : UIFont.systemFont(ofSize: 17.0))
        case .icon :
            buttonNormalImageArray = (tabBarFeturesDictionary[kAGTabBarImageNormalArray] != nil ? tabBarFeturesDictionary[kAGTabBarImageNormalArray] as! Array : [])
            buttonSelectedImageArray = (tabBarFeturesDictionary[kAGTabBarImageSelectedArray] != nil ? tabBarFeturesDictionary[kAGTabBarImageSelectedArray] as! Array : [])
            buttonNormalFontColor = ((tabBarFeturesDictionary[kAGTabBarNormalColor] != nil) ? (tabBarFeturesDictionary[kAGTabBarNormalColor] as! UIColor) : UIColor.blue)
            buttonSelectedFontColor = ((tabBarFeturesDictionary[kAGTabBarSelectedColor] != nil) ? (tabBarFeturesDictionary[kAGTabBarSelectedColor] as! UIColor) : UIColor.red)
            iconTabWidth = ((tabBarFeturesDictionary[kAGTabBarIconTabWidth] != nil) ? (tabBarFeturesDictionary[kAGTabBarSelectedColor] as! CGFloat) : 50)
            
        case .titleAndIcon  :
            break
        }
    }
    
}
