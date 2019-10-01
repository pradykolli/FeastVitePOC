//
//  MyTextMessageCell.swift
//  FeastVitePOC
//
//  Created by pradeep Kolli on 10/1/19.
//  Copyright © 2019 NWMSU. All rights reserved.
//

import UIKit

class MyTextMessageCell: UITableViewCell {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.textView.layer.borderColor = UIColor.white.cgColor
        self.textView.layer.borderWidth = 1
        self.textView.layer.cornerRadius = 10
        self.textView.translatesAutoresizingMaskIntoConstraints = false
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
