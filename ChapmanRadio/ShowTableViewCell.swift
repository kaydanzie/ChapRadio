//
//  ShowTableViewCell.swift
//  ChapRadio
//
//  Created by Kayla Ziegler on 5/8/16.
//  Copyright © 2016 Ziegler, Kayla. All rights reserved.
//

import UIKit

class ShowTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = UITableViewCellSelectionStyle.none
        
        self.textLabel?.textColor = UIColor.white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func initWithShow(_ name : String, time: String) {
        self.nameLabel.adjustsFontSizeToFitWidth = true
        self.nameLabel.text! = name
        self.timeLabel.text! = time
    }
    
}
