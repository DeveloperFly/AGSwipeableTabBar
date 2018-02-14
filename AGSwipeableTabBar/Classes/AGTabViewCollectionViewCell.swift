//
//  AGTabViewCollectionViewCell.swift
//  AGSwipeableTabBar
//
//  Created by Aman Gupta on 06/02/18.
//

import UIKit

class AGTabViewCollectionViewCell: UICollectionViewCell {
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
    
    override var isSelected: Bool {
        didSet {
            buttonTabBar.isSelected = isSelected
            self.reloadInputViews()
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            buttonTabBar.isHighlighted = isHighlighted
        }
    }
    
    func setUpCollectionViewCell() {
        buttonTabBar.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        buttonTabBar.isUserInteractionEnabled = false
        buttonTabBar.backgroundColor = UIColor.clear
//        buttonTabBar.layer.cornerRadius = 20
//        buttonTabBar.layer.borderColor = UIColor.black.cgColor
//        buttonTabBar.layer.borderWidth = 5.0
//        buttonTabBar.layer.masksToBounds = true
        self.contentView.addSubview(buttonTabBar)
    }
    
    //MARK:- ConfigureView Methdos
    func setTabTitleViewButtonData(_ tabButtonData: TabButtonData, indexPath: IndexPath) {
        var title: String!
        if tabButtonData.buttonTitleTextArray.count == 0 {
            title = "Tab \(indexPath.row + 1)"
        } else {
            title = tabButtonData.buttonTitleTextArray[indexPath.row]
        }
        buttonTabBar.setTitle(title, for: .normal)
        buttonTabBar.setTitle(title, for: .selected)
        buttonTabBar.setTitleColor(tabButtonData.buttonNormalFontColor, for: .normal)
        buttonTabBar.setTitleColor(tabButtonData.buttonSelectedFontColor, for: .selected)
        buttonTabBar.titleLabel?.font = tabButtonData.buttonTitleTextFont
    }
    
    func setTabIconViewButtonData(_ tabButtonData: TabButtonData, indexPath: IndexPath) {
        var iconNormal: UIImage!
        var iconSelected: UIImage!

        if tabButtonData.buttonSelectedImageArray.count == 0 {
            iconSelected = UIImage(named: "Home_icon")
        } else {
            iconSelected = tabButtonData.buttonSelectedImageArray[indexPath.row]
        }
        
        if tabButtonData.buttonNormalImageArray.count == 0 {
            iconNormal = UIImage(named: "Home_icon")
        } else {
            iconNormal = tabButtonData.buttonNormalImageArray[indexPath.row]
        }
        buttonTabBar.setImage(iconSelected, for: .selected)
        buttonTabBar.setImage(iconNormal, for: .normal)
        if buttonTabBar.isSelected {
            buttonTabBar.tintColor = tabButtonData.buttonSelectedIconColor
        } else {
            buttonTabBar.tintColor = tabButtonData.buttonNormalIconColor
        }
    }
    
    //MARK: - Action Method
    @objc func tapTabBarrButton(_ sender: UIButton) {
        return
    }
    
}

