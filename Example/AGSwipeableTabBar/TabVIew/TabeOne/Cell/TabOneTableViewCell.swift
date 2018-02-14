//
//  TabOneTableViewCell.swift
//  AGswipeableTabBar
//
//  Created by Aman Gupta on 18/07/17.
//  Copyright © 2017 aman19ish. All rights reserved.
//

import UIKit

class TabOneTableViewCell: UITableViewCell {

    //MARK:- IBOutlets
    @IBOutlet weak var label: UILabel!
    
    //MARK:- Cell Methods
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK:- Configure Cell
    func configureCell(_ indexPath: IndexPath, indexPathCollectionCell: IndexPath) {
        label.text = "Label \(indexPath.row + 1) = cell \(indexPathCollectionCell.row + 1)"
    }
    
}
