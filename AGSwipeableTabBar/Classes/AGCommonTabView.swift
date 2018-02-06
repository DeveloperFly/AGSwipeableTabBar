//
//  AGCommonTabView.swift
//  AGSwipeableTabBar
//
//  Created by Aman Gupta on 06/02/18.
//

import UIKit
@IBDesignable

open class AGCommonTabView: UIControl {

    //MARK: - Custom Views
    open var tabCollectionView = UICollectionView()
    open var detailCollectionView = UICollectionView()
    
    //MARK: - Variables
    @IBInspectable var heightTabCollectionPerportional: CGFloat = 0.07 {
        didSet {
            self.tabCollectionView.frame.size.height = UIScreen.main.bounds.size.height * heightTabCollectionPerportional
            self.detailCollectionView.frame.size.height = (UIScreen.main.bounds.size.height - (UIScreen.main.bounds.size.height * heightTabCollectionPerportional))
        }
    }
    
    @IBInspectable var numberOfitemInSection: Int = 2 {
        didSet {
            
        }
    }

    
    //MARK:- Overloaded Methods
    override open func draw(_ rect: CGRect) {
        // Drawing code
        setupCollectionView()
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override init(frame: CGRect) {
        // Call super init
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        // 1. setup any properties here
        
        // 2. call super.init(coder:)
        super.init(coder: aDecoder)
    }
    
    func setupCollectionView() {
        drawTabCollectionView()
        drawDetailCollectionView()
    }
    
    func drawTabCollectionView() {
        self.tabCollectionView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height * heightTabCollectionPerportional)
        self.addSubview(tabCollectionView)

    }
    
    func drawDetailCollectionView() {
        self.detailCollectionView.frame = CGRect(x: 0, y: UIScreen.main.bounds.size.width * heightTabCollectionPerportional, width: UIScreen.main.bounds.size.width, height: (UIScreen.main.bounds.size.height - (UIScreen.main.bounds.size.height * heightTabCollectionPerportional)))
        self.addSubview(detailCollectionView)
    }
    
    
    //MARK: - Update Methods
    func updateTabCollectionViewHeight() {
    }
    
    
}


