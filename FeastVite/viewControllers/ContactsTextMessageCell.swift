//
//  OtherTextMessageCell.swift
//  FeastVitePOC
//
//  Created by pradeep Kolli on 10/1/19.
//  Copyright © 2019 NWMSU. All rights reserved.
//

import UIKit

class ContactsTextMessageCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
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
