//
//  TemplateCollectionViewCell.swift
//  FeastVitePOC
//
//  Created by student on 6/13/19.
//  Copyright © 2019 NWMSU. All rights reserved.
//

import UIKit

class TemplateCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var templateNameLBL: UILabel!
    @IBOutlet weak var templatePreviewImage: UIImageView!
    
    @IBOutlet weak var checkMarkLBL: UILabel!
    @IBAction func deleteBTN(_ sender: Any) {
    }
    
    var isInEditingMode: Bool = false {
        didSet {
            checkMarkLBL.isHidden = !isInEditingMode
        }
    }
    override var isSelected: Bool {
        didSet {
            if isInEditingMode {
                checkMarkLBL.text = isSelected ? "✓" : ""
            }
        }
    }
}
