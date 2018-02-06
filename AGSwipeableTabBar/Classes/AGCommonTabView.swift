//
//  AGCommonTabView.swift
//  AGSwipeableTabBar
//
//  Created by Aman Gupta on 06/02/18.
//

import UIKit
import Foundation

public protocol CommonTabDelegate : class {
    func cellForItemForDetailView(atIndex indexPath: IndexPath) -> UICollectionViewCell
    func collectionViewCurrentPage(_ currentPage: Int)
}

@IBDesignable
open class AGCommonTabView: UIControl {
    open weak var delegate: CommonTabDelegate?

    //MARK: - Custom Views
    open var tabCollectionView: UICollectionView!
    open var detailCollectionView: UICollectionView!
    
    //MARK: - Variables
    private let agTabViewCellIdentifier = "AGTabViewCollectionViewCell"
    
    @IBInspectable var heightTabCollectionPerportional: CGFloat = 0.07 {
        didSet {
        }
    }
    
    @IBInspectable var numberOfitemInSection: Int = 2 {
        didSet {
            
        }
    }
    
    //MARK:- Overloaded Methods
    override init(frame: CGRect) {
        // Call super init
        super.init(frame: frame)
        setupCollectionView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        // 1. setup any properties here
        
        // 2. call super.init(coder:)
        super.init(coder: aDecoder)
        setupCollectionView()
    }
    
    func setupCollectionView() {
        drawTabCollectionView()
        drawDetailCollectionView()
    }
    
    func drawTabCollectionView() {
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height * 0.07 )
        self.tabCollectionView = UICollectionView(frame: frame, collectionViewLayout: flowLayout)
        self.tabCollectionView.backgroundColor = UIColor.red
        tabCollectionView.register(AGTabViewCollectionViewCell.self, forCellWithReuseIdentifier: agTabViewCellIdentifier)
        tabCollectionView.delegate = self
        tabCollectionView.dataSource = self
        self.addSubview(tabCollectionView)

    }
    
    func drawDetailCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let frame = CGRect(x: 0, y: UIScreen.main.bounds.size.height * heightTabCollectionPerportional, width: UIScreen.main.bounds.size.width, height: (UIScreen.main.bounds.size.height - (UIScreen.main.bounds.size.height * heightTabCollectionPerportional)))
        self.detailCollectionView = UICollectionView(frame: frame, collectionViewLayout: flowLayout)
        self.detailCollectionView.isPagingEnabled = true
        self.detailCollectionView.delegate = self
        self.detailCollectionView.dataSource = self
        self.detailCollectionView.backgroundColor = UIColor.green
        self.addSubview(detailCollectionView)
    }
    
    
    //MARK: - Update Methods
    func updateTabCollectionViewHeight() {
    }
    
}

//MARK:- CollectionView Data Source methods
extension AGCommonTabView: UICollectionViewDataSource {
    
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfitemInSection
    }
    
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case tabCollectionView:
            return getCell(forTabCollectionView: collectionView, indexPath: indexPath)
        case detailCollectionView:
            return getCell(forDetailCollectionView: collectionView, indexPath: indexPath)
        default :
            break
        }
        return UICollectionViewCell()
    }
    
    func getCell(forTabCollectionView collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = tabCollectionView.dequeueReusableCell(withReuseIdentifier: agTabViewCellIdentifier, for: indexPath) as! AGTabViewCollectionViewCell
        
        //        if isIntialSelectedTab {
        //            bottomView.frame = CGRect.init(x: (cell.frame.origin.x), y: tabCollectionView.frame.size.height - 5, width: (tabBarData.buttonTitleTextArray.count == 0 ? getWidthForCell(withMessage: "Tab \(indexPath.item + 1)") : (getWidthForCell(withMessage: tabBarData.buttonTitleTextArray[indexPath.row]) + 5)), height: bottomBarHeight)
        //            isIntialSelectedTab = false
        //        }
//        switch  tabBarData.tabHeader {
//        case .title:
//            cell.setTabTitleViewButtonData(tabBarData, indexPath: indexPath)
//        case .icon:
//            cell.setTabIconViewButtonData(tabBarData, indexPath: indexPath)
//        case .titleAndIcon :
//            break
//        }
        return cell
    }
    
    func getCell(forDetailCollectionView collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        return (delegate?.cellForItemForDetailView(atIndex: indexPath))!
    }
}

extension AGCommonTabView: UICollectionViewDelegate {
    
}

//MARK:- Collection View DelegateFlowLayout methods
extension AGCommonTabView {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView.isEqual(tabCollectionView) {
            return 0
        }
        return 0
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView.isEqual(tabCollectionView) {
            return 0
        }
        return 0
    }

}

extension AGCommonTabView: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == tabCollectionView {
            return CGSize(width: CGFloat(Float(tabCollectionView.frame.size.width) / Float(numberOfitemInSection)), height: CGFloat(tabCollectionView.frame.size.height))
        }
        return CGSize(width: UIScreen.main.bounds.width , height: detailCollectionView.frame.size.height)
    }
    
}
