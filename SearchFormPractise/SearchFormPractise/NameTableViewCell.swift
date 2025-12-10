//
//  NameTableViewCell.swift
//  SearchFormPractise
//
//  Created by Jolly Gupta on 9/27/25.
//

import UIKit

class NameTableViewCell: UITableViewCell {
    
    @IBOutlet weak var FirstLabel: UILabel!
    
    @IBOutlet weak var SecondLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
