//
//  AGTabViewCollectionViewCell.swift
//  AGSwipeableTabBar
//
//  Created by Aman Gupta on 06/02/18.
//

import UIKit

class AGTabViewCollectionViewCell: UICollectionViewCell {
//    open var collectionViewCell = UICollectionViewCell()
    open var buttonTabBar = UIButton()
    
    override func layoutSubviews() {
        setUpCollectionViewCell()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpCollectionViewCell() {
        buttonTabBar.frame = CGRect(x: 2, y: 0, width: self.frame.size.width - 4, height: self.frame.size.height)
        buttonTabBar.addTarget(self, action: #selector(tapTabBarrButton), for: .touchUpInside)
        buttonTabBar.setTitle("tab", for: .normal)
        self.contentView.addSubview(buttonTabBar)
    }
    
    //MARK:- ConfigureView Methdos
    func setTabTitleViewButtonData(_ tabButtonData: TabButtonData, indexPath: IndexPath) {
        var title: String!
//        if tabButtonData.buttonTitleTextArray.count == 0 {
//            title = "Tab \(indexPath.row + 1)"
//        } else {
//            title = tabButtonData.buttonTitleTextArray[indexPath.row]
//        }
//        buttonTabBar.setTitle(title, for: .normal)
//        buttonTabBar.setTitle(title, for: .selected)
//        buttonTabBar.setTitleColor(tabButtonData.buttonNormalFontColor, for: .normal)
//        buttonTabBar.setTitleColor(tabButtonData.buttonSelectedFontColor, for: .selected)
//        buttonTabBar.titleLabel?.font = tabButtonData.buttonTitleTextFont
    }
    
    func setTabIconViewButtonData(_ tabButtonData: TabButtonData, indexPath: IndexPath) {
        var icon: UIImage!
//        if tabButtonData.buttonImageArray.count == 0 {
//            icon = UIImage(named: "Home_icon")
//        } else {
//            icon = tabButtonData.buttonImageArray[indexPath.row]
//        }
//        buttonTabBar.setImage(icon, for: .normal)
//        if buttonTabBar.isSelected {
//            buttonTabBar.tintColor = tabButtonData.buttonSelectedFontColor
//        }
    }
    
    @objc func tapTabBarrButton(_ sender: UIButton) {
        
    }
    
}
